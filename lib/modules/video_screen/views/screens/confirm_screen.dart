// ignore_for_file: use_super_parameters

import 'dart:io';
import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:doan_clean_achitec/shared/shared.dart';

import '../controllers/upload_video_controller.dart';
import '../widgets/text_input_field.dart';

class ConfirmScreen extends StatefulWidget {
  final File videoFile;
  final String videoPath;
  const ConfirmScreen({
    Key? key,
    required this.videoFile,
    required this.videoPath,
  }) : super(key: key);

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController controller;
  final TextEditingController _songController = TextEditingController();
  final TextEditingController _captionController = TextEditingController();

  final UploadVideoController uploadVideoController =
      Get.put(UploadVideoController());
  final AppController appController = Get.find();

  @override
  void initState() {
    super.initState();
    setState(() {
      controller = VideoPlayerController.file(widget.videoFile);
    });
    controller.initialize();
    controller.play();
    controller.setVolume(1);
    controller.setLooping(true);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.5,
              child: VideoPlayer(controller),
            ),
            const SizedBox(
              height: 30,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: TextInputField(
                      controller: _songController,
                      labelText: StringConst.caption.tr,
                      icon: Icons.closed_caption,
                    ),
                  ),
                  SizedBox(
                    height: getSize(16),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: TextInputField(
                      controller: _captionController,
                      labelText: StringConst.hashtag.tr,
                      icon: Icons.tag,
                    ),
                  ),
                  SizedBox(
                    height: getSize(16),
                  ),
                  ElevatedButton(
                    onPressed: () => uploadVideoController.uploadVideo(
                        _songController.text,
                        "#${_captionController.text}",
                        widget.videoPath),
                    child: Text(
                      StringConst.share.tr,
                      style: TextStyle(
                        fontSize: 20,
                        color: appController.isDarkModeOn.value
                            ? ColorConstants.white
                            : ColorConstants.accent1,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getSize(16),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
