import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'CreateTourPlanPage.dart';

class TourPlanCalendarPage extends StatefulWidget {
  @override
  _TourPlanCalendarPageState createState() => _TourPlanCalendarPageState();
}

class _TourPlanCalendarPageState extends State<TourPlanCalendarPage> {
  bool isTourPlanSubmitted = false; // Simulate data
  bool isTourPlanApproved = false; // Simulate data
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) => _showInitialDialog());
  }

  void _showInitialDialog() {
    if (!isTourPlanSubmitted) {
      _showDialog(
        title: "You have not submitted your tour plan within defined time.",
        message:
            "Tour plan for April 2025 month is not submitted yet. Press OK to create, modify and submit tour plan for April 2025.",
        onOk: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CreateTourPlanPage()),
          );
        },
      );
    }
  }

  void _showPlanStatusForDate(DateTime date) {
    // Simulated logic — you can replace this with actual plan fetching
    bool isPlanned = false; // Change this condition based on your data
    bool isApproved = false; // Change this too accordingly

    if (!isPlanned) {
      _showDialog(
        title: "No Tour Plan",
        message:
            "You have no tour planned for ${date.day}-${date.month}-${date.year}.",
      );
    } else if (!isApproved) {
      _showDialog(
        title: "Tour Plan not approved",
        message: "Kindly contact your senior.",
      );
    } else {
      _showDialog(
        title: "Tour Plan Details",
        message:
            "You have a tour planned on ${date.day}-${date.month}-${date.year}.",
      );
    }
  }

  void _showDialog(
      {required String title, required String message, VoidCallback? onOk}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor:  Colors.white,
        title: Text(title, style: TextStyle(color:  Color.fromRGBO(81, 120, 237, 1))),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancel", style: TextStyle(color:  Color.fromRGBO(81, 120, 237, 1))),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (onOk != null) onOk();
            },
            child: Text("OK", style: TextStyle(color:  Color.fromRGBO(81, 120, 237, 1))),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Tour Plan Calendar',
          style: TextStyle(color: Colors.white, fontSize: 19),
        ),
        
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              focusedDay: DateTime.now(),
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                });

                _showPlanStatusForDate(selectedDay); // Trigger dialog
              },
              calendarStyle: CalendarStyle(
                todayDecoration:
                    BoxDecoration(color:  Color.fromRGBO(81, 120, 237, 1), shape: BoxShape.circle),
                selectedDecoration: BoxDecoration(
                  color:  Color.fromRGBO(81, 120, 237, 1),
                  shape: BoxShape.circle,
                ),
                markerDecoration:
                    BoxDecoration(color:  Color.fromRGBO(81, 120, 237, 1), shape: BoxShape.circle),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LegendRow("TourPlan",  Color.fromRGBO(81, 120, 237, 1)),
                  LegendRow("Pending Leave", Colors.yellow),
                  LegendRow("Cancelled/Rejected Leave", Colors.red),
                  LegendRow("Approved Leave", Colors.purple),
                  LegendRow("Holiday", Colors.blue),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:  Color.fromRGBO(81, 120, 237, 1),
            minimumSize: Size.fromHeight(50),
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CreateTourPlanPage()),
          ),
          child: Text(
            "CREATE TOUR PLAN",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  void showIncompleteTourPlanDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor:  Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color:  Color.fromRGBO(81, 120, 237, 1)),
          borderRadius: BorderRadius.circular(12),
        ),
        title: Text(
          "Submit tour plan",
          style: TextStyle(
            color:  Color.fromRGBO(81, 120, 237, 1),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        content: Text(
          "You have not added tour plan for 25 working days. Please add tour plan or apply for leave for those days. Submitting now will lock the tour plan and no further changes can be made. Press YES to proceed.",
          style: TextStyle(color: Colors.black87),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("NO", style: TextStyle(color:  Color.fromRGBO(81, 120, 237, 1))),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);

              // Show snackbar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Redirecting to Tour Plan Calendar..."),
                  backgroundColor:  Colors.white,
                ),
              );

              // Navigate back after short delay
              Future.delayed(Duration(seconds: 1), () {
                Navigator.pop(context); // Pop current page
              });
            },
            child: Text("YES",
                style: TextStyle(
                    color:  Color.fromRGBO(81, 120, 237, 1), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget LegendRow(String label, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: color, radius: 5),
          SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}
