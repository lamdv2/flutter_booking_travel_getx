// ignore_for_file: use_super_parameters, use_build_context_synchronously

import 'dart:io';

import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'confirm_screen.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({Key? key}) : super(key: key);

  pickVideo(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);
    if (video != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ConfirmScreen(
            videoFile: File(video.path),
            videoPath: video.path,
          ),
        ),
      );
    }
  }

  showOptionsDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        children: [
          SimpleDialogOption(
            onPressed: () => pickVideo(ImageSource.gallery, context),
            child: Row(
              children: [
                const Icon(Icons.image),
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Text(
                    StringConst.gallery.tr,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () => pickVideo(ImageSource.camera, context),
            child: Row(
              children: [
                const Icon(Icons.camera_alt),
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Text(
                    StringConst.camera.tr,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () => Get.back(),
            child: Row(
              children: [
                const Icon(Icons.cancel),
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Text(
                    StringConst.cancel.tr,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showOptionsDialog(context),
      child: Container(
        padding: EdgeInsets.all(getSize(4)),
        height: getSize(48),
        width: getSize(48),
        decoration: BoxDecoration(
          color: ColorConstants.primaryButton,
          borderRadius: BorderRadius.circular(getSize(16)),
        ),
        child: Center(
          child: SvgPicture.asset(
            AssetHelper.icPlus,
            color: ColorConstants.whiteColor,
          ),
        ),
      ),
    );
  }
}
