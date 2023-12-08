import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallify/controller/main_controller.dart';
import 'package:wallify/vvew/home/dashboard.dart';

class ImageDetails extends StatefulWidget {
  final Map imageDetails;

  const ImageDetails({
    super.key,
    required this.imageDetails,
  });

  @override
  State<ImageDetails> createState() => _ImageDetailsState();
}

class _ImageDetailsState extends State<ImageDetails> {
  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          widget.imageDetails["id"].toString(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        actions: [
          IconButton(
            onPressed: () {
              _key.currentState!.openDrawer();
            },
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      drawer: const DrawerSection(),
      body: GetBuilder<MainController>(
        init: MainController(),
        builder: (controller) => SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: AspectRatio(
                  aspectRatio: 10 / 9,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    child: CachedNetworkImage(
                      imageUrl: widget.imageDetails["src"]["original"],
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              //download share and more vert button
              Container(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                width: double.infinity,
                height: Get.height * 0.08,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () async {
                        var status = await Permission.storage.status;
                        if (!status.isGranted) {
                          status = await Permission.storage.request();
                        }
                        if (status.isGranted) {
                          controller.downloadImage(
                              widget.imageDetails["src"]["original"],
                              widget.imageDetails["id"].toString());
                        } else {
                          // Handle the case when the user denies the permission
                          print("Storage permission not granted");
                        }
                      },
                      icon: const Icon(Icons.download),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.share),
                    ),
                    IconButton(
                      onPressed: () {
                        PopupMenuButton(
                            itemBuilder: (context) => [
                                  PopupMenuItem(
                                    value: 1,
                                    child: ListTile(
                                      onTap: () {},
                                      leading: const Icon(Icons.web),
                                      title: const Text("Search in web"),
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 2,
                                    child: ListTile(
                                      onTap: () {},
                                      leading: const Icon(Icons.wallpaper),
                                      title: const Text("Set as wallpaper"),
                                    ),
                                  ),
                                ],
                            onSelected: (value) {});
                      },
                      icon: const Icon(Icons.more_vert),
                    ),
                  ],
                ),
              ),
              Container(
                  width: double.infinity,
                  height: Get.height * 0.05,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Text(
                    textAlign: TextAlign.center,
                    "↓ Related Images ↓",
                    style: Theme.of(context).textTheme.titleLarge,
                  )),
              SizedBox(
                height: Get.height * 0.05,
              ),
              GridView.builder(
                // controller: controller.scrollController,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  childAspectRatio: 2 / 3,
                ),
                itemCount: controller.photoList.length, // Update this line
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      // Get.to(() => ImageDetails(
                      //     imageDetails: controller.photoList[index]));
                    },
                    child: CachedNetworkImage(
                      imageUrl: controller.photoList[index]["src"]
                          ["tiny"], // Update this line
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<dynamic> bottomSheet(BuildContext context) {
  //   return showModalBottomSheet(
  //       backgroundColor: Colors.transparent,
  //       context: context,
  //       builder: (BuildContext context) {
  //         return Container(
  //           height: 150,
  //           decoration: const BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.only(
  //                   topLeft: Radius.circular(25),
  //                   topRight: Radius.circular(25)),
  //               gradient: LinearGradient(
  //                   begin: Alignment.topLeft,
  //                   end: Alignment.bottomRight,
  //                   colors: [Colors.white, Colors.grey])),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               InkWell(
  //                 onTap: () async {
  //                   var file = await DefaultCacheManager()
  //                       .getSingleFile(widget.imageDetails["src"]["original"]);
  //                   await WallpaperManager.setWallpaperFromFile(
  //                       file.path, WallpaperManager.HOME_SCREEN);
  //                   Navigator.pop(context);
  //                 },
  //                 child: Text(
  //                   'Set as HomeScreen',
  //                   style: Theme.of(context)
  //                       .textTheme
  //                       .headlineSmall!
  //                       .copyWith(color: Colors.black),
  //                 ),
  //               ),
  //               const CustomDivider(),
  //               InkWell(
  //                 onTap: () async {
  //                   var file = await DefaultCacheManager()
  //                       .getSingleFile(widget.imageDetails["src"]["original"]);
  //                   await WallpaperManager.setWallpaperFromFile(
  //                       file.path, WallpaperManager.LOCK_SCREEN);
  //                   Navigator.pop(context);
  //                 },
  //                 child: Text(
  //                   'Set as LockScreen',
  //                   style: Theme.of(context)
  //                       .textTheme
  //                       .headlineSmall!
  //                       .copyWith(color: Colors.black),
  //                 ),
  //               ),
  //               const CustomDivider(),
  //               InkWell(
  //                 onTap: () async {
  //                   var file = await DefaultCacheManager()
  //                       .getSingleFile(widget.imageDetails["src"]["original"]);
  //                   await WallpaperManager.setWallpaperFromFile(
  //                       file.path, WallpaperManager.BOTH_SCREEN);
  //                   Navigator.pop(context);
  //                 },
  //                 child: Text(
  //                   'Both',
  //                   style: Theme.of(context)
  //                       .textTheme
  //                       .headlineSmall!
  //                       .copyWith(color: Colors.black),
  //                 ),
  //               )
  //             ],
  //           ),
  //         );
  //       });
  // }
}
