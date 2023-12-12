import 'package:flutter/material.dart';


class StudentPerformanceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Student Performance',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.0),
            // Your performance metrics widgets can go here
            // Example: Displaying grades, progress reports, etc.
            ListTile(
              title: Text('Grades'),
              subtitle: Text('Math: A, Science: B+, English: A-'),
            ),
            ListTile(
              title: Text('Progress Reports'),
              subtitle: Text('Overall progress is good.'),
            ),
            ListTile(
              title: Text('Assignments'),
              subtitle: Text('Recent assignments completed: 5'),
            ),
            // Add more performance metrics as needed
          ],
        ),
      ),
    );
  }
}
