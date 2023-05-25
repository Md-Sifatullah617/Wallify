import 'package:flutter/material.dart';
import 'package:wallify/Api/api_formate.dart';
import 'package:wallify/Utility/shimmer_effect.dart';
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
  int perPage = 30;
  loadMore() async {
    pageNo++;
    var data = await unsplashApi(pageNo, perPage);
    setState(() {
      images.addAll(data);
    });
  }

  callData() async {
    loading = true;
    var data = await unsplashApi(pageNo, perPage);
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
    return Stack(
      children: [
        loading
            ? const ShimmerEffect()
            :
        GridView.builder(
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
                              imageURL: images[index]["urls"]["full"], photographer: images[index]["user"]["name"], tlike: images[index]["likes"],)));
                },
                child: Container(
                  color: Colors.white,
                  child: Image.network(
                    images[index]["urls"]["small"],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }),
        Positioned(
          right: 10,
          bottom: 25,
          child: FloatingActionButton(
            onPressed: () {
              loadMore();
            },
            child: const Icon(Icons.refresh),
          ),
        ),
      ],
    );
  }
}
