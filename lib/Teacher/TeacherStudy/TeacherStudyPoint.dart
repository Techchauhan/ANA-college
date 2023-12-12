import 'package:ana/Teacher/TeacherStudy/PdfView/PdfViewScreen.dart';
import 'package:ana/Teacher/TeacherStudy/UploadPdf/PdfUploadScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TeacherStudyPoint extends StatefulWidget {
  @override
  _TeacherStudyPointState createState() => _TeacherStudyPointState();
}

class _TeacherStudyPointState extends State<TeacherStudyPoint> {
  late Future<List<dynamic>> pdfsFuture;

  @override
  void initState() {
    super.initState();
    pdfsFuture = fetchPdfs();
  }

  Future<List<dynamic>> fetchPdfs() async {
    try {
      final response = await http.get(Uri.parse('https://project.pulsezest.com/android/teacherfetchPdf.php'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load PDFs. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching PDFs: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Uploaded PDFs'),
      ),
      body: FutureBuilder(
        future: pdfsFuture,
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while fetching data
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // Show an error message if there's an error
            return Center(
              child: Text('Error fetching PDFs: ${snapshot.error}'),
            );
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            // Show a message when no PDFs are available
            return Center(
              child: Text('No PDFs found'),
            );
          } else {
            // Show the list of PDFs once fetching is successful
            List<dynamic> pdfs = snapshot.data!;
            return ListView.builder(
              itemCount: pdfs.length,
              itemBuilder: (context, index) {
                print("this data" + pdfs[index]['pdf_file_name']);
                return ListTile(
                  leading: const Icon(Icons.picture_as_pdf_outlined, color: Colors.red,),
                  title: Text(pdfs[index]['pdf_file_name'], style: const TextStyle(fontWeight: FontWeight.w600),),
                  onTap: () {
                    String pdfName = pdfs[index]['pdf_file_name'];
                    String pdfPath = pdfs[index]['pdf_file_path'];
                    String finalPath = "https://project.pulsezest.com/android/$pdfPath";
                    print(finalPath);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PdfViewScreen(pdfUrl: finalPath, pdfName: pdfName)),
                    );
                  },
                  // Add more details or actions as needed
                );
              },
            );
          }
        },
      ),
      floatingActionButton: CircleAvatar(
        radius: 30,
        child: IconButton(
          icon: const Icon(Icons.upload),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => PdfUploadScreen()));
          },
        ),
      ),
    );
  }
}