import 'package:cutis_biotech/pages/ChangePasswordPage.dart';
import 'package:flutter/material.dart';
import '../login_page.dart';
import '../pages/full_screen_map.dart';
import '../pages/profile_page.dart';
import '../pages/leave_page.dart';
import '../pages/request_document.dart';

class SideMenu extends StatelessWidget {
  void _logoutUser(BuildContext context) {
    // TODO: Clear session data (e.g. SharedPreferences)
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Gradient Profile Section
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(88, 125, 237, 1), // rgba(88, 125, 237, 1)
                  Color.fromRGBO(81, 120, 237, 1), // rgba(81, 120, 237, 1)
                  Color.fromRGBO(114, 142, 242, 1), // rgba(157, 177, 250, 1)
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Container(
  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
  decoration: const BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color.fromRGBO(88, 125, 237, 1),
        Color.fromRGBO(81, 120, 237, 1),
        Color.fromRGBO(114, 142, 242, 1),
      ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
  ),
  child: Row(
    children: [
      const CircleAvatar(
        radius: 28,
        backgroundColor: Colors.white,
        child: Icon(Icons.person, size: 50, color: Color.fromARGB(255, 80, 113, 223)),
      ),
      const SizedBox(width: 16),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Swapnil",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            "+91 97xxxxxx99",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    ],
  ),
),
          ),

          // Menu Items
          _buildDrawerItem(Icons.person, "Profile", () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfilePage()));
          }),
          _buildDrawerItem(Icons.location_on, "Tracking", () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => FullScreenMapPage()));
          }),
          _buildDrawerItem(Icons.lock, "Leave", () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LeavePage()));
          }),
          _buildDrawerItem(Icons.file_copy, "Request for Documents", () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => RequestDocumentPage()));
          }),
          _buildDrawerItem(Icons.password, "Change Password", () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ChangePasswordPage()));
          }),
          _buildDrawerItem(Icons.logout, "Logout", () {
            _logoutUser(context);
          }),
        ],
      ),
    );
  }

 Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
  return ListTile(
    leading: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0xFFE3ECFF), // Light blue background
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Color(0xFF5A7DEB), size: 20),
    ),
    title: Text(title, style: const TextStyle(fontSize: 16)),
    trailing: const Icon(Icons.chevron_right, color: Colors.grey), // Right arrow
    onTap: onTap,
  );
}

}
