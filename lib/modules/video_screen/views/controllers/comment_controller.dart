import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/models/video/comment.dart';
import 'package:doan_clean_achitec/modules/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentController extends GetxController {
  final Rx<List<Comment>> _comments = Rx<List<Comment>>([]);
  List<Comment> get comments => _comments.value;
  final HomeController homeController = Get.put(HomeController());
  final TextEditingController commentEditingController =
      TextEditingController();
  FocusNode commentFocusNode = FocusNode();

  String _postId = "";

  updatePostId(String id) {
    _postId = id;
    getComment();
  }

  getComment() async {
    _comments.bindStream(
      FirebaseFirestore.instance
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .snapshots()
          .map(
        (QuerySnapshot query) {
          List<Comment> retValue = [];
          for (var element in query.docs) {
            retValue.add(Comment.fromSnap(element));
          }
          return retValue;
        },
      ),
    );
  }

  postComment(String commentText) async {
    try {
      if (commentText.isNotEmpty) {
        var allDocs = await FirebaseFirestore.instance
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .get();
        int len = allDocs.docs.length;

        Comment comment = Comment(
          username: homeController.userModel.value?.firstName ?? "",
          comment: commentText.trim(),
          datePublished: DateTime.now(),
          likes: [],
          profilePhoto: homeController.userModel.value?.imgAvatar ?? "",
          uid: homeController.userModel.value?.id ?? "",
          id: 'Comment $len',
        );
        await FirebaseFirestore.instance
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .doc('Comment $len')
            .set(
              comment.toJson(),
            );
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('videos')
            .doc(_postId)
            .get();
        await FirebaseFirestore.instance
            .collection('videos')
            .doc(_postId)
            .update({
          'commentCount': (doc.data()! as dynamic)['commentCount'] + 1,
        });
      }
    } catch (e) {
      Get.snackbar(
        'Error While Commenting',
        e.toString(),
      );
    }
  }

  likeComment(String id) async {
    var uid = homeController.userModel.value?.id;
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('videos')
        .doc(_postId)
        .collection('comments')
        .doc(id)
        .get();

    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await FirebaseFirestore.instance
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await FirebaseFirestore.instance
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }
}
