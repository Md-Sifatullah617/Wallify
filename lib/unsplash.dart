import 'package:flutter/material.dart';

import 'Api/api_formate.dart';
import 'full_screen.dart';

class Unsplash extends StatefulWidget {
  const Unsplash({
    super.key,
  });

  @override
  State<Unsplash> createState() => _UnsplashState();
}

class _UnsplashState extends State<Unsplash> {
  List images = [];
  bool loading = false;
  int pageNo = 1;
  loadMore() async {
    pageNo++;
    var data = await getCuratedPhotos(pageNo);
    setState(() {
      images.addAll(data);
    });
  }

  callData() async {
    loading = true;
    var data = await getCuratedPhotos(pageNo);
    setState(() {
      images = data;
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    callData();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          childAspectRatio: 2 / 3,
        ),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ImageDetails(
                          imageURL: images[index]["src"]["tiny"])));
            },
            child: Container(
              color: Colors.white,
              child: Image.network(
                images[index]["src"]["tiny"],
                fit: BoxFit.cover,
              ),
            ),
          );
        });
  }
}
