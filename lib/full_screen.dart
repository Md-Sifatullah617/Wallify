import 'package:flutter/material.dart';

class ImageDetails extends StatefulWidget {
  final String imageURL;
  const ImageDetails({super.key, required this.imageURL});

  @override
  State<ImageDetails> createState() => _ImageDetailsState();
}

class _ImageDetailsState extends State<ImageDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
            Expanded(child: Container(
                child: Image.network(widget.imageURL),
            )),
          InkWell(
            onTap: () {},
            child: Container(
              height: 60,
              width: double.infinity,
              color: Colors.black,
              child: const Center(
                  child: Text(
                "Set Wallpaper",
                style: TextStyle(fontSize: 20, color: Colors.white),
              )),
            ),
          )
        ],
      ),
    );
  }
}
