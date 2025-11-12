// ignore_for_file: use_super_parameters

import 'package:doan_clean_achitec/modules/history_tour/tour_history_detail/comment_controller.dart';
import 'package:doan_clean_achitec/modules/home/home_controller.dart';
import 'package:doan_clean_achitec/shared/constants/constants.dart';
import 'package:doan_clean_achitec/shared/utils/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as tago;

import '../../../dark_mode.dart';
import '../../../shared/constants/app_style.dart';

// ignore: must_be_immutable
class CommentTourSeeScreen extends StatelessWidget {
  final String id;
  CommentTourSeeScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  CommentTourController commentController = Get.put(CommentTourController());
  final HomeController homeController = Get.put(HomeController());
  AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    commentController.updatePostId(id);

    return Scaffold(
      appBar: CustomAppBar(
        iconBgrColor: ColorConstants.lightBackground,
      ),
      backgroundColor: appController.isDarkModeOn.value
          ? ColorConstants.darkBackground
          : ColorConstants.lightBackground,
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Expanded(
                child: Obx(
                  () {
                    return ListView.builder(
                      itemCount: commentController.comments.length,
                      itemBuilder: (context, index) {
                        final comment = commentController.comments[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(comment.profilePhoto),
                          ),
                          title: Row(
                            children: [
                              Text(
                                "${comment.username}  ",
                                style: AppStyles.blue000Size16Fw600FfMont,
                              ),
                              Expanded(
                                child: Text(
                                  comment.comment,
                                  style: appController.isDarkModeOn.value
                                      ? AppStyles.white000Size14Fw400FfMont
                                      : AppStyles.black000Size14Fw400FfMont,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                tago.format(
                                  comment.datePublished.toDate(),
                                ),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: appController.isDarkModeOn.value
                                      ? ColorConstants.gray400
                                      : ColorConstants.kTextColor,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${comment.likes.length} likes',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: appController.isDarkModeOn.value
                                      ? ColorConstants.gray400
                                      : ColorConstants.kTextColor,
                                ),
                              )
                            ],
                          ),
                          trailing: InkWell(
                            onTap: () =>
                                commentController.likeComment(comment.id),
                            child: Icon(
                              Icons.favorite,
                              size: 25,
                              color: comment.likes.contains(
                                      homeController.userModel.value?.id)
                                  ? Colors.red
                                  : ColorConstants.accent1,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
