import 'package:flutter/material.dart';
import 'package:wallify/Api/api_formate.dart';
import '../Utility/shimmer_effect.dart';
import 'full_screen.dart';

class Pexels extends StatefulWidget {
  const Pexels({
    super.key,
  });

  @override
  State<Pexels> createState() => _PexelsState();
}

class _PexelsState extends State<Pexels> {
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
    return Stack(
      children: [
        loading
            ? const ShimmerEffect()
            : GridView.builder(
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
                                    imageURL: images[index]["src"]["large2x"],
                                    photographer: images[index]["photographer"],
                                  )));
                    },
                    child: Container(
                      color: Colors.white,
                      child: Image.network(
                        images[index]["src"]["tiny"],
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
        )
      ],
    );
  }
}

