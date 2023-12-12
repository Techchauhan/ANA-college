import 'package:ana/Const/Colors.dart';
import 'package:ana/Screen/HomePage/TabButton/TabButtonScreen/Video/YouTubeVideoPage.dart';
import 'package:flutter/material.dart';

class AnaVideo extends StatefulWidget {
  @override
  _AnaVideoState createState() => _AnaVideoState();
}

class _AnaVideoState extends State<AnaVideo> {
  List<Map<String, String>> videosList = [
    {'title': 'Dandiya Utsav 2023 At A.N.A Group Of Institutions', 'videoId': 'QF1tGk6-Js4'},
    {'title': 'World Pharmacist Day 2023', 'videoId': '80lFs3P5qrA'},
    {'title': 'Independence Day 2023', 'videoId': 'u8WZQgIU9gA'},
    {'title': 'Lamp Lightening & Oath Taking Ceremony Of B.Sc. Nursing & GNM Students...', 'videoId': 'xGvqOrKYJrc'},
    {'title': 'International Yoga Day At A.N.A Campus', 'videoId': 'Rk7RcOrQ0F0'},
    {'title': 'IFFCO Aonla Visit- A.N.A Group Of Institutions, Bareilly', 'videoId': 'QbpfwWK7xcQ'},
    {'title': 'Campus Placements 2023', 'videoId': 'JzBoN6WOfpY'},
    {'title': 'Holi Carnival 2023 “Holi Ke Rang, A.N.A Ke Saang..”', 'videoId': 'mV_2j3SXBfY'},
    {'title': 'Budget 2023: Live Discussion With Students', 'videoId': 'lEUVcT5ZSZQ'},
    {'title': 'Republic Day & Basant Panchmi Celebration 2023', 'videoId': 'f7E9xFWiuFk'},
    {'title': 'Makar Sankranti Celebrations', 'videoId': 'qYIyl6WHjLQ'},
    {'title': 'Glimpse 2022', 'videoId': 'hz6srZveAlc'},
    // Add more videos as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video List'),
      ),
      body: ListView.builder(
        itemCount: videosList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Icon(Icons.play_circle, color: AppColors.defaultColor,),
            title: Text(videosList[index]['title'] ?? ''),
            onTap: () {
              _playVideo(index);
            },
          );
        },
      ),
    );
  }

  void _playVideo(int index) {
    String videoTitle = videosList[index]['title'] ?? '';
    String youtubeVideoId = videosList[index]['videoId'] ?? '';
    if (youtubeVideoId.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => YouTubeVideoPage(videoTitle: videoTitle, youtubeVideoId: youtubeVideoId),
        ),
      );
    } else {
      // Handle the case where the YouTube video ID is empty or not provided
      print('Error: YouTube video ID is not available.');
    }
  }
}
