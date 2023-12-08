import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallify/controller/main_controller.dart';

class SearchSettings extends StatelessWidget {
  const SearchSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Search Settings"),
        ),
        body: GetBuilder<MainController>(
          init: MainController(),
          builder: (controller) => Padding(
            padding: EdgeInsets.all(Get.width * 0.02),
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text("Type"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ...List.generate(
                                    controller.typeList.length,
                                    (index) => CheckboxListTile(
                                      value: controller.isTypeSelected.value &&
                                          controller.selectedType.value ==
                                              controller.typeList[index],
                                      onChanged: ((value) {
                                        controller.isTypeSelected.value =
                                            value!;
                                        controller.selectedType.value =
                                            controller.typeList[index];
                                        controller.update();
                                        Get.back();
                                      }),
                                      checkboxShape: const CircleBorder(),
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      title: Text(
                                        controller.typeList[index],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ));
                  },
                  title: const Text("Type"),
                  subtitle: Text(controller.selectedType.value),
                ),
                Divider(
                  indent: Get.width * 0.05,
                  endIndent: Get.width * 0.05,
                ),
                ListTile(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text("Color"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ...List.generate(
                                    controller.colorList.length,
                                    (index) => CheckboxListTile(
                                      value: controller.isColorSelected.value &&
                                          controller.selectedColor.value ==
                                              controller.colorList[index],
                                      onChanged: ((value) {
                                        controller.isColorSelected.value =
                                            value!;
                                        controller.selectedColor.value =
                                            controller.colorList[index];
                                        controller.update();
                                        Get.back();
                                      }),
                                      checkboxShape: const CircleBorder(),
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      title: Text(
                                        controller.colorList[index],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ));
                  },
                  title: const Text("Color"),
                  subtitle: Text(controller.selectedColor.value),
                ),
                Divider(
                  indent: Get.width * 0.05,
                  endIndent: Get.width * 0.05,
                ),
                ListTile(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text("Size"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ...List.generate(
                                    controller.sizeList.length,
                                    (index) => CheckboxListTile(
                                      value: controller.isSizeSelected.value &&
                                          controller.selectedSize.value ==
                                              controller.sizeList[index],
                                      onChanged: ((value) {
                                        controller.isSizeSelected.value =
                                            value!;
                                        controller.selectedSize.value =
                                            controller.sizeList[index];
                                        controller.update();
                                        Get.back();
                                      }),
                                      checkboxShape: const CircleBorder(),
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      title: Text(
                                        controller.sizeList[index],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ));
                  },
                  title: const Text("Size"),
                  subtitle: Text(controller.selectedSize.value),
                ),
                Divider(
                  indent: Get.width * 0.05,
                  endIndent: Get.width * 0.05,
                ),
                ListTile(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text("Time"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ...List.generate(
                                    controller.timeList.length,
                                    (index) => CheckboxListTile(
                                      value: controller.isTimeSelected.value &&
                                          controller.selectedTime.value ==
                                              controller.timeList[index],
                                      onChanged: ((value) {
                                        controller.isTimeSelected.value =
                                            value!;
                                        controller.selectedTime.value =
                                            controller.timeList[index];
                                        controller.update();
                                        Get.back();
                                      }),
                                      checkboxShape: const CircleBorder(),
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      title: Text(
                                        controller.timeList[index],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ));
                  },
                  title: const Text("Time"),
                  subtitle: Text(controller.selectedTime.value),
                ),
                Divider(
                  indent: Get.width * 0.05,
                  endIndent: Get.width * 0.05,
                ),
                ListTile(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text("License"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ...List.generate(
                                    controller.licenseList.length,
                                    (index) => CheckboxListTile(
                                      value: controller
                                              .isLicenseSelected.value &&
                                          controller.selectedLicense.value ==
                                              controller.licenseList[index],
                                      onChanged: ((value) {
                                        controller.isLicenseSelected.value =
                                            value!;
                                        controller.selectedLicense.value =
                                            controller.licenseList[index];
                                        controller.update();
                                        Get.back();
                                      }),
                                      checkboxShape: const CircleBorder(),
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      title: Text(
                                        controller.licenseList[index],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ));
                  },
                  title: const Text("License"),
                  subtitle: Text(controller.selectedLicense.value),
                ),
                SizedBox(
                  height: Get.height * 0.05,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple.shade400,
                  ),
                  child: Text(
                    "Search with this options",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
