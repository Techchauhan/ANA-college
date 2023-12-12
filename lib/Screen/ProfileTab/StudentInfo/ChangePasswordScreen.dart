import 'package:flutter/material.dart';



class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: oldPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Old Password'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'New Password'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: confirmNewPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Confirm New Password'),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                // Add your logic to check and change the password
                changePassword();
              },
              child: Text('Change Password'),
            ),
          ],
        ),
      ),
    );
  }

  void changePassword() {
    String oldPassword = oldPasswordController.text;
    String newPassword = newPasswordController.text;
    String confirmNewPassword = confirmNewPasswordController.text;

    // Add your password change logic here
    if (newPassword == confirmNewPassword) {
      // Passwords match, perform the password change
      // You can add additional validation and logic here
      // For simplicity, we just print a message
      print('Password changed successfully!');
    } else {
      // Passwords don't match, show an error message
      // You can also add more sophisticated error handling
      print('Passwords do not match. Please try again.');
    }
  }
}
