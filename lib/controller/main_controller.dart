import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wallify/Utility/secured_data.dart';
import 'package:wallify/Utility/utilities.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class MainController extends GetxController {
  var searchController = TextEditingController();
  var isLoading = false.obs;
  var pageNo = 1.obs;
  var searchHistory = [].obs;
  var photoList = [].obs;
  var downloadedImageList = [].obs;
  var typeList = [
    "Any Type",
    "Face",
    "Photo",
    "Clip Art",
    "Line Drawing",
    "Animated (GIF)"
  ];
  var isTypeSelected = false.obs;
  var selectedType = "".obs;
  var colorList = ["Any Color", "Full Color", "Black and White", "Transparent"];
  var isColorSelected = false.obs;
  var selectedColor = "".obs;
  var timeList = [
    "Any Time",
    "Past 24 Hours",
    "Past Week",
    "Past Month",
    "Past Year"
  ];
  var isTimeSelected = false.obs;
  var selectedTime = "".obs;
  var sizeList = ["Any Size", "Large", "Medium", "Icon"];
  var isSizeSelected = false.obs;
  var selectedSize = "".obs;
  var licenseList = [
    "Not Filtered by License",
    "Creative Commons Licenses",
    "Commercial & Other Licenses"
  ];
  var isLicenseSelected = false.obs;
  var selectedLicense = "".obs;

  late ScrollController scrollController = ScrollController();
  double scrollPosition = 0.0;

  @override
  void onInit() {
    SecureData.readSecureData(key: "searchHistory").then((value) {
      if (value != null) {
        searchHistory.addAll(value);
        update();
      } else {
        print("value is null");
      }
    });
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        scrollPosition = scrollController.position.pixels;
        pageNo.value++;
        searchPhotos(searchController.text, pageNo.value);
      }
    });
    // Set the selectedType to the first item in the typeList
    selectedType.value = typeList[0];
    isTypeSelected.value = true;
    selectedColor.value = colorList[0];
    isColorSelected.value = true;
    selectedTime.value = timeList[0];
    isTimeSelected.value = true;
    selectedSize.value = sizeList[0];
    isSizeSelected.value = true;
    selectedLicense.value = licenseList[0];
    isLicenseSelected.value = true;
    super.onInit();
  }

  void addToSearchHistory(String value) {
    if (value.isNotEmpty) {
      searchHistory.add(value);
      SecureData.writeSecureData(key: "searchHistory", value: searchHistory);
      update();
    }
  }

  Future searchPhotos(searchQuery, pageNo) async {
    try {
      isLoading.value = true;
      update();
      var response = await http.get(
          Uri.parse(
              'https://api.pexels.com/v1/search?query=$searchQuery&per_page=80&page=$pageNo'),
          headers: {
            "Authorization":
                "4iA5iM5oF1GhfQ117SF1QHw3trP4DxkuHrhci7amNepdFHzs9WEU6flc"
          });
      var resultCode = response.statusCode;
      var resultBody = json.decode(response.body);
      if (resultCode == 200) {
        photoList.addAll(resultBody["photos"]);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // Jump to the saved scroll position
          if (scrollController.hasClients) {
            scrollController.jumpTo(scrollPosition);
          }
        });
        isLoading.value = false;
        print("PhotoList : $photoList");
        update();
      } else {
        errorToastMessage("Picture Loading Failed ! Try Again.");
        photoList.value = [];
        isLoading.value = false;
        update();
      }
    } catch (e) {
      errorToastMessage("Picture Loading Failed ! Try Again.");
      print("Error : $e");
      photoList.value = [];
      isLoading.value = false;
      update();
    }
  }

  Future<void> downloadImage(String url, String filename) async {
    Dio dio = Dio();
    try {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        status = await Permission.storage.request();
      }
      if (status.isGranted) {
        var dir = await getApplicationDocumentsDirectory();

        // Create a new directory with your app name
        String newPath = '${dir.path}/Wallify'; // your app name
        dir = Directory(newPath);
        // Check if the directory exists
        bool exists = await dir.exists();
        if (!exists) {
          dir.createSync(recursive: true);
        }

        await dio.download(url, "${dir.path}/$filename");
        successToastMessage("Image downloaded successfully");
        print("Image downloaded successfully");
      } else {
        // Handle the case when the user denies the permission
        print("Storage permission not granted");
      }
    } catch (e) {
      errorToastMessage("Image downloading failed");
      print("Error downloading image: $e");
    }
  }

  Future<void> shareImage(String url, String filename) async {
    var dir = await getApplicationDocumentsDirectory();
    String newPath = '${dir.path}/Wallify'; // your app name
    String filePath = path.join(
        newPath, '$filename.jpg'); // assuming the image is in jpg format

    File file = File(filePath);
    if (await file.exists()) {
      // If the file exists, share it
      await Share.shareFiles([filePath]);
    } else {
      // If the file doesn't exist, download it first
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        status = await Permission.storage.request();
      }
      if (status.isGranted) {
        await downloadImage(url, filename);
        // Add a delay before checking if the file exists
        await Future.delayed(Duration(seconds: 2));
        // After downloading the image, check again if the file exists
        if (await file.exists()) {
          // If the file now exists, share it
          await Share.shareFiles([filePath]);
        } else {
          print("File does not exist after download");
        }
      } else {
        // Handle the case when the user denies the permission
        print("Storage permission not granted");
      }
    }
  }
}
