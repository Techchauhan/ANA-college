import 'package:ana/Const/Colors.dart';
import 'package:file_picker/file_picker.dart' as file_picker;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path/path.dart';


class PdfUploadScreen extends StatefulWidget {
  @override
  _PdfUploadScreenState createState() => _PdfUploadScreenState();
}

class _PdfUploadScreenState extends State<PdfUploadScreen> {
  File? selectedPdf;
  String? selectedYear;
  String? selectedSubject;

  Future<void> selectPdf() async {
    try {
      final result = await file_picker.FilePicker.platform.pickFiles(
        type: file_picker.FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        setState(() {
          selectedPdf = File(result.files.single.path!);
        });
      } else {
        // User canceled the file picking
      }
    } catch (e) {
      // Handle any exceptions or errors
      print('File picking error: $e');
    }
  }




  Future<void> uploadPdf() async {
    if (selectedPdf == null || selectedYear == null || selectedSubject == null) {
      // Handle case where required fields are missing
      Fluttertoast.showToast(msg: "Please Fill all Fields");
      return;
    }

    var url = 'https://project.pulsezest.com/android/uploadPdf.php'; // Replace with your API endpoint
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['year'] = selectedYear!; // Add selected year to the request
    request.fields['department'] = selectedSubject!; // Add selected subject to the request
    request.files.add(await http.MultipartFile.fromPath(
      'pdf', // Field name for the file in the API request
      selectedPdf!.path,
      filename: basename(selectedPdf!.path),
    ));

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        // File uploaded and data inserted successfully
        // You can handle the response from the server here
        print('File uploaded and data inserted: ${response.body}');

        Fluttertoast.showToast(
          msg: 'File uploaded successfully!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );

        // Pop the screen after showing the toast message
        Navigator.of(context as BuildContext).pop();

      } else {
        // Handle error scenarios
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network or other errors
      print('Error: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload PDF'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: <Widget>[
             const SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // Set border color here
                    width: 1.0, // Set border width here
                  ),
                  borderRadius: BorderRadius.circular(8.0), // Set border radius here
                ),
                child:  const Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Upload any PDF for the Student Reference", style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20
                  ),),
                ),
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: selectPdf,
                child: const Text('Select PDF'),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // Set border color here
                    width: 1.0, // Set border width here
                  ),
                  borderRadius: BorderRadius.circular(8.0), // Set border radius here
                ),
                padding: const EdgeInsets.all(8.0), // Set padding inside the container
                child: Text(
                  selectedPdf != null ? selectedPdf!.path : 'No PDF selected',
                  style: const TextStyle(fontSize: 16.0),
                ),
              ),

              const SizedBox(height: 20),

              const SizedBox(height: 20),
              Text("Select the Semester", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
          DropdownButton<String>(
            isExpanded: true, // Expand dropdown to full width
            // Dropdown for selecting semester
            value: selectedYear,
            onChanged: (String? newValue) {
              setState(() {
                selectedYear = newValue;
              });
            },
            items: <String>[
              'First Semester',
              'Second Semester',
              'Third Semester',
              'Fourth Semester',
              'Fifth Semester',
              'Sixth Semester',
              'Seventh Semester',
              'Eighth Semester'
            ].map<DropdownMenuItem<String>>(
                  (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                    child: Text(
                      value,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
                );
              },
            ).toList(),
            hint: const Text("Select the year/Semester"),
            // Style the dropdown button itself
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.black, // Adjust text color if needed
            ),
            icon: const Icon(Icons.arrow_drop_down), // Dropdown icon
            iconSize: 36.0,
            elevation: 16,
            underline: Container(
              height: 2,
              color:AppColors.defaultColor, // Adjust underline color if needed
            ),
            // Decorate the dropdown button
            dropdownColor: Colors.white, // Adjust dropdown background color if needed
          ),
              const SizedBox(height: 20),
          Text("Select the Department", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
          DropdownButton<String>(
            isExpanded: true,
            value: selectedSubject,
            onChanged: (String? newValue) {
              setState(() {
                selectedSubject = newValue;
              });
            },
            items: <String>[
              'COMPUTER SCIENCE',
              'MECHANICAL ENG',
              'ELECTRIC ENG',
              'CIVIL ENG'
              // Add other subject values here
            ].map<DropdownMenuItem<String>>(
                  (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                    child: Text(
                      value,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
                );
              },
            ).toList(),
            hint: const Text('Select the Department'), // Hint text displayed when no value is selected
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.black, // Adjust text color if needed
            ),
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 36.0,
            elevation: 16,
            underline: Container(
              height: 2,
              color: Colors.blueAccent, // Adjust underline color if needed
            ),
            dropdownColor: Colors.white,
          ),

          ElevatedButton(
                onPressed: uploadPdf,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(AppColors.defaultColor), // Change color here
            ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column( children: [
                    Transform.rotate(
                      angle: 320 * 3.14159 / 180, // Rotate by 45 degrees (converted to radians)
                      child: const Icon(Icons.send),
                    ),
                    const SizedBox(height: 10,),
                    const Text("Upload The PDF")
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
