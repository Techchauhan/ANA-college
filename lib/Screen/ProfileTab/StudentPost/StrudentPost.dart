import 'dart:convert';
import 'package:ana/Screen/SocialTab/UpdatePost.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StudentPost extends StatefulWidget {
  final String userType;
  final String userId;

  const StudentPost({Key? key, required this.userType, required this.userId}) : super(key: key);

  @override
  _StudentPostState createState() => _StudentPostState();
}

class _StudentPostState extends State<StudentPost> {
  Future<List<dynamic>> fetchStudentPosts() async {
    // Replace the API_URL with the actual URL of your API
    final apiUrl = 'https://project.pulsezest.com/android/userPosts.php?user_type=${widget.userType}&user_id=${widget.userId}';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      return jsonDecode(response.body);
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: fetchStudentPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Display the fetched posts
            List<dynamic> posts = snapshot.data ?? [];
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // You can adjust the cross-axis count as needed
              ),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                String imagePath = "https://project.pulsezest.com/android/" + (posts[index]['image_path'] ?? '');

                return Card(
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to the update page with the post details
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdatePost(
                            postId: posts[index]['post_id'], // Pass the post ID or any other necessary data
                            currentContent: posts[index]['post_content'] ?? '',
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 200, // Set a fixed height for the Card container
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Show the image if available
                          posts[index]['image_path'] != null
                              ? Expanded(
                            child: Image.network(
                              imagePath,
                              fit: BoxFit.cover, // Adjust the BoxFit as needed
                            ),
                          )
                              : Container(
                            height: 100, // Placeholder height
                            color: Colors.grey, // Placeholder color
                            child: Center(
                              child: Icon(
                                Icons.image,
                                size: 50, // Adjust the size as needed
                                color: Colors.white,
                              ),
                            ),
                          ),

                          // Show title and content
                          ListTile(
                            title: Text(posts[index]['post_title'] ?? ''),
                            subtitle: Text(
                              getFirstWords(posts[index]['post_content'] ?? '', 20),
                              // Display the first 20 words of the post content
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );

              },

            );
          }
        },
      ),
    );
  }
  String getFirstWords(String text, int wordCount) {
    List<String> words = text.split(' ');
    int endIndex = words.length < wordCount ? words.length : wordCount;
    return words.sublist(0, endIndex).join(' ');
  }


}
