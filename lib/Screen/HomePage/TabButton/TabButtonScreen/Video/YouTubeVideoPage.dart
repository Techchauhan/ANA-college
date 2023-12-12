import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubeVideoPage extends StatelessWidget {
  final String videoTitle;
  final String youtubeVideoId;

  YouTubeVideoPage({required this.videoTitle, required this.youtubeVideoId});

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: youtubeVideoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(videoTitle),
      ),
      body: Center(
        child: YoutubePlayer(
          controller: _controller,
          liveUIColor: Colors.amber,
        ),
      ),
    );
  }
}
