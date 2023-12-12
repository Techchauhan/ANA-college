import 'dart:convert';
import 'package:ana/Screen/Route/NavigatoScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreatePost extends StatefulWidget {
  String userType;
  String userId;

  CreatePost({Key? key, required this.userType, required this.userId}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  TextEditingController postController = TextEditingController();
  bool isBold = false;
  bool isItalic = false;
  bool isHighlighted = false;
  XFile? selectedImage;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = pickedImage;
    });
  }


  Future<void> createPost(String userId, String userType, String postContent, XFile? image) async {
    const url = 'https://project.pulsezest.com/android/createPost.php'; // Replace with your API endpoint

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      // Add text fields
      request.fields['user_id'] = userId;
      request.fields['user_type'] = userType;
      request.fields['post_content'] = postContent;

      // Add image if available
      if (image != null) {
        var fileStream = http.ByteStream(image.openRead());
        var length = await image.length();

        var multipartFile = http.MultipartFile('image', fileStream, length,
            filename: '${DateTime.now().toIso8601String()}_${image.name}');

        request.files.add(multipartFile);
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        // Successfully created post
        print('Post created successfully');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeTabs()));
      } else {
        // Handle error scenarios
        print('Error: ${response.statusCode}, ${await response.stream.bytesToString()}');
      }
    } catch (e) {
      // Handle network or other errors
      print('Error: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle back button press
        return await showExitConfirmationDialog(context) ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('New Post'),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Add logic to handle post submission
                String postText = postController.text;
                if (postText.isNotEmpty) {
                  // Add logic to upload the post
                  // For now, print the post text
                  createPost(widget.userId, widget.userType, postText, selectedImage);



                  print('Post userId:   $postText');
                  Fluttertoast.showToast(msg: "Post Uploaded");


                  // You can add further logic here, such as sending the post to a server or database.
                } else {
                  // Show an error message or prevent submission if the post is empty
                  print('Error: Post cannot be empty');
                }
              },
              child: const Row(children: [Icon(Icons.check), Text("Post")]),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isBold = !isBold;
                        });
                      },
                      icon: Icon(Icons.format_bold),
                      color: isBold ? Colors.blue : Colors.black,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isItalic = !isItalic;
                        });
                      },
                      icon: Icon(Icons.format_italic),
                      color: isItalic ? Colors.blue : Colors.black,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isHighlighted = !isHighlighted;
                        });
                      },
                      icon: Icon(Icons.highlight),
                      color: isHighlighted ? Colors.blue : Colors.black,
                    ),
                    IconButton(
                      onPressed: _pickImage,
                      icon: Icon(Icons.image),
                      color: isHighlighted ? Colors.blue : Colors.black,
                    ),
                  ],
                ),
                TextField(
                  controller: postController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Write your post here...',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                Divider(
                  thickness: 2,
                ),
                SizedBox(height: 16),
                SizedBox(height: 16),
                Text(
                  "Your Post Looks like",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    children: [
                      if (selectedImage != null)
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Image.file(
                            File(selectedImage!.path), // Convert XFile to File
                            fit: BoxFit.cover,
                          ),
                        ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: postController.text,
                              style: TextStyle(
                                fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
                                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                                backgroundColor: isHighlighted ? Colors.yellow : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.favorite, color: Colors.red),
                          SizedBox(width: 10),
                          Icon(Icons.comment, color: Colors.brown),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool?> showExitConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Do you want to discard this post?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Pop the current screen
              },
              child: Text('Discard'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Continue editing
              },
              child: Text('Continue Editing'),
            ),
          ],
        );
      },
    );
  }
}
