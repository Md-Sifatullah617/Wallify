import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wallify/Utility/secured_data.dart';
import 'package:wallify/Utility/utilities.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:wallify/model/search_photo_model.dart';

class MainController extends GetxController {
  var searchController = TextEditingController();
  var isLoading = false.obs;
  var pageNo = 1.obs;
  var searchHistory = [].obs;
  late SearchImageDetailsModel photoList;
  var searchImageList = <Item>[].obs;
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
  var isDownloading = false.obs;

  // late ScrollController scrollController = ScrollController();
  // double scrollPosition = 0.0;

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
    // scrollController.addListener(() {
    //   if (scrollController.position.pixels ==
    //       scrollController.position.maxScrollExtent) {
    //     scrollPosition = scrollController.position.pixels;
    //     pageNo.value++;
    //     searchPhotos(searchController.text, pageNo.value);
    //   }
    // });
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

  void removeFromSearchHistory(int index) {
    searchHistory.removeAt(index);
    SecureData.writeSecureData(key: "searchHistory", value: searchHistory);
    update();
  }

  Future searchPhotos() async {
    try {
      isLoading.value = true;
      update();
      var response = await http.get(
        Uri.parse(
            'https://www.googleapis.com/customsearch/v1?key=AIzaSyDux8mV3GTpz6xeUC6Ujp3uwUmSW6oxj3I&cx=25ff640fab372417e&q=${searchController.text}&start=${pageNo.value}&searchType=image' // To search only for images
            ),
      );
      var resultCode = response.statusCode;
      if (resultCode == 200) {
        photoList = SearchImageDetailsModel.fromJson(jsonDecode(response.body));
        searchImageList.addAll(photoList.items!);

        // WidgetsBinding.instance.addPostFrameCallback((_) {
        //   // Jump to the saved scroll position
        //   if (scrollController.hasClients) {
        //     scrollController.jumpTo(scrollPosition);
        //   }
        // });
        isLoading.value = false;
        update();
        print("PhotoList : $photoList");
        print("pageNo : ${pageNo.value}");
        print("searchImageList : ${searchImageList.length}");
        update();
      } else {
        errorToastMessage("Picture Loading Failed ! Try Again.");
        // photoList.value = [];
        isLoading.value = false;
        update();
      }
    } catch (e) {
      errorToastMessage("Picture Loading Failed ! Try Again.");
      print("Error : $e");
      // photoList.value = [];
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
        var dirPath = await ExternalPath.getExternalStoragePublicDirectory(
            ExternalPath.DIRECTORY_DOWNLOADS);

        // Create a new directory with your app name
        // String newPath = '$dirPath/Wallify'; // your app name
        Directory dir = Directory(dirPath);
        // Check if the directory exists
        bool exists = await dir.exists();
        if (!exists) {
          dir.createSync(recursive: true);
        }

        var filePath = "${dir.path}/$filename.jpg";
        isDownloading.value = true;
        await dio.download(url, filePath);
        isDownloading.value = false;
        successToastMessage("Image downloaded successfully");
        print("Image downloaded successfully");

        // Check if the file exists after the download
        bool fileExists = await File(filePath).exists();
        print("File exists after download: $fileExists");

        if (!fileExists) {
          print("Error: File does not exist after download");
        }
      }
    } catch (e) {
      errorToastMessage("Image downloading failed");
      print("Error downloading image: $e");
    }
  }

  Future<void> shareImage(String url, String filename) async {
    var dirPath = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
    // String newPath = '$dirPath/Wallify'; // your app name
    String filePath = path.join(dirPath, '$filename.jpg');

    try {
      // Check if the file already exists
      bool fileExists = await File(filePath).exists();

      if (!fileExists) {
        // If the file doesn't exist, download it first
        await downloadImage(url, filename);
        // Add a delay before checking if the file exists
        await Future.delayed(Duration(seconds: 2));
      }

      // After downloading the image, check if the file exists
      fileExists = await File(filePath).exists();

      if (fileExists) {
        // If the file exists, share it
        await Share.shareXFiles(
          [
            XFile(
              filePath,
              name: filename,
            )
          ],
        );
      } else {
        print("File does not exist after download");
      }
    } catch (e) {
      print("Error sharing image: $e");
    }
  }

  Future<void> setWallpaper(String url, String filename, int location,
      {bool? isDownloaded}) async {
    var dirPath = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
    // String newPath = '$dirPath/Wallify'; // your app name
    String filePath = path.join(dirPath, '$filename.jpg');

    File file = File(filePath);

    try {
      isLoading.value = true;
      // Check if the file already exists
      bool fileExists = await file.exists();

      if (!fileExists) {
        if (isDownloaded == null || !isDownloaded) {
          // If the file doesn't exist, download it
          await downloadImage(url, filename);
          print("Image downloaded successfully");
        } else {
          fileExists = true;
          filePath = url;
          file = File(filePath);
        }
      }

      // Now, set the wallpaper regardless of whether it was downloaded or pre-existing
      await WallpaperManager.setWallpaperFromFile(filePath, location)
          .then((value) => {
                successToastMessage("Wallpaper set successfully"),
                isLoading.value = false,
              });
    } catch (e) {
      print("Error setting wallpaper: $e");
      errorToastMessage("Wallpaper setting failed");
      isLoading.value = false;
    }
  }
}
