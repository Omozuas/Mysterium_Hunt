import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/iron_man.png'),
            ),
            SizedBox(height: 16),
            Text(
              'Rema',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Level 10',
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
