import 'dart:io';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoManager extends StatefulWidget {
  const VideoManager({Key? key, required this.file}) : super(key: key);
  final String file;

  @override
  State<VideoManager> createState() => _VideoManagerState();
}

class _VideoManagerState extends State<VideoManager> {
  late VideoPlayerController controller;
  late ChewieController chewieController;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.file(
      File(
        widget.file,
      ),
    )..initialize().then((value) => setState(() {}));

    chewieController = ChewieController(
      videoPlayerController: controller,
      autoPlay: true,
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IEEE-Skill up'),
      ),
      body: Center(
          child: Chewie(
        controller: chewieController,
      )),
    );
  }
}
