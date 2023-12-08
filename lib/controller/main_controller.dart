import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallify/Utility/secured_data.dart';
import 'package:wallify/Utility/utilities.dart';
import 'package:http/http.dart' as http;

class MainController extends GetxController {
  var searchController = TextEditingController();
  var isLoading = false.obs;
  var searchHistory = [].obs;
  var photoList = [].obs;
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
        photoList.value = resultBody;
        isLoading.value = false;
        update();
      } else {
        errorToastMessage("Picture Loading Failed ! Try Again.");
        photoList.value = [];
        isLoading.value = false;
        update();
      }
    } catch (e) {
      errorToastMessage("Picture Loading Failed ! Try Again.");
      photoList.value = [];
      isLoading.value = false;
      update();
    }
  }
}
