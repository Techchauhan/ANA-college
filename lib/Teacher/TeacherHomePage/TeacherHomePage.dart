import 'package:ana/Const/Colors.dart';
import 'package:ana/Screen/HomePage/TabButton/TabButtonScreen/Event/Event.dart';
import 'package:ana/Screen/HomePage/TabButton/TabButtonScreen/Images/anaPhotos.dart';
import 'package:ana/Screen/HomePage/TabButton/TabButtonScreen/Video/anaVideos.dart';
import 'package:ana/Teacher/TeacherCommunication/teacherCommunicationScreen.dart';
import 'package:ana/Teacher/TeacherInfoPage/teacherInfoPage.dart';
import 'package:ana/Teacher/TeacherWidget/AnalyticsReportingWidget.dart';
import 'package:ana/Teacher/TeacherWidget/CommunicationToolsWidget.dart';
import 'package:ana/Teacher/TeacherWidget/ShedualCalendarWidget.dart';
import 'package:ana/Teacher/TeacherWidget/StudentPerformanceWidget.dart';
import 'package:ana/Teacher/TeacherWidget/TaskManagementWidget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TeacherHomePage extends StatefulWidget {
  const TeacherHomePage({super.key});

  @override
  State<TeacherHomePage> createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
    // Variable to store the user's name
  String _teacherId = '';
  String _teacherName = '';
  String _teacherEmail = '';
  String _teacherNumber = '';
  String _teacherDob = '';
  String _teacherCourseBranch = '';
  String _teacherAddress = '';
  String _teacherPassword = '';
  String _userType = '';


  @override
  void initState() {
    super.initState();
    _logTeacherInfo(); // Load user information from SharedPreferences
  }

  Future<void> _logTeacherInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _teacherId = prefs.getString('teacherId') ?? '';
      _teacherName = prefs.getString('teacherName') ?? ''; // Default to empty string if not found
      _teacherEmail = prefs.getString('teacherEmail') ?? '';
      _teacherNumber = prefs.getString('teacherNumber') ?? '';
      _teacherDob = prefs.getString('teacherDob') ?? '';
      String teacherCourse = prefs.getString('teacherCourse') ?? 'Empty';
      String teacherBranch = prefs.getString('teacherBranch') ?? 'Empty';
      _teacherAddress = prefs.getString('teacherAddress') ?? 'Empty';
      _teacherCourseBranch = '$teacherBranch - $teacherCourse';

      _teacherPassword = prefs.getString('teacherPassword') ?? 'Empty';
      _userType = prefs.getString('userType') ?? 'Empty';
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          flexibleSpace: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 16.0, left: 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 16.0),
                    Text(
                      "Welcome: $_teacherName",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: AppColors.defaultColor,
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 40,
                    child: Image.asset(
                      'assets/logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Text(_teacherEmail, style: const TextStyle(color: Colors.white),)
                ],
              )
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.amberAccent,),
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> TeacherInfoPage( teacherNumber: _teacherNumber, teacherAddress: _teacherAddress, teacherEmail: _teacherEmail, Branch: _teacherCourseBranch, teacherDob: _teacherDob, Course: "", teacherName: _teacherName,)
                ));
                // Handle item 1 tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.image, color: AppColors.defaultColor,),
              title: const Text('Images'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AnaPhoto()
                ));
                // Handle item 1 tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.play_circle, color: Colors.red,),
              title: const Text('Videos'),
              onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context)=> AnaVideo()));
                // Handle item 1 tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.event, color: Colors.deepOrangeAccent,),
              title: const Text('Events'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> EventScreen()));
                // Handle item 1 tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logo Out'),
              onTap: () {
                // Handle item 2 tap
              },
            ),
            // Add more ListTiles for additional items
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[


              _buildDashboardOverview(),

              _buildCoursesOverview(),

              _buildAnnouncementsAndNotifications(),


              ScheduleCalendarWidget(),
            ],
          ),
        ),
      ),
     floatingActionButton: CircleAvatar(
       child: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>CommunicationScreen(name: _teacherName, email: _teacherEmail, password: _teacherPassword, phoneNumber: _teacherNumber, userType: _userType,)));
       }, icon: const Icon(Icons.message_outlined),),
     ),
    );
  }

  // Dashboard Overview Widget
  Widget _buildDashboardOverview() {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Dashboard Overview',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12.0),
            _buildDashboardItem('Courses Taught', '5'), // Replace '5' with dynamic data
            _buildDashboardItem('Total Students', '150'), // Replace '150' with dynamic data
            _buildDashboardItem('Pending Tasks', '3'), // Replace '3' with dynamic data
            _buildDashboardItem('Upcoming Events', '2'), // Replace '2' with dynamic data
            // Add more dashboard items as needed
          ],
        ),
      ),
    );
  }

// Dashboard Item Widget
  Widget _buildDashboardItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title + ':',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8.0),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  // Courses Overview Widget
  Widget _buildCoursesOverview() {
    // Replace this with your actual list of courses (this is a sample)
    List<Map<String, dynamic>> courses = [
      {
        'courseName': 'Mathematics',
        'schedule': 'Mon, Wed, Fri 9:00 AM - 10:30 AM',
        'enrolledStudents': 30,
      },
      {
        'courseName': 'Science',
        'schedule': 'Tue, Thu 11:00 AM - 12:30 PM',
        'enrolledStudents': 25,
      },
      // Add more courses as needed
    ];

    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Courses Overview',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12.0),
            // Display each course as a list tile
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: courses.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    courses[index]['courseName'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Schedule: ${courses[index]['schedule']}'),
                      Text(
                        'Enrolled Students: ${courses[index]['enrolledStudents']}',
                      ),
                    ],
                  ),
                  // You can add onTap functionality for each course tile
                  onTap: () {
                    // Handle tapping on a course
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

// Announcements and Notifications Widget
  Widget _buildAnnouncementsAndNotifications() {
    // Replace this with your actual list of announcements/notifications (this is a sample)
    List<Map<String, dynamic>> announcements = [
      {
        'title': 'Important Meeting',
        'description': 'Meeting with department heads on Friday at 10 AM.',
      },
      {
        'title': 'Assignment Submission',
        'description': 'Reminder: Science assignment due next Monday.',
      },
      // Add more announcements as needed
    ];

    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Announcements and Notifications',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12.0),
            // Display each announcement as a list tile
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: announcements.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    announcements[index]['title'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(announcements[index]['description']),
                  // You can add onTap functionality for each announcement tile
                  onTap: () {
                    // Handle tapping on an announcement/notification
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

}
