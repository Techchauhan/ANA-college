import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  final String recipientUid;
  final String recipientName;

  ChatScreen({Key? key, required this.recipientUid, required this.recipientName}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.recipientName}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _firestore
                  .collection('chats')
                  .doc(_generateChatId())
                  .collection('messages')
                  .orderBy('timestamp')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                var messages = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var message = messages[index].get('message');
                    var sender = messages[index].get('sender');
                    var timestamp = messages[index].get('timestamp');

                    bool isSentByCurrentUser = sender == 'currentUserId'; // Replace 'currentUserId' with the actual current user's UID

                    return Column(
                      crossAxisAlignment: isSentByCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 4.0),
                          child: Text(
                            isSentByCurrentUser ? 'You' : widget.recipientName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Align(
                          alignment: isSentByCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                            child: Bubble(
                              color: isSentByCurrentUser ? Colors.blue : Colors.grey[300],
                              child: Text(
                                message,
                                style: TextStyle(color: isSentByCurrentUser ? Colors.white : Colors.black),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 4.0),
                          child: Text(
                            _formatTimestamp(timestamp),
                            style: TextStyle(fontSize: 12.0, color: Colors.grey),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    String message = _messageController.text.trim();

    if (message.isNotEmpty) {
      _firestore
          .collection('chats')
          .doc(_generateChatId())
          .collection('messages')
          .add({
        'message': message,
        'sender': 'currentUserId', // Replace 'currentUserId' with the actual current user's UID
        'timestamp': FieldValue.serverTimestamp(),
      });

      _messageController.clear();
    }
  }

  String _formatTimestamp(dynamic timestamp) {
    if (timestamp == null) {
      return 'Timestamp not available';
    }

    DateTime dateTime;
    if (timestamp is Timestamp) {
      dateTime = timestamp.toDate();
    } else if (timestamp is DateTime) {
      dateTime = timestamp;
    } else {
      return 'Invalid timestamp format';
    }

    // Customize the date and time format according to your preference
    return '${dateTime.toLocal().toIso8601String()}';
  }

  String _generateChatId() {
    List<String> userIds = [widget.recipientUid, 'currentUserId']; // Replace 'currentUserId' with the actual current user's UID
    userIds.sort();
    return userIds.join('_');
  }
}

class Bubble extends StatelessWidget {
  final Color? color;
  final Widget child;

  Bubble({required this.color, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: child,
    );
  }
}
