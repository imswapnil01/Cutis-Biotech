import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cutis_biotech/widgets/header.dart';
import 'package:cutis_biotech/widgets/bottom_navbar.dart';
import 'package:cutis_biotech/widgets/side_menu.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late String _formattedDateTime;

  final List<String> images = [
    "assets/Images/medicine_image.jpg",
    "assets/Images/banner.jpg",
    "assets/Images/banner.jpg",
  ];

  final List<DashboardItem> dashboardItems = [
    // Original Items (keep icons and colors unchanged)
    DashboardItem("Visits", Icons.explore, Colors.orange),
    DashboardItem("Doctors", Icons.person, Colors.blue),
    DashboardItem("Firms", Icons.business,  Color.fromRGBO(81, 120, 237, 1)),
    DashboardItem("Calendar", Icons.calendar_month, Colors.red),
    DashboardItem("Order Details", Icons.receipt_long, Colors.purple),

    // Additional Items with outlined icons and light colors
    DashboardItem(
        "Monthly Summary", Icons.stacked_bar_chart, Colors.amber),
    DashboardItem("Files", Icons.insert_drive_file, Colors.indigo),
    DashboardItem("Expenses", Icons.wallet, Colors.teal),
    DashboardItem("Leaves", Icons.beach_access, Colors.deepOrange),
    DashboardItem("Holidays", Icons.holiday_village, Colors.cyan),
    DashboardItem("Presentation", Icons.slideshow, Colors.pink),
    DashboardItem("Business", Icons.cases_outlined, Colors.deepPurple),
    DashboardItem("Reports", Icons.insert_chart, Colors.lightGreen),
    DashboardItem("Celebrations", Icons.celebration, Colors.lime),
  ];

  @override
  void initState() {
    super.initState();
    _updateDateTime();
    _startAutoSlide();
  }

  void _updateDateTime() {
    _formattedDateTime = DateFormat("dd-MM-yyyy").format(DateTime.now());
  }

  void _startAutoSlide() {
    Future.delayed(const Duration(seconds: 3), () {
      if (_pageController.hasClients) {
        setState(() {
          _currentPage = (_currentPage + 1) % images.length;
          _pageController.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 500),
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
      backgroundColor: const Color(0xFFF5F5F5),
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Header(title: "Cutis Biotech", scaffoldKey: _scaffoldKey),
      ),
      drawer: SideMenu(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              // Start Work + Date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(
                          0xFF5A7DEB), // or: Color.fromRGBO(90, 125, 235, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("MARK ATTENDANCE",
                        style: TextStyle(color: Colors.white)),
                  ),
                  Text(
                    _formattedDateTime,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Slider
              Container(
                // margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 140,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: images.length,
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              images[index],
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(images.length, (index) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _currentPage == index ? 12 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentPage == index
                                ? Colors.deepPurple
                                : Colors.grey,
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Section Title
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Popular Queries",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Dashboard Cards
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1,
                children: dashboardItems.map((item) {
                  return GestureDetector(
                    onTap: () {
                      if (item.title == "Visits") {
                        Navigator.pushNamed(context, '/visits');
                      } else if (item.title == "Doctors") {
                        Navigator.pushNamed(context, '/doctors');
                      } else if (item.title == "Firms") {
                        Navigator.pushNamed(context, '/firms');
                      } else if (item.title == "Calendar") {
                        Navigator.pushNamed(context, '/tourplancalendar');
                      } else if (item.title == "Order Details") {
                        Navigator.pushNamed(context, '/salesreport');
                      } else if (item.title == "Monthly Summary") {
                        Navigator.pushNamed(context, '/monthlysummary');
                      } else if (item.title == "Files") {
                        Navigator.pushNamed(context, '/files');
                      } else if (item.title == "Expenses") {
                        Navigator.pushNamed(context, '/expenses');
                      } else if (item.title == "Leaves") {
                        Navigator.pushNamed(context, '/leaves');
                      } else if (item.title == "Holidays") {
                        Navigator.pushNamed(context, '/holidays');
                      } else if (item.title == "Celebrations") {
                        Navigator.pushNamed(context, '/celebrations');
                      } else if (item.title == "Presentation") {
                        Navigator.pushNamed(context, '/presentation');
                      } else if (item.title == "Reports") {
                        Navigator.pushNamed(context, '/reports');
                      } else if (item.title == "Business") {
                        Navigator.pushNamed(context, '/business');
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(item.icon, color: item.color, size: 28),
                          const SizedBox(height: 10),
                          Text(
                            item.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
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
}

class DashboardItem {
  final String title;
  final IconData icon;
  final Color color;

  DashboardItem(this.title, this.icon, this.color);
}
