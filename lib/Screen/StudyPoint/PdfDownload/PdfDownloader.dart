import 'package:ana/Const/Colors.dart';
import 'package:flutter/material.dart';

class PDFDownload extends StatelessWidget {
  const PDFDownload({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.defaultColor,
          title: const Text("PDF"),
        ),
      body: Center(
        child: Text("No Downloads"),
      ),
    );
  }
}
