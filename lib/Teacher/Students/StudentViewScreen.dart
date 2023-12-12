import 'package:ana/Teacher/Students/StudentModel.dart';
import 'package:flutter/material.dart';

class StudentViewScreen extends StatelessWidget {
  final Student student;

  StudentViewScreen({required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${student.name}"),
            Text("Email: ${student.email}"),
            Text("Number: ${student.number}"),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}