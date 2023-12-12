import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wallify/Utility/primary_button.dart';

class FeedBackScreen extends StatelessWidget {
  FeedBackScreen({super.key});
  final TextEditingController feedbackcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Feedback'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "Send Feedback to us",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              const Text(
                "We are always looking for ways to improve our app. Please send us your feedback.",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  controller: feedbackcontroller,
                  maxLines: 10,
                  decoration: InputDecoration(
                    hintText: "Enter your feedback here",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              PrimaryBtn(
                title: "Send Feedback",
                width: Get.width * 0.5,
                onPressed: () {
                  launchUrl(Uri.parse(
                    "mailto: sifatullahsanowar1@gmail.com?subject=Wallify Feedback&body=${feedbackcontroller.text}",
                  ));
                },
              ),
            ],
          ),
        ));
  }
}
