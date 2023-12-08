import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  XFile? _image;
  final imagePicker = ImagePicker();
  VideoPlayerController? _controller;

  // カメラから写真を取得するメソッド
  Future getImageFromCamera() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = XFile(pickedFile.path);
      }
    });
  }

  // ギャラリーから写真を取得するメソッド
  Future getImageFromGarally() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = XFile(pickedFile.path);
      }
    });
  }

  // カメラから動画を取得するメソッド
  Future getVideoFromCamera() async {
    XFile? pickedFile = await imagePicker.pickVideo(source: ImageSource.camera);
    if (pickedFile != null) {
      _controller = VideoPlayerController.file(File(pickedFile.path));
      _controller!.initialize().then((_) {
        setState(() {
          _controller!.play();
        });
      });
    }
  }

  // ギャラリーから動画を取得するメソッド
  Future getVideoFromGarally() async {
    XFile? pickedFile =
        await imagePicker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      _controller = VideoPlayerController.file(File(pickedFile.path));
      _controller!.initialize().then((_) {
        setState(() {
          _controller!.play();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ギャラリー"),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // 取得した写真を表示(ない場合はメッセージ)
                  _image == null
                      ? Text(
                          '写真を選択してください',
                          style: Theme.of(context).textTheme.headline4,
                        )
                      : Image.file(
                          File(_image!.path),
                        ),

                  // 取得した動画を表示(ない場合はメッセージ)
                  _controller == null
                      ? Text(
                          '動画を選択してください',
                          style: Theme.of(context).textTheme.headline4,
                        )
                      : VideoPlayer(_controller!),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: getImageFromCamera,
                  icon: const Icon(Icons.photo_camera),
                  label: const Text('Camera'),
                ),
                const SizedBox(
                  width: 30,
                ),
                ElevatedButton.icon(
                  onPressed: getImageFromGarally,
                  icon: const Icon(Icons.photo_album),
                  label: const Text('Gallery'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
