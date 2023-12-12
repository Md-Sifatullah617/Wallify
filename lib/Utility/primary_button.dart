import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrimaryBtn extends StatelessWidget {
  final String title;
  final Color? btnColor;
  final double? width;
  final double? height;
  final Function() onPressed;
  const PrimaryBtn({
    super.key,
    required this.title,
    required this.onPressed,
    this.btnColor,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: btnColor ?? Colors.black,
        minimumSize: Size(width ?? Get.width, height ?? Get.height * 0.05),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(title, style: const TextStyle(color: Colors.white)),
    );
  }
}
