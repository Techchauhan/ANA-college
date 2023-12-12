import 'package:flutter/material.dart';

class TeacherInfoPage extends StatefulWidget {
  String teacherName;
  String teacherEmail;
  String teacherNumber;
  String teacherDob;
  String teacherAddress;
  String Course;
  String Branch;
  TeacherInfoPage(
      {Key? key,
      required this.teacherName,
      required this.teacherNumber,
        required this.teacherAddress,
        required this.teacherEmail,
        required this.Branch,
        required this.teacherDob,
        required this.Course
      })
      : super(key: key);

  @override
  State<TeacherInfoPage> createState() => _TeacherInfoPageState();
}

class _TeacherInfoPageState extends State<TeacherInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Info!"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
           const SizedBox(height: 20,),
           const SizedBox(
              child: CircleAvatar(
                radius: 60,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Full Name'),
              subtitle: Text(widget.teacherName),
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email'),
              subtitle: Text(widget.teacherEmail),
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Phone'),
              subtitle: Text('+91 '+widget.teacherNumber),
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Department'),
              subtitle: Text(widget.Course + widget.Branch),
            ),
            ListTile(
              leading: const Icon(Icons.location_pin),
              title:const  Text('Address'),
              subtitle: Text(widget.teacherAddress),
            ),
            ListTile(
              leading: const Icon(Icons.date_range
              ),
              title: const Text('Date of Birth'),
              subtitle: Text(widget.teacherDob),
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
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>const InfoScreen()));
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
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>const InfoScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
