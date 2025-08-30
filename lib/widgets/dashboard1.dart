import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cutis_biotech/widgets/header.dart';
import 'package:cutis_biotech/widgets/bottom_navbar.dart';
import 'package:cutis_biotech/widgets/side_menu.dart';

class Dashboard1 extends StatefulWidget {
  const Dashboard1({super.key});

  @override
  _Dashboard1State createState() => _Dashboard1State();
}

class _Dashboard1State extends State<Dashboard1> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late String _formattedDateTime;
  final Color primaryGreen = Color(0xFF7923CF); // elegant deep green
  int selectedCardIndex = -1;

  final List<String> images = [
    "assets/Images/banner.jpg",
    "assets/Images/banner.jpg",
    "assets/Images/banner.jpg",
  ];

  final List<DashboardItem> dashboardItems = [
    DashboardItem("Visits", Icons.explore_outlined, Color(0xFFEBD9FB)),
    DashboardItem("Doctors", Icons.person_outline, Color(0xFFD9E4FB)),
    DashboardItem("Firms", Icons.business_outlined, Color(0xFFDFF7EC)),
    DashboardItem("Calendar", Icons.calendar_month_outlined, Color(0xFFE0F7FA)),
    DashboardItem(
        "Order Details", Icons.receipt_long_outlined, Color(0xFFFFF3E0)),
    DashboardItem(
        "Monthly Summary", Icons.stacked_bar_chart_outlined, Color(0xFFF9FBE7)),
    DashboardItem("Files", Icons.insert_drive_file_outlined, Color(0xFFF3E5F5)),
    DashboardItem("Expenses", Icons.wallet_outlined, Color(0xFFE1F5FE)),
    DashboardItem("Leaves", Icons.beach_access_outlined, Color(0xFFFFE0E0)),
    DashboardItem(
        "Holidays", Icons.holiday_village_outlined, Color(0xFFD0F0E0)),
    DashboardItem("Presentation", Icons.slideshow_outlined, Color(0xFFFFE4EC)),
    DashboardItem("Business", Icons.cases_outlined, Color(0xFFE3F2FD)),
    DashboardItem("Reports", Icons.insert_chart_outlined, Color(0xFFE8F5E9)),
    DashboardItem(
        "Celebrations", Icons.celebration_outlined, Color(0xFFFFFDE7)),
  ];

  @override
  void initState() {
    super.initState();
    _updateDateTime();
    _startAutoSlide();
  }

  void _updateDateTime() {
    setState(() {
      _formattedDateTime =
          DateFormat("dd-MM-yyyy | HH:mm").format(DateTime.now());
    });
  }

  void _startAutoSlide() {
    Future.delayed(Duration(seconds: 3), () {
      if (_pageController.hasClients) {
        setState(() {
          _currentPage = (_currentPage + 1) % images.length;
          _pageController.animateToPage(
            _currentPage,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        });
        _startAutoSlide();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Header(title: "Cutis Biotech", scaffoldKey: _scaffoldKey),
      ),
      drawer: SideMenu(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height: 200,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: images.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Image.asset(
                        images[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      );
                    },
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  images.length, (index) => buildIndicator(index)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                _formattedDateTime,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 130, 43, 180),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF7923CF),
                    Color(0xFFAB57FF),
                    Color(0xFFB877ED),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // Punch attendance logic
                },
                child: const Text(
                  "MARK ATTENDANCE",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),

            // 🚀 New Grid Cards Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 0.9,
                children: List.generate(dashboardItems.length, (index) {
                  final item = dashboardItems[index];
                  final bool isSelected = selectedCardIndex == index;

                  return AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: isSelected ? primaryGreen : item.color,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: Color(0xFF7923CF),
                        width: 1.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(18),
                      onTap: () {
                        setState(() {
                          selectedCardIndex = index;
                        });
                        // Optional: Auto-reset after a short delay
                        Future.delayed(Duration(milliseconds: 1000), () {
                          setState(() {
                            selectedCardIndex = -1;
                          });
                        });
                        if (item.title == "Visits") {
                          Navigator.pushNamed(
                              context, '/visits'); // Navigate using route name
                        } else if (item.title == "Doctors") {
                          Navigator.pushNamed(
                              context, '/doctors'); // Navigate using route name
                        } else if (item.title == "Firms") {
                          Navigator.pushNamed(
                              context, '/firms'); // Navigate using route name
                        } else if (item.title == "Calendar") {
                          Navigator.pushNamed(context,
                              '/tourplancalendar'); // Navigate using route name
                        } else if (item.title == "Order Details") {
                          Navigator.pushNamed(context,
                              '/salesreport'); // Navigate using route name
                        } else if (item.title == "Monthly Summary") {
                          Navigator.pushNamed(context,
                              '/monthlysummary'); // Navigate using route name
                        } else if (item.title == "Files") {
                          Navigator.pushNamed(
                              context, '/files'); // Navigate using route name
                        } else if (item.title == "Expenses") {
                          Navigator.pushNamed(context,
                              '/expenses'); // Navigate using route name
                        } else if (item.title == "Leaves") {
                          Navigator.pushNamed(
                              context, '/leaves'); // Navigate using route name
                        } else if (item.title == "Holidays") {
                          Navigator.pushNamed(context,
                              '/holidays'); // Navigate using route name
                        } else if (item.title == "Celebrations") {
                          Navigator.pushNamed(context,
                              '/celebrations'); // Navigate using route name
                        } else if (item.title == "Presentation") {
                          Navigator.pushNamed(context,
                              '/presentation'); // Navigate using route name
                        } else if (item.title == "Reports") {
                          Navigator.pushNamed(
                              context, '/reports'); // Navigate using route name
                        } else if (item.title == "Business") {
                          Navigator.pushNamed(context,
                              '/business'); // Navigate using route name
                        }
                        // Add other navigation logic if needed

                        print("Tapped on ${item.title}");
                        // You can add navigation here if needed
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              item.icon,
                              size: 28,
                              
                              color: isSelected ? Colors.white : primaryGreen,
                                 
                            ),
                            SizedBox(height: 10),
                            Text(
                              item.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: isSelected ? Colors.white : primaryGreen,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 0,
        onItemTapped: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/visit');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/bookOrder');
          } else if (index == 3) {
            Navigator.pushNamed(context, '/leave');
          }
        },
      ),
    );
  }

  Widget buildIndicator(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 4),
      width: _currentPage == index ? 12 : 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index ?  Color.fromRGBO(81, 120, 237, 1) : Colors.grey,
      ),
    );
  }
}

// 📦 Dashboard Item Model
class DashboardItem {
  final String title;
  final IconData icon;
  final Color color;

  DashboardItem(this.title, this.icon, this.color);
}
