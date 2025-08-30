// import 'package:flutter/material.dart';

// class BottomNavBar extends StatelessWidget {
//   final int selectedIndex;
//   final ValueChanged<int> onItemTapped;

//   const BottomNavBar({
//     super.key,
//     required this.selectedIndex,
//     required this.onItemTapped,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             // Color(0xFF7923CF),
//             // Color(0xFFAB57FF),
//             // Color(0xFFB877ED),
//             Color.fromRGBO(88, 125, 237, 1),  // rgba(88, 125, 237, 1)
//     Color.fromRGBO(81, 120, 237, 1),  // rgba(81, 120, 237, 1)
//     Color.fromRGBO(114, 142, 242, 1), // rgba(157, 177, 250, 1)
//           ],
//           begin: Alignment.centerLeft,
//           end: Alignment.centerRight,
//         ),
//       ),
//       child: BottomNavigationBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.white70,
//         currentIndex: selectedIndex,
//         onTap: onItemTapped,
//         type: BottomNavigationBarType.fixed,
//         items: const [
//           BottomNavigationBarItem(
//               icon: Icon(Icons.home_outlined), label: "Home"),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.explore_outlined), label: "Visit"),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.receipt_long), label: "Book Order"),
//           BottomNavigationBarItem(icon: Icon(Icons.lock), label: "Leave"),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class BottomNavBar extends StatelessWidget {
//   final int selectedIndex;
//   final ValueChanged<int> onItemTapped;

//   const BottomNavBar({
//     super.key,
//     required this.selectedIndex,
//     required this.onItemTapped,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final List<IconData> icons = [
//       Icons.home,
//       Icons.explore,
//       Icons.receipt_long,
//       Icons.lock,
//     ];

//     final List<String> labels = [
//       "Home",
//       "Visit",
//       "Book Order",
//       "Leave",
//     ];

//     return Container(
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         // boxShadow: [
//         //   BoxShadow(
//         //     color: Colors.black12,
//         //     blurRadius: 8,
//         //     offset: Offset(0, -2),
//         //   ),
//         // ],
//       ),
//       child: BottomNavigationBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         currentIndex: selectedIndex,
//         onTap: onItemTapped,
//         type: BottomNavigationBarType.fixed,
//         selectedFontSize: 12,
//         unselectedFontSize: 12,
//         selectedItemColor: Colors.blue,
//         unselectedItemColor: Colors.blueGrey,
//         showUnselectedLabels: true,
//         items: List.generate(icons.length, (index) {
//           final isSelected = index == selectedIndex;

//           return BottomNavigationBarItem(
//             label: labels[index],
//             icon: isSelected
//                 ? Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: Colors.blue,
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(color: Colors.blue, width: 1.5),
//                       boxShadow: const [
//                         BoxShadow(
//                           color: Colors.blueAccent,
//                           blurRadius: 6,
//                           offset: Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: Icon(
//                       icons[index],
//                       color: Colors.white,
//                       size: 24,
//                     ),
//                   )
//                 : Icon(
//                     icons[index],
//                     size: 24,
//                     color: Colors.blueGrey,
//                   ),
//           );
//         }),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    final List<IconData> icons = [
      Icons.home,
      Icons.explore,
      Icons.receipt,
      Icons.person,
    ];

    final List<String> labels = [
      'Home',
      'Visits',
      'Orders',
      'Profile',
    ];

    final double screenWidth = MediaQuery.of(context).size.width;
    final double itemWidth = screenWidth / icons.length;

    return SizedBox(
      height: 80,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background Bar with Wave
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomPaint(
              painter: WavePainter(
                xOffset: itemWidth * selectedIndex + itemWidth / 2,
                width: screenWidth,
              ),
              child: Container(
                height: 60,
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
              ),
            ),
          ),

          // Non-selected Icons with Labels
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(icons.length, (index) {
                  if (index == selectedIndex) {
                    return const SizedBox(width: 60); // gap for floating icon
                  }
                  return GestureDetector(
                    onTap: () => onItemTapped(index),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          icons[index],
                          color: Colors.white,
                          size: 24,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          labels[index],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),

          // Floating Selected Icon with Label
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            bottom: 6, // Adjusted slightly up for better alignment
            left: screenWidth / 4 * selectedIndex +
                screenWidth / 8 -
                20, // was -24, now -20 due to size drop
            child: GestureDetector(
              onTap: () => onItemTapped(selectedIndex),
              child: Column(
                children: [
                  Container(
                    height: 40, // ⬅️ reduced from 48
                    width: 40, // ⬅️ reduced from 48
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        icons[selectedIndex],
                        size: 22, // Optional: Slightly smaller to fit better
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    labels[selectedIndex],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
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

class WavePainter extends CustomPainter {
  final double xOffset;
  final double width;

  WavePainter({required this.xOffset, required this.width});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();

    // Wave parameters
    final waveWidth = 60.0;
    final waveHeight = 20.0;
    final controlPointX = xOffset;
    final startWave = xOffset - waveWidth / 2;
    final endWave = xOffset + waveWidth / 2;

    path.moveTo(0, 0);

    if (startWave > 0) {
      path.lineTo(startWave, 0);
    }

    path.cubicTo(
      controlPointX - 20,
      -waveHeight,
      controlPointX + 20,
      -waveHeight,
      endWave,
      0,
    );

    path.lineTo(width, 0);
    path.lineTo(width, size.height);
    path.lineTo(0, size.height);
    path.close();

    // 🎨 Create gradient shader for the wave
    final gradient = LinearGradient(
      colors: const [
        Color.fromRGBO(88, 125, 237, 1),
        Color.fromRGBO(81, 120, 237, 1),
        Color.fromRGBO(114, 142, 242, 1),
      ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).createShader(Rect.fromLTWH(0, 0, width, size.height));

    final paint = Paint()
      ..shader = gradient
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
