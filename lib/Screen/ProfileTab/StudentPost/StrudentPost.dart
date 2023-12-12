import 'package:flutter/material.dart';

class StudentPost extends StatefulWidget {
  const StudentPost({super.key});

  @override
  State<StudentPost> createState() => _StudentPostState();
}

class _StudentPostState extends State<StudentPost> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Student Posts"),
      ),
    );
  }
}
