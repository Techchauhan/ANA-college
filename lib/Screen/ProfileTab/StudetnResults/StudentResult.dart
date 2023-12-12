import 'package:flutter/material.dart';

class StudentResults extends StatefulWidget {
  const StudentResults({super.key});

  @override
  State<StudentResults> createState() => _StudentResultsState();
}

class _StudentResultsState extends State<StudentResults> {
  // Dummy data for demonstration
  List<String> years = ['1st Year', '2nd Year', '3rd Year', '4th Year'];
  Map<String, List<String>> subjects = {
    '1st Year': ['Subject A', 'Subject B', 'Subject C'],
    '2nd Year': ['Subject X', 'Subject Y', 'Subject Z'],
    '3rd Year': ['Subject P', 'Subject Q', 'Subject R'],
    '4th Year': ['Subject M', 'Subject N', 'Subject O'],
  };

  // Selected values
  String selectedYear = '1st Year';
  String selectedSubject = 'Subject A';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Select Year:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: selectedYear,
              onChanged: (value) {
                setState(() {
                  selectedYear = value!;
                  // Reset subject when year changes
                  selectedSubject = subjects[value!]![0];
                });
              },
              items: years.map<DropdownMenuItem<String>>((String year) {
                return DropdownMenuItem<String>(
                  value: year,
                  child: Text(year),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            Text(
              'Select Subject:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: selectedSubject,
              onChanged: (value) {
                setState(() {
                  selectedSubject = value!;
                });
              },
              items: subjects[selectedYear]!.map<DropdownMenuItem<String>>((String subject) {
                return DropdownMenuItem<String>(
                  value: subject,
                  child: Text(subject),
                );
              }).toList(),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Add logic to fetch and display results based on selectedYear and selectedSubject
                // For now, print the selected values
                print('Selected Year: $selectedYear');
                print('Selected Subject: $selectedSubject');
              },
              child: Text('Show Results'),
            ),
          ],
        ),
      ),
    );
  }
}


