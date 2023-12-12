import 'package:ana/Screen/MessageingScreen/ChatScreen.dart';
import 'package:ana/Screen/MessageingScreen/MessageMainScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageMainScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String currentUserUid; // Add this field

  MessageMainScreen({Key? key, required this.currentUserUid}) : super(key: key); // Update the constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Users'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: _firestore.collection('users').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<DocumentSnapshot> users = snapshot.data!.docs;

            // Filter out the current user
            List<DocumentSnapshot> otherUsers = users
                .where((user) => user.id != currentUserUid)
                .toList();

            return ListView.builder(
              itemCount: otherUsers.length,
              itemBuilder: (context, index) {
                String userName = otherUsers[index].get('name');
                bool isActive = otherUsers[index].get('isActive') ?? false;
                DateTime lastActive = otherUsers[index].get('lastActive')?.toDate() ?? DateTime.now();

                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(userName[0]),
                    ),
                    title: Text(userName),
                    subtitle: Text('Last Active: ${_formatLastActive(lastActive)}'),
                    trailing: isActive
                        ? Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                    )
                        : null,
                    onTap: () {
                      // Navigate to the messaging screen with the selected user
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            recipientUid: otherUsers[index].id,
                            recipientName: userName,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  String _formatLastActive(DateTime lastActive) {
    return '${lastActive.hour}:${lastActive.minute}';
  }
}


