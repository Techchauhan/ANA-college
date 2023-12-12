import 'package:ana/Teacher/Students/StudentModel.dart';
import 'package:ana/Teacher/Students/StudentViewScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AllStudents extends StatefulWidget {
  @override
  _AllStudentsState createState() => _AllStudentsState();
}

class _AllStudentsState extends State<AllStudents> {
  List<Student> students = [];
  bool isLoading = true; // Added to track loading state

  @override
  void initState() {
    super.initState();
    fetchAllStudents(); // Update to fetch all students
  }

  Future<void> fetchAllStudents() async {
    final response = await http.post(
      Uri.parse("https://project.pulsezest.com/android/fetchAllStudents.php"),
    );

    print("Response Code: ${response.statusCode}");

    if (response.statusCode == 200) {
      try {
        final data = json.decode(response.body);

        print("Response Data: $data");

        // Check if the "students" key exists in the JSON
        if (data.containsKey("students")) {
          List<Student> studentList = [];

          for (var student in data["students"]) {
            studentList.add(Student.fromJson(student));
          }

          setState(() {
            students = studentList;
            isLoading = false; // Set loading state to false
          });
        } else {
          print("Error: 'students' key not found in the response");
          setState(() {
            isLoading = false; // Set loading state to false in case of an error
          });
        }
      } catch (e) {
        print("Error decoding JSON: $e");
        setState(() {
          isLoading = false; // Set loading state to false in case of an error
        });
      }
    } else {
      // Handle error
      print("Error: ${response.reasonPhrase}");
      setState(() {
        isLoading = false; // Set loading state to false in case of an error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student List"),
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(students[index].name),
            subtitle: Text("Tap to view details"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StudentViewScreen(student: students[index]),
                ),
              );
              // Handle onTap action (e.g., navigate to student details page)
              print("Tapped on ${students[index].name}");
            },
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Handle edit button press
                    Fluttertoast.showToast(msg: "Edit the Details of ${students[index].name} ");
                    print("Edit button pressed for ${students[index].name}");
                  },
                ),
                IconButton(
                  icon: Icon(Icons.auto_graph),
                  onPressed: () {
                    // Handle delete button press
                    Fluttertoast.showToast(msg: "Update the Result of ${students[index].name} ");
                    print("Update Results ${students[index].name}");
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
