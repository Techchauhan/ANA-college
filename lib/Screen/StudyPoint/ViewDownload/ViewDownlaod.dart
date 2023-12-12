import 'package:ana/Const/Colors.dart';
import 'package:flutter/material.dart';

class ViewDownloader extends StatelessWidget {
  const ViewDownloader({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.defaultColor,
        title: const Text("Downloader"),
      ),
      body: Center(
        child: const Text("ViewDownloader"),
      ),
    );
  }
}
