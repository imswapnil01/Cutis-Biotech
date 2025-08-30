import 'package:flutter/material.dart';
import '../pages/full_screen_map.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const Header({super.key, required this.title, this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              
               Color.fromRGBO(88, 125, 237, 1),  // rgba(88, 125, 237, 1)
    Color.fromRGBO(81, 120, 237, 1),  // rgba(81, 120, 237, 1)
    Color.fromRGBO(114, 142, 242, 1), // rgba(157, 177, 250, 1)
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      ),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.white),
        onPressed: () {
          if (scaffoldKey != null) {
            scaffoldKey!.currentState?.openDrawer();
          }
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.location_on, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FullScreenMapPage()),
            );
          },
        ),
      ],
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor:  Color.fromRGBO(81, 120, 237, 1),
//       title: Text(title, style: const TextStyle(color: Colors.white)),
//       centerTitle: true,
//       leading: IconButton(
//         icon: const Icon(Icons.menu, color: Colors.white),
//         onPressed: () {
//           if (scaffoldKey != null) {
//             scaffoldKey!.currentState?.openDrawer(); //  Opens drawer when clicked
//           }
//         },
//       ),
//       actions: [
//         IconButton(
//             icon: Icon(Icons.location_on, color: Colors.white),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => FullScreenMapPage()),
//               );
//             }
//         ),
//       ],
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(60);
// }
