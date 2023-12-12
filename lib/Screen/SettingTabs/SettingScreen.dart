import 'package:ana/Screen/ConstScreen/infoScreen.dart';
import 'package:ana/Screen/Login/StudentLoginScreen.dart';
import 'package:ana/ThemeProvider/DarkProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool receiveNotifications = true;
  bool darkModeEnabled = false;

  final ThemeData lightTheme = ThemeData.light();

  // Dark mode theme
  final ThemeData darkTheme = ThemeData.dark();


  void logout() async {
    try {
      // Sign out from Firebase
      await FirebaseAuth.instance.signOut();
      print('User signed out successfully');

      // Clear stored data in SharedPreferences (if applicable)
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();

      // Navigate to the login screen
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StudentLoginScreen())); // Replace with your login route
    } catch (e) {
      print('Error signing out: $e');
    }
  }



  @override
  Widget build(BuildContext context) {

    final darkModeProvider = Provider.of<DarkModeProvider>(context); // Get the DarkModeProvider instance

    // Use the selected theme based on darkModeEnabled
    final ThemeData theme = darkModeProvider.isDarkMode ? darkTheme : lightTheme;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Account Settings',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              title: const Text('Receive Notifications'),
              trailing: Switch(
                value: receiveNotifications,
                onChanged: (value) {
                  setState(() {
                    receiveNotifications = value;
                  });
                },
              ),
            ),
            const Divider(),
            const Text(
              'App Settings',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: darkModeProvider.isDarkMode, // Use dark mode state
            onChanged: (value) {
              darkModeProvider.toggleDarkMode(value); // Update dark mode state
            },
          ),
            ListTile(
              title: const Text('info'),
              leading: const Icon(Icons.info_outline_rounded),
              onTap: (){
                //Navigate to info Screen
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const InfoScreen()));
              },
            ),

            const Divider(),
            ListTile(
              title: const Text('Logout'),
              leading: const Icon(Icons.exit_to_app),
              onTap:  logout,
            ),
          ],
        ),
      ),
    );
  }
}
