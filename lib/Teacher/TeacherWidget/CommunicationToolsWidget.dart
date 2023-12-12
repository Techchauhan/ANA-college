import 'package:flutter/material.dart';


class CommunicationToolsWidget extends StatelessWidget {
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
              'Communication Tools',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.0),
            // Your communication tools UI can go here
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Messaging System'),
              subtitle: Text('Communicate with students and staff.'),
              onTap: () {
                // Handle messaging system interaction
              },
            ),
            ListTile(
              leading: Icon(Icons.chat),
              title: Text('Chat Functionality'),
              subtitle: Text('Real-time chat for discussions.'),
              onTap: () {
                // Handle chat functionality interaction
              },
            ),
            // Add more communication tools as needed
          ],
        ),
      ),
    );
  }
}
