import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallify/controller/main_controller.dart';

class DashBoard extends StatelessWidget {
  DashBoard({super.key});

  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                _key.currentState!.openDrawer();
              },
              child: const Icon(Icons.menu)),
        ),
        drawer: DrawerSection(),
        body: GetBuilder<MainController>(
          init: MainController(),
          builder: (controller) => ListView(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
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
                child: Row(
                  children: [
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search Images",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.searchHistory
                            .add(controller.searchController.value.text.trim());
                      },
                      child: const Icon(Icons.search),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              //search history list
              Text(
                "Search History",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Container(
                height: Get.height * 0.4,
                child: ListView.builder(
                  itemCount: controller.searchHistory.length,
                  itemBuilder: (context, index) => ListTile(
                    leading: const Icon(Icons.history),
                    title: Text(
                      controller.searchHistory[index].toString(),
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    trailing: InkWell(
                      onTap: () {
                        controller.searchHistory.removeAt(index);
                      },
                      child: const Icon(Icons.delete),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
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
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text("Search Histories"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.feedback),
            title: const Text("Feedback"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Setting"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
