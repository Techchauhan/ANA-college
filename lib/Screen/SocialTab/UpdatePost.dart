import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class UpdatePost extends StatefulWidget {
  final String postId;
  final String currentContent;

  const UpdatePost({Key? key, required this.postId, required this.currentContent}) : super(key: key);

  @override
  _UpdatePostState createState() => _UpdatePostState();
}

class _UpdatePostState extends State<UpdatePost> {
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    contentController.text = widget.currentContent;
  }

  Future<void> updatePost() async {
    final apiUrl = 'https://project.pulsezest.com/android/updatePost.php';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'post_id': widget.postId.toString(),
          'new_content': contentController.text,
        },
      );

      if (response.statusCode == 200) {
        // Post updated successfully
        Fluttertoast.showToast(msg: "Post Updated Successfully");
        print('Post updated successfully');

        // You can handle the success scenario (e.g., show a success message)

        // Navigate back to the previous page
        Navigator.pop(context);
      } else {
        // Error updating post
        print('Error updating post: ${response.statusCode}');
        // You can handle the error scenario (e.g., show an error message)
      }
    } catch (e) {
      print('Exception during update: $e');
      // Handle exceptions if any
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("OLD POST", style: TextStyle(fontWeight: FontWeight.bold),),
            Text('Current Content: ${widget.currentContent}'),
            const SizedBox(height: 30,),

            const Text("Become a New Post", style: TextStyle(fontWeight: FontWeight.bold),),
            TextField(
              controller: contentController,
              maxLines: null, // Allow multiple lines for post content
              decoration: const InputDecoration(labelText: 'New Content'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                // Call the updatePost method when the button is pressed
                await updatePost();
              },
              child: const Text('Update Post'),
            ),
          ],
        ),
      ),
    );
  }
}
