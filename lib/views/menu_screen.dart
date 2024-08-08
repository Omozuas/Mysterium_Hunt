import 'package:argame/Ar_Services/arScreen.dart';
import 'package:argame/profile_screen.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/menu.jpg', // Path to your background image
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row with Image and CircleAvatar
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/images/menu.jpg', // Replace with your image path
                          width: 100, // Adjust the width as needed
                          height: 100, // Adjust the height as needed
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfileScreen()));
                          },
                          child: const CircleAvatar(
                            radius: 30, // Adjust the size of the CircleAvatar
                            backgroundImage: AssetImage(
                                'assets/images/penguin player.jpg'), // Replace with your image path
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Centered LevelCards
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 150, // Adjust the width
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TreasureHuntScreen()));
                          },
                          child: LevelCard(
                            imagePath: 'assets/images/level 4.jpg',
                            title: 'Level 1',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(
                        width: 150, // Adjust the width
                        child: LevelCard(
                          imagePath: 'assets/images/level 1.jpg',
                          title: 'Level 2',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(
                        width: 150, // Adjust the width
                        child: LevelCard(
                          imagePath: 'assets/images/level 5.jpg',
                          title: 'Level 3',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LevelCard extends StatelessWidget {
  final String imagePath;
  final String title;

  const LevelCard({
    Key? key,
    required this.imagePath,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(4.0)),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              height: 150, // Adjust the height
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16, // Adjust the font size
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
