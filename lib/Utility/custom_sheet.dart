import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallify/GetPhotos/full_screen.dart';
import 'package:wallify/Utility/shimmer_effect.dart';
import 'package:wallify/controller/main_controller.dart';
import 'package:wallify/vvew/search_setting.dart';

void customBottomSheet() {
  Get.bottomSheet(
    GetBuilder<MainController>(
      init: MainController(),
      builder: (controller) => Container(
        height: Get.height,
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.02, vertical: Get.height * 0.02),
        color: Colors.white,
        child: Column(children: [
          //back button search field and setting icon
          AppBar(
            leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back),
            ),
            title: TextFormField(
              controller: controller.searchController,
              decoration: const InputDecoration(
                hintText: "Search Images",
                contentPadding: EdgeInsets.zero,
                border: UnderlineInputBorder(),
              ),
            ),
            actions: [
              InkWell(
                onTap: () {
                  Get.to(() => const SearchSettings());
                },
                child: const Icon(Icons.settings),
              ),
            ],
          ),
          Expanded(
            child: Obx(
              () => controller.isLoading.value
                  ? const ShimmerEffect()
                  : GridView.builder(
                      controller: controller.scrollController,
                      padding: const EdgeInsets.only(top: 0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                        childAspectRatio: 2 / 3,
                      ),
                      itemCount: controller.photoList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.to(() => ImageDetails(
                                imageDetails: controller.photoList[index]));
                          },
                          child: CachedNetworkImage(
                            imageUrl: controller.photoList[index]["src"]["tiny"]
                                .toString(),
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        );
                      }),
            ),
          ),
        ]),
      ),
    ),
    isScrollControlled: true,
  );
}
