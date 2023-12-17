// ignore_for_file: must_be_immutable, use_super_parameters

import 'package:doan_clean_achitec/modules/home/home_controller.dart';
import 'package:doan_clean_achitec/shared/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as tago;

import '../../../../dark_mode.dart';
import '../../../../shared/constants/app_style.dart';
import '../controllers/comment_controller.dart';

class CommentScreen extends StatelessWidget {
  final String id;
  CommentScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  CommentController commentController = Get.put(CommentController());
  final HomeController homeController = Get.put(HomeController());
  AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    commentController.updatePostId(id);

    return Scaffold(
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
                child: Obx(() {
                  return ListView.builder(
                      itemCount: commentController.comments.length,
                      itemBuilder: (context, index) {
                        final comment = commentController.comments[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.black,
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
                      });
                }),
              ),
              const Divider(),
              ListTile(
                title: TextFormField(
                  controller: commentController.commentEditingController,
                  style: TextStyle(
                    fontSize: 16,
                    color: appController.isDarkModeOn.value
                        ? ColorConstants.gray400
                        : ColorConstants.kTextColor,
                  ),
                  decoration: InputDecoration(
                    labelText: StringConst.comment.tr,
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: appController.isDarkModeOn.value
                          ? ColorConstants.gray400
                          : ColorConstants.kTextColor,
                      fontWeight: FontWeight.w700,
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                trailing: TextButton(
                  onPressed: () {
                    commentController.postComment(
                      commentController.commentEditingController.text,
                    );
                    commentController.commentEditingController.clear();
                    FocusScope.of(context).unfocus();
                  },
                  child: Text(
                    StringConst.send.tr,
                    style: TextStyle(
                      fontSize: 16,
                      color: appController.isDarkModeOn.value
                          ? ColorConstants.gray400
                          : ColorConstants.kTextColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
