import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallify/controller/main_controller.dart';
import 'vvew/home/dashboard.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.white,
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
          )),
      initialBinding: BindingsBuilder(() {
        Get.put(MainController());
      }),
      home: DashBoard(),
    );
  }
}
