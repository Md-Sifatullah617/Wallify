import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            height: 10,
          ),
          AspectRatio(
            aspectRatio: 10/9,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(25)),
              child: Image.network(
                widget.imageURL,
                fit: BoxFit.cover,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              bottomSheet(context);
            },
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

  Future<dynamic> bottomSheet(BuildContext context) {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return FractionallySizedBox(
            widthFactor: 0.8,
            child: Container(
              height: 150,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      var file = await DefaultCacheManager()
                          .getSingleFile(widget.imageURL);
                      await WallpaperManager.setWallpaperFromFile(
                          file.path, WallpaperManager.HOME_SCREEN);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Set as HomeScreen',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: Colors.black),
                    ),
                  ),
                  const CustomDivider(),
                  InkWell(
                    onTap: () async {
                      var file = await DefaultCacheManager()
                          .getSingleFile(widget.imageURL);
                      await WallpaperManager.setWallpaperFromFile(
                          file.path, WallpaperManager.LOCK_SCREEN);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Set as LockScreen',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: Colors.black),
                    ),
                  ),
                  const CustomDivider(),
                  InkWell(
                    onTap: () async {
                      var file = await DefaultCacheManager()
                          .getSingleFile(widget.imageURL);
                      await WallpaperManager.setWallpaperFromFile(
                          file.path, WallpaperManager.BOTH_SCREEN);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Both',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: Colors.black),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: const Divider(
          color: Colors.grey,
          thickness: 1,
        ));
  }
}
