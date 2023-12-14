import 'package:ana/Screen/ProfileTab/StudentPost/StrudentPost.dart';
import 'package:ana/Screen/SocialTab/CreatePost.dart';
import 'package:ana/Screen/SocialTab/UpdatePost.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SocialScreen extends StatefulWidget {
  const SocialScreen({Key? key}) : super(key: key);

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  String userType = "";
  String userId = "";

  @override
  void initState() {
    super.initState();
    _checkUserType();
  }

  Future<void> _checkUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userType = prefs.getString('userType') ?? '';
      userId = prefs.getString('userId') ?? '';
    });
  }

  Future<List<dynamic>> fetchPosts() async {
    try {
      final response = await http.get(Uri.parse('https://project.pulsezest.com/android/posts.php'));

      if (response.statusCode == 200) {
        final List<dynamic> posts = jsonDecode(response.body);
        return posts;
      } else {
        print('Failed to load posts. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        return [];
      }
    } catch (error) {
      print('Error fetching posts: $error');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social ANA'),
        backgroundColor: const Color(0xFF032a5c),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 200.0,
              child: TextField(
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.white54),
                  suffixIcon: Icon(Icons.search, color: Colors.white),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  // Handle search input
                },
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<dynamic> posts = snapshot.data as List<dynamic>;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return    Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Card(
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                posts[index]['user_type'].toString().toLowerCase() == 'student'
                                    ? Icons.school // Use an appropriate icon for student
                                    : Icons.work, // Use an appropriate icon for other types
                                color: posts[index]['user_type'].toString().toLowerCase() == 'student'
                                    ? Colors.blue
                                    : Colors.green,
                              ),
                              SizedBox(width: 8.0), // Add some spacing between the icon and text
                              Text(
                                '${posts[index]['user_first_name']} ${posts[index]['user_last_name']} - ${capitalize(posts[index]['user_type'])}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: posts[index]['user_type'].toString().toLowerCase() == 'student'
                                      ? Colors.blue
                                      : Colors.green,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8.0),
                          Text(
                            posts[index]['post_content'],
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          if (posts[index]['image_path'] != null)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Image.network("https://project.pulsezest.com/android/"+posts[index]['image_path']),
                            ),
                          const Divider(height: 1, color: Colors.grey),
                          const SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.thumb_up,
                                      color: posts[index]['liked'] ?? false ? Colors.blue : Colors.grey,
                                    ),
                                    onPressed: () {
                                      // Handle like button press
                                      setState(() {
                                        posts[index]['liked'] = !(posts[index]['liked'] ?? false);
                                      });
                                    },
                                  ),
                                  const SizedBox(width: 8.0),
                                  Text(
                                    'Like',
                                    style: TextStyle(color: posts[index]['liked'] ?? false ? Colors.blue : Colors.grey),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.comment),
                                    onPressed: () {
                                      // Handle comment button press
                                    },
                                  ),
                                  const SizedBox(width: 8.0),
                                  Text('Comment'),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'Posted on: ${posts[index]['post_timestamp']}',
                            style: const TextStyle(color: Colors.grey),
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
      floatingActionButton: SpeedDial(
        icon: Icons.edit,
        activeIcon: Icons.close,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 8.0,
        shape: const CircleBorder(),
        children: [
          SpeedDialChild(
            child: const Icon(Icons.create),
            backgroundColor: Colors.green,
            label: 'Create Post',
            labelStyle: const TextStyle(fontSize: 16.0),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePost(userType: userType, userId: userId,)));
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.update),
            backgroundColor: Colors.green,
            label: 'Update Post',
            labelStyle: const TextStyle(fontSize: 16.0),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  StudentPost(userType: userType, userId: userId)));
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.favorite),
            backgroundColor: Colors.red,
            label: 'Favorite',
            labelStyle: const TextStyle(fontSize: 16.0),
            onTap: () {
              // Handle Favorite action
            },
          ),
          // Add more SpeedDialChild as needed
        ],
      ),
    );
  }

  String capitalize(String input) {
    if (input == null || input.isEmpty) {
      return '';
    }
    return input[0].toUpperCase() + input.substring(1);
  }

}
