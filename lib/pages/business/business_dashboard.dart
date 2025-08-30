import 'package:flutter/material.dart';

class BusinessPage extends StatefulWidget {
  const BusinessPage({super.key});

  @override
  State<BusinessPage> createState() => _BusinessPageState();
}

class _BusinessPageState extends State<BusinessPage> {
  final Color primaryGreen =  Color.fromRGBO(81, 120, 237, 1); // Same elegant green
  int selectedCardIndex = -1;

  final List<BusinessItem> businessItems = [
    BusinessItem("Sales", Icons.trending_up),
    BusinessItem("Doctor Business Planning", Icons.business_center),
    BusinessItem("Sales Planning", Icons.event_note),
    BusinessItem("Sub-ordinates Sales Planning", Icons.group),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          flexibleSpace: Container(
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
          title: const Text('Business', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: 0.9,
          children: List.generate(businessItems.length, (index) {
            final item = businessItems[index];
            final bool isSelected = selectedCardIndex == index;

            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: isSelected ? primaryGreen : Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Color.fromRGBO(81, 120, 237, 1), width: 1.2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () {
                  setState(() {
                    selectedCardIndex = index;
                  });
                  Future.delayed(const Duration(milliseconds: 1000), () {
                    setState(() {
                      selectedCardIndex = -1;
                    });
                  });
                  if (item.title == "Sales") {
                    Navigator.pushNamed(
                        context, '/sales'); // Navigate using route name
                  } else if (item.title == "Doctor Business Planning") {
                    Navigator.pushNamed(context,
                        '/doctorsbusinessplanning'); // Navigate using route name
                  } else if (item.title == "Sales Planning") {
                    Navigator.pushNamed(
                        context, '/salesplanning'); // Navigate using route name
                  } else if (item.title == "Sub-ordinates Sales Planning") {
                    Navigator.pushNamed(context,
                        '/businesssalesplanningpage'); // Navigate using route name
                  }
                  print("Tapped on ${item.title}");
                  //  You can add Navigator.pushNamed(context, '/route') here if needed
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        item.icon,
                        size: 30,
                        color: isSelected ? Colors.white : primaryGreen,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        item.title,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
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
    );
  }
}

// Model class for Business Items
class BusinessItem {
  final String title;
  final IconData icon;

  BusinessItem(this.title, this.icon);
}
