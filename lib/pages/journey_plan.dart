import 'package:flutter/material.dart';
import 'package:cutis_biotech/widgets/bottom_navbar.dart';
import '../book_order_page.dart';
import 'MedicineOrder.dart';
import 'journey_plan_form.dart';

class JourneyPlanPage extends StatefulWidget {
  const JourneyPlanPage({super.key});

  @override
  _JourneyPlanPageState createState() => _JourneyPlanPageState();
}

class _JourneyPlanPageState extends State<JourneyPlanPage> {
  int _selectedTabIndex = 0;

  // Sample journey plan data
  List<Map<String, dynamic>> journeyPlans = [
    {
      "doctor": "Dr. Pankaj Lande",
      "workingWith": "NA",
      "date": "20-03-25",
      "scheduledBy": "Admin",
      "status": "Active"
    },
    {
      "doctor": "Dr. Ramesh Patil",
      "workingWith": "NA",
      "date": "20-04-10",
      "scheduledBy": "Manager",
      "status": "Completed"
    },
    {
      "doctor": "Dr. Sneha Verma",
      "workingWith": "NA",
      "date": "20-05-01",
      "scheduledBy": "Admin",
      "status": "Deleted"
    },
  ];

  List<Map<String, dynamic>> getFilteredPlans() {
    String filter = _selectedTabIndex == 0
        ? "Active"
        : _selectedTabIndex == 1
            ? "Completed"
            : "Deleted";
    return journeyPlans.where((plan) => plan["status"] == filter).toList();
  }

  void _deletePlan(int index) {
    setState(() {
      journeyPlans[index]["status"] = "Deleted";
    });
  }

  void _editPlan(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => JourneyPlanForm()),
    );
  }

  // void _bookOrder(int index) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => BookOrderPage(doctorName: journeyPlans[index]["doctor"])),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "View Details",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(88, 125, 237, 1), // Start color
                Color.fromRGBO(81, 120, 237, 1), // Middle
                Color.fromRGBO(114, 142, 242, 1), // End color
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ),

      body: Column(
        children: [
          // Tab Buttons
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            color: const Color.fromARGB(255, 175, 191, 204),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTabButton("Active", 0),
                _buildTabButton("Completed", 1),
                _buildTabButton("Deleted", 2),
              ],
            ),
          ),

          // Journey Plan Cards
          Expanded(
            child: getFilteredPlans().isNotEmpty
                ? ListView.builder(
                    itemCount: getFilteredPlans().length,
                    itemBuilder: (context, index) {
                      var plan = getFilteredPlans()[index];
                      return Card(
                        elevation: 2,
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(plan["doctor"],
                                  style: TextStyle(fontSize: 16)),
                              SizedBox(height: 3),
                              Text("Working with: ${plan["workingWith"]}",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black54)),
                              SizedBox(height: 3),
                              Text(
                                  "Date: ${plan["date"]} / Scheduled by: ${plan["scheduledBy"]}",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black54)),
                              SizedBox(height: 10),

                              // Show buttons only if status is "Active"
                              if (plan["status"] == "Active")
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Edit Button
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        side: BorderSide(color: Colors.red),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      onPressed: () => _editPlan(index),
                                      child: Text("Edit",
                                          style: TextStyle(color: Colors.red)),
                                    ),

                                    // Delete Button
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      onPressed: () => _deletePlan(index),
                                      child: Text("Delete",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),

                                    // Book Order Button
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color.fromRGBO(81, 120, 237, 1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MedicineOrderPage(),
                                          ),
                                        );
                                      },
                                      child: Text("Book Order",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      "No Data Available",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
          ),
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 1,
        onItemTapped: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/dashboard');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/bookOrder');
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, '/leave');
          }
        },
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => JourneyPlanForm()),
          );
        },
        backgroundColor: Color.fromRGBO(81, 120, 237, 1),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  // Tab Button Widget
  Widget _buildTabButton(String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        decoration: BoxDecoration(
          color: _selectedTabIndex == index ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
