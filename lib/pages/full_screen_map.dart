import 'package:flutter/material.dart';

class FullScreenMapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Temporary Static Map Image
          Center(
            child: Image.asset(
              "assets/images/world_map.png",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          // Close Button (Top Right)
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pop(context); // Close the map screen
              },
            ),
          ),
        ],
      ),
    );
  }
}
