import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallify/controller/main_controller.dart';

class ShowHistories extends StatelessWidget {
  const ShowHistories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: GetBuilder<MainController>(
        builder: (controller) => Column(
          children: [
            controller.searchHistory.isEmpty
                ? const Center(
                    child: Text('No History'),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: controller.searchHistory.length,
                    itemBuilder: (context, index) => ListTile(
                      onTap: () {
                        controller.searchController.text =
                            controller.searchHistory[index];
                      },
                      leading: const Icon(Icons.history),
                      title: Text(
                        controller.searchHistory[index],
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      trailing: InkWell(
                        onTap: () {
                          controller.searchHistory.removeAt(index);
                        },
                        child: const Icon(Icons.cancel_presentation),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
