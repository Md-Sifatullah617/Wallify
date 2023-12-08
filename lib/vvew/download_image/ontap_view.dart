import 'dart:io';

import 'package:flutter/material.dart';

class OnTapViewPage extends StatelessWidget {
  final File image;
  const OnTapViewPage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: ListTile(
                    leading: const Icon(Icons.share),
                    title: const Text("Share"),
                  ),
                ),
                PopupMenuItem(
                  child: ListTile(
                    leading: const Icon(Icons.wallpaper),
                    title: const Text("Set as wallpaper"),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: Center(
        child: Image.file(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
