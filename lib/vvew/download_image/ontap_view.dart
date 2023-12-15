import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wallify/GetPhotos/full_screen.dart';
import 'package:wallify/controller/main_controller.dart';

class OnTapViewPage extends StatelessWidget {
  final File image;
  const OnTapViewPage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      init: MainController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text(image.path.split("/").last),
          actions: [
            PopupMenuButton(itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: 0,
                  child: ListTile(
                    leading: Icon(Icons.share),
                    title: Text("Share"),
                  ),
                ),
                const PopupMenuItem(
                  value: 1,
                  child: ListTile(
                    leading: Icon(Icons.wallpaper),
                    title: Text("Set as wallpaper"),
                  ),
                ),
              ];
            }, onSelected: (value) async {
              if (value == 0) {
                // Share the image
                await Share.shareXFiles([XFile(image.path)],
                    text: "Wallify - Download HD wallpapers for free");
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
                              onTap: () {
                                controller.setWallpaper(
                                  image.path,
                                  image.path.split("/").last,
                                  WallpaperManager.HOME_SCREEN,
                                  isDownloaded: true,
                                );
                                Navigator.pop(context);
                              },
                              leading: const Icon(Icons.home),
                              title: const Text("Home screen"),
                            ),
                            ListTile(
                              onTap: () {
                                controller.setWallpaper(
                                  image.path,
                                  image.path.split("/").last,
                                  WallpaperManager.LOCK_SCREEN,
                                  isDownloaded: true,
                                );
                                Navigator.pop(context);
                              },
                              leading: const Icon(Icons.lock),
                              title: const Text("Lock screen"),
                            ),
                            ListTile(
                              onTap: () {
                                controller.setWallpaper(
                                  image.path,
                                  image.path.split("/").last,
                                  WallpaperManager.BOTH_SCREEN,
                                  isDownloaded: true,
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
          child: Obx(
            () => Stack(
              alignment: Alignment.center,
              children: [
                Image.file(
                  image,
                  fit: BoxFit.cover,
                ),
                if (controller.isLoading.value) const CustomLoader(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
