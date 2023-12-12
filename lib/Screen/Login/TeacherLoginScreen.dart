import 'dart:convert';
import 'package:ana/Const/Colors.dart';
import 'package:ana/Screen/Login/StudentLoginScreen.dart';
import 'package:ana/Screen/Route/NavigatoScreen.dart';
import 'package:ana/Teacher/TeacherTab/TeacherMainTab.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TeacherLoginScreen extends StatefulWidget {
  @override
  _TeacherLoginScreenState createState() => _TeacherLoginScreenState();
}

class _TeacherLoginScreenState extends State<TeacherLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false; // Added to manage loading state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Teacher Login"),
      ),
      body: _isLoading ? const Center (
        child: CircularProgressIndicator(),
      ) : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 20),

              Align(alignment: Alignment.topRight, child:   IconButton(onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>StudentLoginScreen()));
              }, icon: const Icon(Icons.person)),),


              // Logo
              Image.asset(
                'assets/logo.png', // Replace with the path to your logo image
                height: 200, // Adjust the height as needed
              ),
              const SizedBox(height: 20.0),

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

              const SizedBox(height: 20.0),

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
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loginUser(String email, String password) async {

    const url =
        'https://project.pulsezest.com/android/teacherLogin.php'; // Replace with your API endpoint
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
          data['teacherId'] != null &&
          data['teacherName'] != null &&
          data['teacherCourse'] != null &&
          data['teacherEmail'] != null &&
          data['teacherNumber'] != null &&
          data['teacherDob'] != null &&
          data['teacherAddress'] != null
      ) {
        Fluttertoast.showToast(msg: "Login Successfully....");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('userType', "Teacher");
        prefs.setString('userId', data['teacherId'].toString());
        prefs.setString('teacherName', data['teacherName']);
        prefs.setString('teacherCourse', data['teacherCourse']);
        prefs.setString('teacherBranch', data['teacherBranch']);
        prefs.setString('teacherEmail', data['teacherEmail']);
        prefs.setString('teacherNumber', data['teacherNumber'].toString());
        prefs.setString('teacherDob', data['teacherDob']);
        prefs.setString('teacherAddress', data['teacherAddress']);
        prefs.setString('teacherPassword', data['teacherPassword']);
        // Navigate to the next screen or perform desired action

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => TeacherMainTab()));
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


    setState(() {
      _isLoading = false; // Set loading state to false after login process completes
    });
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
