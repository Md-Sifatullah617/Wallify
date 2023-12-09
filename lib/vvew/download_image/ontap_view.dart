import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:get/get.dart';
import 'package:wallify/Utility/utilities.dart';
import 'package:wallify/controller/main_controller.dart';

class OnTapViewPage extends StatelessWidget {
  final File image;
  const OnTapViewPage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton(itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 0,
                  child: ListTile(
                    leading: const Icon(Icons.share),
                    title: const Text("Share"),
                  ),
                ),
                PopupMenuItem(
                  value: 1,
                  child: ListTile(
                    leading: const Icon(Icons.wallpaper),
                    title: const Text("Set as wallpaper"),
                  ),
                ),
              ];
            }, onSelected: (value) async {
              if (value == 0) {
                // Share
              } else if (value == 1) {
                // Set as wallpaper
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Set as wallpaper"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              onTap: () async {
                                await WallpaperManager.setWallpaperFromFile(
                                        image.path,
                                        WallpaperManager.HOME_SCREEN)
                                    .then(
                                  (value) => successToastMessage(
                                      "Wallpaper set successfully"),
                                );
                                Navigator.pop(context);
                              },
                              leading: const Icon(Icons.home),
                              title: const Text("Home screen"),
                            ),
                            ListTile(
                              onTap: () async {
                                await WallpaperManager.setWallpaperFromFile(
                                        image.path,
                                        WallpaperManager.LOCK_SCREEN)
                                    .then(
                                  (value) => successToastMessage(
                                      "Wallpaper set successfully"),
                                );
                                Navigator.pop(context);
                              },
                              leading: const Icon(Icons.lock),
                              title: const Text("Lock screen"),
                            ),
                            ListTile(
                              onTap: () async {
                                await WallpaperManager.setWallpaperFromFile(
                                        image.path,
                                        WallpaperManager.BOTH_SCREEN)
                                    .then(
                                  (value) => successToastMessage(
                                      "Wallpaper set successfully"),
                                );
                                Navigator.pop(context);
                              },
                              leading: const Icon(Icons.sync),
                              title: const Text("Both"),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Cancel")),
                        ],
                      );
                    });
              }
            }),
          ],
        ),
        body: Center(
          child: Image.file(
            image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
