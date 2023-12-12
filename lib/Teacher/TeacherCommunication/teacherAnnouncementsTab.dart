import 'dart:convert';
import 'package:ana/Const/Colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AnnouncementsTab extends StatefulWidget {
  @override
  _AnnouncementsTabState createState() => _AnnouncementsTabState();
}

class _AnnouncementsTabState extends State<AnnouncementsTab> {
  List<dynamic> announcements = [];
  bool isLoading = false;

  Future<void> _addAnnouncement(String announcement) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String teacherName = prefs.getString('teacherName') ?? 'Empty';
    String department = prefs.getString('department') ?? 'Empty';
    const String apiUrl =
        'https://project.pulsezest.com/android/announcements.php';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'teacherName': teacherName,
          'department': department,
          'announcement': announcement,
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          announcements.insert(0, announcement);
        });
      } else {
        print(
            'Failed to save announcement. Status code: ${response.statusCode}');
        // Add error handling here if needed
      }
    } catch (e) {
      print('Error while saving announcement: $e');
      // Handle network or other errors
    }
  }

  Future<void> _fetchAnnouncements() async {
    setState(() {
      isLoading = true; // Set loading to true while fetching data
    });

    const String apiUrl =
        'https://project.pulsezest.com/android/fetch_announcements.php';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        setState(() {
          announcements = json.decode(response.body);
          isLoading = false; //
        });
      } else {
        print('Failed to fetch announcements: ${response.statusCode}');
        isLoading = false; //
        // Add error handling here if needed
      }
    } catch (e) {
      print('Error fetching announcements: $e');
      isLoading = false; //
      // Handle network or other errors
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchAnnouncements(); // Fetch announcements when the widget initializes
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: isLoading
              ? Center(
                  child:
                      CircularProgressIndicator(
                        color: AppColors.defaultColor,
                      ), // Show circular progress indicator while loading
                )
              : ListView.builder(
                  itemCount: announcements.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Announcement ${index + 1}'),
                      subtitle: Text(announcements[index]['announcement_text']),
                    );
                  },
                ),
        ),
        FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                String newAnnouncement = '';
                return AlertDialog(
                  title: Text('New Announcement'),
                  content: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        newAnnouncement = value;
                      },
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: 'Enter announcement...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        if (newAnnouncement.isNotEmpty) {
                          _addAnnouncement(newAnnouncement);
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text('Send'),
                    ),
                  ],
                );
              },
            );
          },
          child: const Icon(Icons.add),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
