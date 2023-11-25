import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/models/user/user_model.dart';
import 'package:doan_clean_achitec/modules/home/home_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart';

import '../../../../models/video/video.dart';

class UploadVideoController extends GetxController {
  final HomeController homeController = Get.put(HomeController());

  _compressVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(
      videoPath,
      quality: VideoQuality.MediumQuality,
    );
    return compressedVideo!.file;
  }

  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    Reference ref = FirebaseStorage.instance.ref().child('videos').child(id);

    SettableMetadata metadata = SettableMetadata(contentType: 'video/mp4');

    UploadTask uploadTask =
        ref.putFile(await _compressVideo(videoPath), metadata);
    TaskSnapshot snap = await uploadTask;

    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }

  _getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  Future<String> uploadImageToStorage(String id, String videoPath) async {
    Reference ref =
        FirebaseStorage.instance.ref().child('thumbnails').child(id);
    SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');

    UploadTask uploadTask =
        ref.putFile(await _getThumbnail(videoPath), metadata);
    await uploadTask;
    String resultUpload = await getImageStorage(ref.fullPath);
    return resultUpload;
  }

  Future<String> getImageStorage(String nameImage) async {
    Reference ref = FirebaseStorage.instance.ref().child(nameImage);
    try {
      final result = await ref.getMetadata();

      // ignore: unnecessary_null_comparison
      if (result != null) {
        String downloadUrl = await ref.getDownloadURL();
        return downloadUrl;
      } else {
        return '';
      }
    } catch (e) {
      return '';
    }
  }

  // upload video
  uploadVideo(String songName, String caption, String videoPath) async {
    try {
      String uid = homeController.userModel.value?.id ?? "";

      var uuid = const Uuid();

      String videoUrl = await _uploadVideoToStorage(uuid.v4(), videoPath);
      String? thumbnail = await uploadImageToStorage(uuid.v4(), videoPath);

      Video video = Video(
        username: homeController.userModel.value?.firstName ?? "user",
        uid: uid,
        id: uuid.v4(),
        likes: [],
        commentCount: 0,
        shareCount: 0,
        songName: songName,
        caption: caption,
        videoUrl: videoUrl,
        profilePhoto: homeController.userModel.value?.imgAvatar ??
            "https://firebasestorage.googleapis.com/v0/b/doan-final-travel.appspot.com/o/assets%2Fsystem%2Fic_nodata.png?alt=media&token=51128304-2989-4d9e-84b2-81155f0d06f8",
        thumbnail: thumbnail,
      );

      await FirebaseFirestore.instance.collection('videos').doc(uuid.v4()).set(
            video.toJson(),
          );
      Get.back();
    } catch (e) {
      print("Error: $e");
      Get.snackbar(
        'Error Uploading Video',
        e.toString(),
      );
    }
  }
}
