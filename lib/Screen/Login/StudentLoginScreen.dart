import 'dart:convert';
import 'package:ana/Const/Colors.dart';
import 'package:ana/Screen/Login/TeacherLoginScreen.dart';
import 'package:ana/Screen/Route/NavigatoScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class StudentLoginScreen extends StatefulWidget {
  @override
  _StudentLoginScreenState createState() => _StudentLoginScreenState();
}

class _StudentLoginScreenState extends State<StudentLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 30),
              Align(alignment: Alignment.topRight, child:   IconButton(onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TeacherLoginScreen()));
              }, icon: const Icon(Icons.person)),),

              const SizedBox(height: 50),
              // Logo
              Image.asset(
                'assets/logo.png', // Replace with the path to your logo image
                height: 200, // Adjust the height as needed
              ),
              const SizedBox(height: 16.0),

              // Email Text Field
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Enter Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 16.0),

              // Password Text Field
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 12.0),

              // Forgot Password Link
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Implement your forgot password logic
                    // For example, show a dialog or navigate to a forgot password screen
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: AppColors.defaultColor),
                  ),
                ),
              ),

              const SizedBox(height: 24.0),

              // Login Button
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  primary: AppColors.defaultColor, // Button color
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 18),
                ),
              ),

              const SizedBox(height: 12.0),

              // Or Register Link
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    // Implement your register logic
                    // For example, navigate to the registration screen
                  },
                  child: const Text(
                    'Kindly Contact with your Teacher if, first Time',
                    style: TextStyle(color: AppColors.defaultColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loginUser(String email, String password) async {

    const url =
        'https://project.pulsezest.com/android/login.php'; // Replace with your API endpoint
    final response = await http.post(
      Uri.parse(url),
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {


      // Successfully authenticated
      final data = json.decode(response.body);

      if (data != null &&
          data['studentId'] != null &&
          data['name'] != null &&
          data['course'] != null &&
          data['branch'] != null &&
          data['email'] != null &&
          data['number'] != null &&
          data['dob'] != null &&
          data['address'] != null &&
          data['AcademicStatus'] != null
      ) {
        Fluttertoast.showToast(msg: "Login Successfully....");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('userType', "Student");
        prefs.setString('userId', data['studentId'].toString());
        prefs.setString('name', data['name']);
        prefs.setString('course', data['course']);
        prefs.setString('branch', data['branch']);
        prefs.setString('email', data['email']);
        prefs.setString('PhoneNumber', data['number'].toString());
        prefs.setString('dob', data['dob']);
        prefs.setString('password', data['password']);
        prefs.setString('address', data['address']);
        prefs.setString('academicStatus', data['AcademicStatus']);
        // Navigate to the next screen or perform desired action

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeTabs()));
      } else {
        Fluttertoast.showToast(msg: "Please Enter Valid Email or Password");
        // Handle if data is null or any specific fields are null
        // Show error message or handle accordingly
      }
    } else {
      Fluttertoast.showToast(msg: "Update Your Form");
      // Handle authentication failure
      // Show error message or handle accordingly
    }
  }

  void _login() {
    print('button Pressed');

    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    String email = _emailController.text;
    String password = _passwordController.text;
    if(email.isNotEmpty && password.isNotEmpty){
      loginUser(email, password);
    } else{
      Fluttertoast.showToast(msg: "Please fill the fields Properly");
    }

  }
}
