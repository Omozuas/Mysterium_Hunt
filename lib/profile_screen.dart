import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = true;

  void playPauseMusic() async {
    print('object');
    if (isPlaying == true) {
      await audioPlayer.pause(); // Pause the music
      print('stop');
    } else {
      await audioPlayer.play(AssetSource('audio/neon-gaming-128925.mp3'));
      await audioPlayer.setReleaseMode(ReleaseMode.loop);
      ; // Resume playing the music
      print('play');
    }
    setState(() {
      isPlaying = !isPlaying; // Toggle the play/pause state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      playPauseMusic();
                    },
                    child: Icon(isPlaying ? Icons.volume_up : Icons.volume_off),
                  ),
                ],
              ),
              CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage('assets/images/iron_man.png'),
              ),
              SizedBox(height: 16),
              Text(
                'Rema',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Level 1',
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
              SizedBox(height: 32),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Achievements',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  children: [
                    _buildAchievementTile(
                        'assets/images/spider_one.png', 'Hunter'),
                    _buildAchievementTile(
                        'assets/images/spider_one.png', 'Explorer'),
                    _buildAchievementTile(
                        'assets/images/spider_one.png', 'Master'),
                    _buildAchievementTile(
                        'assets/images/spider_one.png', 'Collector'),
                    _buildAchievementTile(
                        'assets/images/spider_one.png', 'Warrior'),
                    _buildAchievementTile(
                        'assets/images/spider_one.png', 'Champion'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAchievementTile(String imagePath, String title) {
    return Column(
      children: [
        Image.asset(
          imagePath,
          width: 50,
          height: 50,
        ),
        SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
