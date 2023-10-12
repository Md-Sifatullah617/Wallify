import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wallify/Utility/utilities.dart';

Future<List> getCuratedPhotos(pageNo) async {
  var response = await http.get(
      Uri.parse('https://api.pexels.com/v1/curated?per_page=80&page=$pageNo'),
      headers: {
        "Authorization":
            "4iA5iM5oF1GhfQ117SF1QHw3trP4DxkuHrhci7amNepdFHzs9WEU6flc"
      });
  var resultCode = response.statusCode;
  var resultBody = json.decode(response.body);
  if (resultCode == 200) {
    return resultBody["photos"];
  } else {
    errorToastMessage("Picture Loading Failed ! Try Again.");
    return [];
  }
}

Future<List> unsplashApi(pageNo, perPage) async {
  var response = await http.get(Uri.parse(
      'https://api.unsplash.com/photos/?client_id=wJuV3s36uGfpOWCEvy7ZD6nqbWbxDCN5lkwztmRlsd4&page=$pageNo&per_page=$perPage'));
  var resultCode = response.statusCode;
  var resultBody = json.decode(response.body);
  if (resultCode == 200) {
    return resultBody;
  } else {
    errorToastMessage("Picture Loading Failed ! Try Again.");
    return [];
  }
}

Future<List> searchPhotos(searchQuery, pageNo, {required bool isPxl}) async {
  var response = isPxl
      ? await http.get(
          Uri.parse(
              'https://api.pexels.com/v1/search?query=$searchQuery&per_page=80&page=$pageNo'),
          headers: {
              "Authorization":
                  "4iA5iM5oF1GhfQ117SF1QHw3trP4DxkuHrhci7amNepdFHzs9WEU6flc"
            })
      : await http.get(Uri.parse(
          'https://api.unsplash.com/photos/?client_id=wJuV3s36uGfpOWCEvy7ZD6nqbWbxDCN5lkwztmRlsd4&query=$searchQuery&page=$pageNo&per_page=30'));
  var resultCode = response.statusCode;
  var resultBody = json.decode(response.body);
  if (resultCode == 200) {
    return !isPxl ? resultBody : resultBody["photos"];
  } else {
    errorToastMessage("Picture Loading Failed ! Try Again.");
    return [];
  }
}
