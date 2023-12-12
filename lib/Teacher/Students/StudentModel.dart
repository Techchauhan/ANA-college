class Student {
  final String studentId;
  final String name;
  final String email;
  final String number;
  final String dob;
  final String address;
  final String course;
  final String branch;
  final String academicStatus;

  Student({
    required this.studentId,
    required this.name,
    required this.email,
    required this.number,
    required this.dob,
    required this.address,
    required this.course,
    required this.branch,
    required this.academicStatus,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      studentId: json["studentId"],
      name: json["name"],
      email: json["email"],
      number: json["number"],
      dob: json["dob"],
      address: json["address"],
      course: json["course"],
      branch: json["branch"],
      academicStatus: json["AcademicStatus"],
    );
  }
}