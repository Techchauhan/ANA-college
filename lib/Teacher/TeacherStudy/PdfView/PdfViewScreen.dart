import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class PdfViewScreen extends StatefulWidget {
  final String pdfUrl;
  final String pdfName;

  const PdfViewScreen({Key? key, required this.pdfUrl, required this.pdfName}) : super(key: key);

  @override
  _PdfViewScreenState createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfViewScreen> {
  String? localFilePath;
  bool isLoaded = false;
  int currentPage = 0;
  int totalPages = 0;

  @override
  void initState() {
    super.initState();
    _downloadPdfFile();
  }

  Future<void> _downloadPdfFile() async {
    final url = widget.pdfUrl;
    final filename = url.substring(url.lastIndexOf('/') + 1);
    final dir = await getApplicationDocumentsDirectory();
    final filePath = '${dir.path}/$filename';

    final File file = File(filePath);

    final response = await http.get(Uri.parse(url), headers: {
      'Accept-Ranges': 'bytes',
    });

    if (response.statusCode == 200) {
      final fileStream = response.bodyBytes;
      await file.writeAsBytes(fileStream, flush: true);

      setState(() {
        localFilePath = filePath;
        isLoaded = true;
      });
    } else {
      throw Exception('Failed to load PDF');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pdfName),
      ),
      body: isLoaded
          ? PDFView(
        filePath: localFilePath!,
        onPageChanged: (page, total) {
          setState(() {
            currentPage = page!;
            totalPages = total!;
          });
        },
        onError: (error) {
          // Handle error if loading fails
        },
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Page $currentPage of $totalPages',
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
