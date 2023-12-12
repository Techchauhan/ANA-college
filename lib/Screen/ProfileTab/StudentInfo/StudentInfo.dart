import 'package:ana/Screen/ProfileTab/StudentInfo/ChangePasswordScreen.dart';
import 'package:ana/Screen/ProfileTab/StudentInfo/StudentPaymentScreen.dart';
import 'package:flutter/material.dart';

class StudentInfo extends StatefulWidget {
  String email;
  String phoneNumber;
  String rollNo;
  String dob;
  String address;
  String academicStatus;
  StudentInfo(
      {Key? key,
      required this.address,
      required this.email,
      required this.phoneNumber,
      required this.dob,
      required this.rollNo,
      required this.academicStatus})
      : super(key: key);

  @override
  State<StudentInfo> createState() => _StudentInfoState();
}

class _StudentInfoState extends State<StudentInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: const Text('Email'),
              subtitle: Text(widget.email),
            ),
            ListTile(
              title: const Text('Phone'),
              subtitle: Text(widget.phoneNumber),
            ),
            ListTile(
              title: const Text('Roll No'),
              subtitle: Text(widget.rollNo),
            ),
            ListTile(
              title: const Text('Address'),
              subtitle: Text(widget.address),
            ),
            ListTile(
              title: const Text('Date of Birth'),
              subtitle: Text(widget.dob),
            ),

            ListTile(
              title: const Text('Academic Status'),
              subtitle: Text(widget.academicStatus),
            ),
            // Add more fields as needed

            // Button for changing password
            ListTile(
              title: const Text('Fees'),
              leading:
                  const Icon(Icons.attach_money_rounded, color: Colors.blue),
              iconColor: Colors.black54,
              onTap: () {
                //Navigate to info Screen
                Navigator.push(context, MaterialPageRoute(builder: (context)=>  StudentPaymentScreen()));
              },
            ),
            ListTile(
              title: const Text('Change Password'),
              leading: const Icon(
                Icons.key,
                color: Colors.red,
              ),
              iconColor: Colors.black54,
              onTap: () {
                //Navigate to info Screen
                Navigator.push(context, MaterialPageRoute(builder: (context)=>  ChangePasswordScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
