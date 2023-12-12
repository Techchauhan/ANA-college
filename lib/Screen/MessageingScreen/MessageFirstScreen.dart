import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ana/Screen/MessageingScreen/MessageMainScreen.dart';
import 'package:ana/Widget/AnimatedButton.dart';

class MessageFirstScreen extends StatefulWidget {
  const MessageFirstScreen({
    Key? key,
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.rollNo,
    required this.userType,

  }) : super(key: key);

  final String name;
  final  String email;
  final String password;
  final  String phoneNumber;
  final String rollNo;
  final String userType;

  @override
  State<MessageFirstScreen> createState() => _MessageFirstScreenState();
}

class _MessageFirstScreenState extends State<MessageFirstScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    checkRegistrationStatus();
  }

  void checkRegistrationStatus() async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        // Check if the user is registered in Firestore
        DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(user.uid).get();

        if (userDoc.exists) {
          // User is registered, navigate to another page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MessageMainScreen(currentUserUid: user.uid),
            ),
          );
        }
      }
    } catch (e) {
      print('Error checking registration status: $e');
    }
  }

  Future<void> _register() async {
    print(widget.name);
    print(widget.email);
    print(widget.password);

    try {
      // Try to sign in with the provided email and password
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: widget.email,
        password: widget.password,
      );

      // Login successful, navigate to the home screen or perform other actions
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MessageMainScreen(currentUserUid: userCredential.user!.uid),
        ),
      );
    } catch (signInError) {
      // If the user is not registered, attempt registration
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: widget.email,
          password: widget.password,
        );

        // Ensure the 'users' collection exists in Firestore
        CollectionReference usersCollection = _firestore.collection('users');
        if (!(await usersCollection.doc(userCredential.user!.uid).get()).exists) {
          await usersCollection.doc(userCredential.user!.uid).set({
            'name': widget.name,
            'email': widget.email,
            'id': userCredential.user!.uid,
            'isActive': true,
            'token': 'token', // You can add your custom fields here
            'lastActive': DateTime.now(),
            'userType': widget.userType,
          });
        }

        // Login the user after registration
        await _login();

      } catch (e) {
        // Handle registration errors
        print('Error during registration: $e');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Registration Error'),
              content: Text('An error occurred during registration. Please try again.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

// Add the _login method as described in the previous response
  Future<void> _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: widget.email,
        password: widget.password,
      );

      // Navigate to the home screen or perform any other actions after successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MessageMainScreen(currentUserUid: userCredential.user!.uid),
        ),
      );
    } catch (e) {
      // Handle login errors
      print('Error during login: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: LottieBuilder.asset('assets/messaging.json'),
          ),
          const Text(
            "Start Your Messaging journey \n from ANA Side.",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20,),
          AnimatedButton(onPress: _register,)
        ],
      ),
    );
  }
}
