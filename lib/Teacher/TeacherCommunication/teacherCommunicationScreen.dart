import 'package:ana/Teacher/TeacherCommunication/teacherAnnouncementsTab.dart';
import 'package:flutter/material.dart';

class CommunicationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs (Announcements and Messaging)
      child: Scaffold(
        appBar: AppBar(
          title: Text('Communication'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Announcements'),
              Tab(text: 'Messaging'),
            ],
          ),
        ),
        body: TabBarView(

          children: [
            AnnouncementsTab(),
            MessagingTab(),
          ],
        ),
      ),
    );
  }
}


class MessagingTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ListView(
            children: [
              MessageBubble(isMe: true, message: 'Hi there!'),
              MessageBubble(isMe: false, message: 'Hello! How can I help you?'),
              // Add more messages here
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  // Implement message sending functionality
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MessageBubble extends StatelessWidget {
  final bool isMe;
  final String message;

  const MessageBubble({required this.isMe, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Text(
          message,
          style: TextStyle(color: isMe ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}