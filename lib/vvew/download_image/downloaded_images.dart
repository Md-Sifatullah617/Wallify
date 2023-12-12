import 'dart:io';
import 'package:external_path/external_path.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:wallify/vvew/download_image/ontap_view.dart';

class DownloadedImages extends StatefulWidget {
  const DownloadedImages({super.key});

  @override
  _DownloadedImagesState createState() => _DownloadedImagesState();
}

class _DownloadedImagesState extends State<DownloadedImages> {
  List<File> _images = [];

  @override
  void initState() {
    super.initState();
    loadImages();
  }

  Future<void> loadImages() async {
    var dirPath = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
    String newPath = '$dirPath/Wallify'; // your app name
    Directory imageDirectory = Directory(newPath);

    // Check if the directory exists
    bool exists = await imageDirectory.exists();
    if (!exists) {
      // If the directory does not exist, create it
      imageDirectory.createSync(recursive: true);
    }

    List<FileSystemEntity> imageFiles = imageDirectory.listSync();
    setState(() {
      _images = imageFiles.map((item) => File(item.path)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Downloaded Images"),
      ),
      body: GridView.builder(
        itemCount: _images.length,
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Get.to(
                () => OnTapViewPage(
                  image: _images[index],
                ),
              );
            },
            child: Image.file(
              _images[index],
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
