import 'package:flutter/material.dart';

import '../login_page.dart';
import 'EditProfilePage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // Log out function
  void _logoutUser(BuildContext context) {

    // TODO: Clear stored session data (like shared preferences or auth tokens)

    // Navigate to Login Page & remove all previous pages from the navigation stack
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()), // Replace with your login page
          (route) => false, // Removes all previous routes
    );
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  title: const Text(
    "Profile",
    style: TextStyle(color: Colors.white),
  ),
  leading: IconButton(
    icon: const Icon(Icons.arrow_back, color: Colors.white),
    onPressed: () {
      Navigator.pop(context);
    },
  ),
  flexibleSpace: Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color.fromRGBO(88, 125, 237, 1),  // rgba(88, 125, 237, 1)
          Color.fromRGBO(81, 120, 237, 1),  // rgba(81, 120, 237, 1)
          Color.fromRGBO(114, 142, 242, 1), // rgba(114, 142, 242, 1)
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    ),
  ),
),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              // **Profile Picture**
              Center(
                child: Stack(
                  children: [
                    const CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage("assets/images/profile_placeholder.png"),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor:  Color.fromRGBO(81, 120, 237, 1),
                        radius: 18,
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt, color: Colors.white, size: 18),
                          onPressed: () {
                            // TODO: Implement image picker
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // **User Details**
              const Text("swapnil", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              const Text("swapnil@example.com", style: TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(height: 20),

              // **User Info Cards**
              _buildProfileCard(Icons.phone, "+91 976xxxxxx99"),
              const SizedBox(height: 10),
              _buildProfileCard(Icons.location_on, "Maharshtra, India"),
              const SizedBox(height: 20),

              // **Buttons**
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor:  Color.fromRGBO(81, 120, 237, 1), padding: const EdgeInsets.all(14)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditProfilePage()));

                  },
                  child: const Text("Edit Profile", style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red, padding: const EdgeInsets.all(14)),
                  onPressed: () {
                    // TODO: Implement logout
                    _logoutUser(context);
                  },
                  child: const Text("Logout", style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // **Reusable Profile Info Card**
  Widget _buildProfileCard(IconData icon, String info) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color:  Color.fromRGBO(81, 120, 237, 1), size: 28),
        title: Text(info, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
