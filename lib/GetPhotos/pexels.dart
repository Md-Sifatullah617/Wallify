import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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

class _PexelsState extends State<Pexels> with TickerProviderStateMixin {
  List images = [];
  List searchImages = [];
  bool loading = false;
  int pageNo = 1;
  int searchPageNo = 1;
  String searchQuery = "";
  TextEditingController searchController = TextEditingController();
  late AnimationController controller;
  LottieComposition? composition;
  loadMore() async {
    loading = true;
    pageNo++;
    searchPageNo++;
    var data = await getCuratedPhotos(pageNo);
    var data1 = await searchPhotos(searchQuery, searchPageNo, isPxl: true);
    setState(() {
      images.addAll(data);
      searchImages.addAll(data1);
      loading = false;
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
    controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(
            MediaQuery.of(context).size.height * 0.05,
          ),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: TextFormField(
            controller: searchController,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              decoration: TextDecoration.none,
            ),
            decoration: InputDecoration(
              hintText: "Search",
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
              border: InputBorder.none,
              suffixIcon: searchController.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        searchController.clear();
                        setState(() {
                          searchQuery = "";
                          searchImages = [];
                        });
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.grey,
                      ),
                    )
                  : null,
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
            ),
            onFieldSubmitted: (value) async {
              var data1 = await searchPhotos(value, searchPageNo, isPxl: true);
              setState(() {
                searchQuery = value;
                searchImages = data1;
              });
              print(value);
              print("searchImages: ${searchImages.length}");
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: FractionallySizedBox(
            heightFactor: 0.85,
            child: loading
                ? const ShimmerEffect()
                : GridView.builder(
                    padding: const EdgeInsets.only(top: 0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                      childAspectRatio: 2 / 3,
                    ),
                    itemCount: searchImages.isNotEmpty
                        ? searchImages.length
                        : images.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ImageDetails(
                                        imageURL: searchImages.isNotEmpty
                                            ? searchImages[index]["src"]
                                                ["large2x"]
                                            : images[index]["src"]["large2x"],
                                        photographer: searchImages.isNotEmpty
                                            ? searchImages[index]
                                                ["photographer"]
                                            : images[index]["photographer"],
                                      )));
                        },
                        child: Container(
                          color: Colors.white,
                          child: Image.network(
                            searchImages.isNotEmpty
                                ? searchImages[index]["src"]["tiny"]
                                : images[index]["src"]["tiny"],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }),
          ),
        ),
        Positioned(
          right: 10,
          bottom: 25,
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {
              loadMore();
              if (loading && composition != null) {
                controller
                  ..duration = composition!.duration
                  ..forward();
              } else {
                controller.reset();
              }
            },
            child: Lottie.asset(
              "assets/images/animation_lnmgzhnf.json",
              controller: controller,
              onLoaded: (loadedComposition) {
                setState(() => composition = loadedComposition);
              },
            ),
          ),
        ),
      ],
    );
  }
}
