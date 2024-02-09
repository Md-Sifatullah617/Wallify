import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallify/Utility/custom_sheet.dart';
import 'package:wallify/Utility/primary_button.dart';
import 'package:wallify/controller/main_controller.dart';
import 'package:wallify/vvew/download_image/downloaded_images.dart';
import 'package:wallify/vvew/feedback/feedback.dart';
import 'package:wallify/vvew/history/show_history.dart';
import 'package:wallify/vvew/search_setting.dart';

class DashBoard extends StatelessWidget {
  DashBoard({super.key});

  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        key: _key,
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                _key.currentState!.openDrawer();
              },
              child: const Icon(Icons.menu)),
        ),
        drawer: const DrawerSection(),
        body: GetBuilder<MainController>(
          init: MainController(),
          builder: (controller) => Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  "ImageSeachMan",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                SizedBox(
                  height: Get.height * 0.05,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: controller.searchController,
                    decoration: const InputDecoration(
                      hintText: "Search Images",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                //button with custom width to search images
                PrimaryBtn(
                    title: "Search",
                    width: Get.width * 0.3,
                    height: Get.height * 0.04,
                    btnColor: Colors.green,
                    onPressed: () {
                      controller
                          .addToSearchHistory(controller.searchController.text);
                      controller.searchPhotos(
                          controller.searchController.text, 1);
                      //opens a bottom sheet to show search results
                      customBottomSheet();
                    }),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                //search history list
                Text(
                  "Search History",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                SizedBox(
                  height: Get.height * 0.4,
                  child: ListView.builder(
                    reverse: true,
                    itemCount: controller.searchHistory.length,
                    itemBuilder: (context, index) => ListTile(
                      onTap: () {
                        controller.searchController.text =
                            controller.searchHistory[index];
                        controller.update();
                        controller.searchPhotos(
                            controller.searchController.text, 1);
                        customBottomSheet();
                      },
                      leading: const Icon(Icons.history),
                      title: Text(
                        controller.searchHistory[index],
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      trailing: InkWell(
                        onTap: () {
                          controller.removeFromSearchHistory(index);
                        },
                        child: const Icon(Icons.cancel_presentation),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.05,
                ),
                // created by
                Text(
                  "Created By",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Md. Sifatullah",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => const SearchSettings());
                      },
                      child: const Icon(Icons.settings),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

class SearchSetting {
  const SearchSetting();
}

class DrawerSection extends StatelessWidget {
  const DrawerSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: Get.height * 0.1,
            color: Colors.grey[200],
            child: Row(
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  height: Get.height * 0.1,
                ),
                Text(
                  "ImageSearchMan",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.download),
            title: const Text("Download Images"),
            onTap: () {
              Get.to(() => const DownloadedImages());
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text("Search Histories"),
            onTap: () {
              Get.to(() => const ShowHistories());
            },
          ),
          ListTile(
            leading: const Icon(Icons.feedback),
            title: const Text("Feedback"),
            onTap: () {
              Get.to(() => FeedBackScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Setting"),
            onTap: () {},
          ),
          SizedBox(
            height: Get.height * 0.2,
          ),
          //created by
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Created By\n",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                TextSpan(
                  text: "Md. Sifatullah",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
