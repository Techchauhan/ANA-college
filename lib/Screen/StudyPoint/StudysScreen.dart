import 'package:ana/Teacher/TeacherStudy/PdfView/PdfViewScreen.dart';
import 'package:ana/Teacher/TeacherStudy/UploadPdf/PdfUploadScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StudyScreen extends StatefulWidget {
  @override
  _StudyScreenState createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  String? selectedYear;
  String? selectedDepartment;
  List<Map<String, dynamic>> pdfFiles = [];
  bool isLoading = false;

  Future<void> fetchPdfFiles() async {
    if (selectedYear == null || selectedDepartment == null) {
      // Handle case where required fields are missing
      return;
    }
    setState(() {
      isLoading = true;
    });

    var url = 'https://project.pulsezest.com/android/fetchPdf.php'; // Replace with your API endpoint
    var response = await http.post(Uri.parse(url), body: {
      'year': selectedYear!,
      'department': selectedDepartment!,
    });

    if (response.statusCode == 200) {
      // Parse the response JSON data
      setState(() {
        pdfFiles = List<Map<String, dynamic>>.from(json.decode(response.body));
        isLoading = false;
      });
    } else {
      // Handle error scenarios
      print('Error: ${response.statusCode}');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetch PDF Files'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DropdownButton<String>(
              isExpanded: true,
              value: selectedYear,
              hint: const Text('Select Year'),
              onChanged: (String? newValue) {
                setState(() {
                  selectedYear = newValue;
                });
              },
              // Add your year values here
              items: <String>[
                'First Semester',
                'Second Semester',
                'Third Semester',
                'Fourth Semester',
                'Fifth Semester',
                'Sixth Semester',
                'Seventh Semester',
                'Eighth Semester']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 16.0),
            DropdownButton<String>(
              isExpanded: true,
              value: selectedDepartment,
              hint: const Text('Select Department'),
              onChanged: (String? newValue) {
                setState(() {
                  selectedDepartment = newValue;
                });
              },
              // Add your department values here
              items: <String>[
                'COMPUTER SCIENCE',
                'MECHANICAL ENG',
                'ELECTRICAL ENG',
                'CIVIL ENG'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: fetchPdfFiles,
              child: const Text('Fetch PDF Files'),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: isLoading
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : ListView.builder(
                itemCount: pdfFiles.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.picture_as_pdf),
                    title: Text(pdfFiles[index]['pdf_file_name']),
                    onTap: () {
                      // Handle onTap to open the selected PDF file
                      // Replace with your logic
                      String pdfName = pdfFiles[index]['pdf_file_name'];
                      String endPath = pdfFiles[index]['pdf_file_path'];
                      String startingPath = 'https://project.pulsezest.com/android/';
                      String finalPath = startingPath + endPath;

                      print(finalPath);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PdfViewScreen( pdfUrl: finalPath, pdfName:   pdfName,)));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),

    );

  }
}
