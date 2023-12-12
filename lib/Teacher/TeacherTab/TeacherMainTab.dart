import 'package:ana/Screen/ProfileTab/ProfileScreen.dart';
import 'package:ana/Screen/SettingTabs/SettingScreen.dart';
import 'package:ana/Screen/SocialTab/SocialScreen.dart';
import 'package:ana/Screen/StudyPoint/StudysScreen.dart';
import 'package:ana/Teacher/Students/AllStudents.dart';
import 'package:ana/Teacher/TeacherHomePage/TeacherHomePage.dart';
import 'package:ana/Teacher/TeacherStudy/TeacherStudyPoint.dart';
import 'package:flutter/material.dart';

class TeacherMainTab extends StatefulWidget {
  @override
  _TeacherMainTabState createState() => _TeacherMainTabState();
}

class _TeacherMainTabState extends State<TeacherMainTab> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const TeacherHomePage(),
    AllStudents(),
    const SocialScreen(),
    TeacherStudyPoint(),
    const SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('ANA Group of Institute'),
        backgroundColor: const Color(0xFF032a5c),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.notifications))
        ],
      ),


      body: Container(
        color: Colors.grey[200], // Background color for the entire screen
        child: _tabs[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF032a5c), // Background color for the BottomNavigationBar
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        }, items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: Color(0xFF032a5c),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.timeline),
          label: 'Student',
          backgroundColor: Color(0xFF032a5c), // Background color for ProfileTab
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.public),
          label: 'Social',
          backgroundColor: Color(0xFF032a5c),// Background color for SocialTab
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.library_books_sharp),
          label: 'Study Point',
          backgroundColor: Color(0xFF032a5c), // Background color for SettingsTab
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Setting',
          backgroundColor: Color(0xFF032a5c), // Background color for ExtraTab
        ),
      ],
      ),
    );
  }
}

