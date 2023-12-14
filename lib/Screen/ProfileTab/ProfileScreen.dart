import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ana/Const/Colors.dart';
import 'package:ana/Screen/ProfileTab/StudentPost/StrudentPost.dart';
import 'package:ana/Screen/ProfileTab/StudetnResults/StudentResult.dart';
import 'package:ana/Screen/ProfileTab/StudentInfo/StudentInfo.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = ''; // Variable to store the user's name
  String _email = '';
  String _rollNo = '';
  String _phoneNumber = '';
  String _dob = '';
  String _userType = '';
  String _courseBranch = ''; // Variable to store the course and branch
  String _address = '';
  String _academicStatus = '';
  @override
  void initState() {
    super.initState();
    _loadUserInfo(); // Load user information from SharedPreferences
  }

  // Function to load user information from SharedPreferences
  Future<void> _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name =
          prefs.getString('name') ?? ''; // Default to empty string if not found
      _email = prefs.getString('email') ?? '';
      _rollNo = prefs.getString('userId') ?? '';
      _phoneNumber = prefs.getString('PhoneNumber') ?? '';
      _userType = prefs.getString('userType') ?? '';
      _dob = prefs.getString('dob') ?? '';
      _academicStatus = prefs.getString('academicStatus') ?? '';
      String course = prefs.getString('course') ?? 'Empty';
      String branch = prefs.getString('branch') ?? 'Empty';
      _address = prefs.getString('address') ?? 'Empty';

      _courseBranch = '$branch - $course';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          // Profile Picture
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(
                'assets/ana_logo.png'), // Replace with your image asset
          ),
          const SizedBox(height: 16),

          // Student Name
          Text(
            _name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),

          // Course Information
          Text(
            _courseBranch,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),

          Expanded(
            child: DefaultTabController(
              length: 3, // Number of tabs
              child: Column(
                children: [
                  Container(
                    height: 60,
                    color: AppColors
                        .defaultColor, // Set the background color of the TabBar
                    child: const TabBar(
                      indicatorColor: Colors.blue,
                      indicatorWeight: 9.0, // Set the indicator color
                      tabs: [
                        Column(
                          children: [
                            Icon(
                              Icons.edit_note,
                              size: 20,
                            ),
                            Text("Posts"),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(
                              Icons.analytics,
                              size: 20,
                            ),
                            Text("Results"),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(
                              Icons.person,
                              size: 20,
                            ),
                            Text("Info"),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // Content of Tab 1
                          StudentPost(userType: _userType, userId: _rollNo,),
                        // Content of Tab 2
                        const StudentResults(),
                        // Content of Tab 3
                        StudentInfo(
                          address: _address,
                          email: _email,
                          phoneNumber: _phoneNumber,
                          dob: _dob,
                          rollNo: _rollNo,
                          academicStatus: _academicStatus,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
