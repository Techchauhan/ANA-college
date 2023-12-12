import 'package:shared_preferences/shared_preferences.dart';

class User {
  late String name;
  late String email;
  late String RollNo;
  late String phoneNumber;
  late String dob;
  late String academicStatus;
  late String CourseBranch;

  User() {
    _loadUserInfo();
    this.name;
    this.email;
    this.RollNo;
    this.phoneNumber;
    this.dob;
    this.academicStatus;
    this.CourseBranch;
  }

  Future<void> _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    name = prefs.getString('name') ?? ''; // Default to empty string if not found
    email = prefs.getString('email') ?? '';
    RollNo = prefs.getString('userId') ?? '';
    phoneNumber = prefs.getString('PhoneNumber') ?? '';
    dob = prefs.getString('dob') ?? '';
    academicStatus = prefs.getString('academicStatus') ?? '';
    String course = prefs.getString('course') ?? 'Empty';
    String branch = prefs.getString('branch') ?? 'Empty';
    CourseBranch = '$branch - $course';
  }
}
