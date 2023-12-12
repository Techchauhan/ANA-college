import 'package:firebase_auth/firebase_auth.dart';

class AuthHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Function to check if a user with the provided email is registered
  Future<bool> isEmailRegistered(String email) async {
    try {
      // Check if a user with the provided email exists
      await _auth.fetchSignInMethodsForEmail(email);
      return true; // User is registered
    } on FirebaseAuthException catch (e) {
      // If the error code is 'user-not-found', the user is not registered
      if (e.code == 'user-not-found') {
        return false;
      }
      // Handle other authentication errors if needed
      print('Error during email registration check: $e');
      return false;
    }
  }
}
