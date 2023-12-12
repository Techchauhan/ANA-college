import 'package:ana/Const/AuthHelper.dart';
import 'package:ana/Screen/HomePage/TabButton/TabButtonScreen/Event/Event.dart';
import 'package:ana/Screen/HomePage/TabButton/TabButtonScreen/Images/anaPhotos.dart';
import 'package:ana/Screen/HomePage/TabButton/TabButtonScreen/Placement/PlacementScreen.dart';
import 'package:ana/Screen/HomePage/TabButton/TabButtonScreen/Video/anaVideos.dart';
import 'package:ana/Screen/HomePage/TabButton/tabButton.dart';
import 'package:ana/Screen/MessageingScreen/MessageFirstScreen.dart';
import 'package:ana/Screen/MessageingScreen/MessageMainScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _name = ''; // Variable to store the user's name
  String _email = '';
  String _rollNo = '';
  String _phoneNumber = '';
  String _password = '';
  String _userType = '';
  String _dob = '';
  String _courseBranch = ''; // Variable to store the course and branch
  String _address = '';
  String _academicStatus = '';

  final List<String> images = [
    'image1.jpg',
    'image2.jpg',
    'image3.jpg',
    'image4.jpg',
    'image5.jpg',
    'image7.jpg',
  ];

  List<dynamic> announcements = [];

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
    _fetchAnnouncements(); // Call the API when the widget initializes
  }

  Future<void> _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name =
          prefs.getString('name') ?? ''; // Default to empty string if not found
      _email = prefs.getString('email') ?? '';
      _password = prefs.getString('password') ?? 'password';
      _rollNo = prefs.getString('userId') ?? '';
      _phoneNumber = prefs.getString('PhoneNumber') ?? '';
      _dob = prefs.getString('dob') ?? '';
      _academicStatus = prefs.getString('academicStatus') ?? '';
      String course = prefs.getString('course') ?? 'Empty';
      String branch = prefs.getString('branch') ?? 'Empty';
      _address = prefs.getString('address') ?? 'Empty';
      _userType = prefs.getString('userType') ?? '';

      _courseBranch = '$branch - $course';
    });
  }

  Future<void> _fetchAnnouncements() async {
    const String apiUrl =
        'https://project.pulsezest.com/android/fetch_announcements.php';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        setState(() {
          announcements = json.decode(response.body);
        });
      } else {
        print('Failed to fetch announcements: ${response.statusCode}');

        // Add error handling here if needed
      }
    } catch (e) {
      print('Error fetching announcements: $e');

      // Handle network or other errors
    }
  }

  //Check the user is Registered on the Firebase or not.


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Opacity(
            opacity: 0.2,
            child: Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/logo.png',
                width: 220,
                height: 110,
                fit: BoxFit.cover,
                colorBlendMode: BlendMode.darken,
              ),
            ),
          ),

          // Other Widgets (e.g., your main content)

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Add your study-related content here

                CarouselSlider(
                  items: images.map((image) {
                    return Container(
                      margin: const EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          'assets/ana_image/$image',
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 2.0,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      TabButton(
                        icon: Icons.image,
                        text: 'Photos',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  AnaPhoto()));
                        },
                      ),
                      TabButton(
                          icon: Icons.video_library,
                          text: 'Videos',
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>   AnaVideo()));
                          }),
                      TabButton(
                          icon: Icons.event, text: 'Events', onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>EventScreen()));
                      }),
                      TabButton(
                          icon: Icons.person_2_outlined,
                          text: 'Facilities',
                          onPressed: () {}),
                      TabButton(
                          icon: Icons.fireplace_outlined,
                          text: 'Placement',
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>PlacementScreen()));
                          }),
                      TabButton(
                          icon: Icons.contact_emergency,
                          text: 'Contact',
                          onPressed: () {}),
                    ],
                  ),
                ),
                const Text(
                  'Welcome to ANA Group ',
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // Placeholder for study materials or announcements
                Expanded(
                  child: Card(
                    elevation: 3.0,
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Latest Announcements',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          announcements.isNotEmpty
                              ? Card(
                                  elevation: 3.0,
                                  color: Colors.transparent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          announcements
                                              .first['announcement_text'],
                                          style: const TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : const Text(
                                  'No announcements available',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                          // Add more widgets below
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: CircleAvatar(
        radius: 30,
        child: IconButton(
          icon: Image.asset(
            'assets/chat.png',
            fit: BoxFit.fill,
            height: 60,
            width: 60,
          ),
            onPressed: () async {
              FirebaseAuth _auth = FirebaseAuth.instance;

              // Check if the user is already signed in
              if (_auth.currentUser != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MessageMainScreen(currentUserUid: _auth.currentUser!.uid),
                  ),
                );
              }   else {
                  // Email is not registered, navigate to the registration screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MessageFirstScreen(
                        name: _name,
                        email: _email,
                        password: _password,
                        phoneNumber: _phoneNumber,
                        rollNo: _rollNo,
                        userType: _userType,
                      ),
                    ),
                  );
                }
              }
        ),
        // backgroundColor: Colors.transparent,
      ),
    );
  }
}
