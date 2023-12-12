import 'package:ana/Const/Colors.dart';
import 'package:ana/Screen/Login/StudentLoginScreen.dart';
import 'package:ana/Screen/Route/NavigatoScreen.dart';
import 'package:ana/Teacher/TeacherTab/TeacherMainTab.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // After a delay, check if email exists in SharedPreferences
    Future.delayed(const Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? email = prefs.getString('email');
      String? teacherEmail = prefs.getString('teacherEmail');

      if (email != null && email.isNotEmpty) {
        // Email exists, navigate to HomeTab
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => HomeTabs(),
          ),
        );
      } else if (teacherEmail != null && teacherEmail.isNotEmpty){
        // Email doesn't exist, navigate to LoginScreen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => TeacherMainTab(),
          ),
        );
      } else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>StudentLoginScreen()));
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(child: Image.asset('assets/logo.png', height: 300, width: 300,)),
            // Add your splash screen content here
            const SizedBox(height: 16),
            const CircularProgressIndicator(
              color: AppColors.defaultColor,
            ), // You can add a loading indicator
            const SizedBox(height: 70),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Made By PulseZest',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.favorite, color: Colors.red,),
              ],
            )

          ],
        ),
      ),
    );
  }
}