import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cutis_biotech/pages/calender/selectdoctor.dart';
import '../leave_form.dart';

class CreateTourPlanPage extends StatefulWidget {
  @override
  _CreateTourPlanPageState createState() => _CreateTourPlanPageState();
}

class _CreateTourPlanPageState extends State<CreateTourPlanPage> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (selectedDay.isBefore(DateTime.now().subtract(Duration(days: 1)))) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("You cannot select a past date.")),
      );
    } else {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      _showSelectionDialog(selectedDay);
    }
  }

  void _showSelectionDialog(DateTime date) {
    String selectedOption = ""; // to track selected radio value

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor:  Colors.white,
          title: Column(
            children: [
              Text(
                // "Add Entry for ${date.toLocal().toString().split(' ')[0]}",
                "Select Action",

                style:
                    TextStyle(fontWeight: FontWeight.bold, color:  Color.fromRGBO(81, 120, 237, 1)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                "Your work city for the day is Devanagere",
                style: TextStyle(fontSize: 14, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: Text("Add new visits to doctor"),
                value: "doctor",
                groupValue: selectedOption,
                onChanged: (value) => setState(() => selectedOption = value!),
              ),
              RadioListTile<String>(
                title: Text("Add new visits to firm"),
                value: "firm",
                groupValue: selectedOption,
                onChanged: (value) => setState(() => selectedOption = value!),
              ),
              RadioListTile<String>(
                title: Text("Add Tour Plan Deviation"),
                value: "deviation",
                groupValue: selectedOption,
                onChanged: (value) => setState(() => selectedOption = value!),
              ),
              RadioListTile<String>(
                title: Text("Add Leave"),
                value: "leave",
                groupValue: selectedOption,
                onChanged: (value) => setState(() => selectedOption = value!),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor:  Color.fromRGBO(81, 120, 237, 1)),
              onPressed: () {
                Navigator.pop(context);
                if (selectedOption == "doctor") {
                  _showCitySelectionDialog1();
                } else if (selectedOption == "firm") {
                  // _showCitySelectionDialog();
                } else if (selectedOption == "deviation") {
                  _showZoneSelectionDialog();
                } else if (selectedOption == "leave") {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LeaveFormPage()));
                }
              },
              child: Text("OK", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  void _showZoneSelectionDialog() {
    // List of available zones (you called them "cities" — renamed for clarity)
    List<String> zones = ["Karnataka"];
    List<String> selectedZones = [];

    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: Text("Select Zone to Add Visit"),
            content: SizedBox(
              height: 250,
              width: double.maxFinite,
              child: ListView.builder(
                itemCount: zones.length,
                itemBuilder: (context, index) {
                  String zone = zones[index];
                  bool isSelected = selectedZones.contains(zone);
                  return CheckboxListTile(
                    title: Text(zone),
                    value: isSelected,
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          selectedZones.add(zone);
                        } else {
                          selectedZones.remove(zone);
                        }
                      });
                    },
                    activeColor:  Color.fromRGBO(81, 120, 237, 1),
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("CANCEL"),
              ),
              TextButton(
                onPressed: () {
                  if (selectedZones.isNotEmpty) {
                    Navigator.pop(context);
                    // Small delay to ensure dialog is fully closed before opening the next
                    Future.delayed(Duration(milliseconds: 200), () {
                      _showCitySelectionDialog(selectedZones);
                    });
                  } else {
                    // Show message if no zone is selected
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text("Please select at least one zone.")),
                    );
                  }
                },
                child: Text("OK"),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCitySelectionDialog(List<String> selectedZones) {
    // Local state for selected cities
    List<String> cities = ["Mumbai", "Delhi", "Bangalore", "Chennai"];
    List<String> selectedCities = [];

    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: Text("Select Cities"),
            content: Container(
              height: 250,
              width: double.maxFinite,
              child: ListView.builder(
                itemCount: cities.length,
                itemBuilder: (context, index) {
                  String city = cities[index];
                  bool isSelected = selectedCities.contains(city);
                  return CheckboxListTile(
                    title: Text(city),
                    value: isSelected,
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          selectedCities.add(city);
                        } else {
                          selectedCities.remove(city);
                        }
                      });
                    },
                    activeColor:  Color.fromRGBO(81, 120, 237, 1),
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("CANCEL"),
              ),
              TextButton(
                // onPressed: () {
                //   // Do something with selectedCities
                //   print("Selected cities: $selectedCities");
                //   Navigator.pop(context);
                // },
                onPressed: () {
                  if (selectedCities.isNotEmpty) {
                    Navigator.pop(context);
                    Future.delayed(Duration(milliseconds: 200), () {
                      _showReasonDialog(selectedCities);
                    });
                  } else {
                    // Optional: alert user to select at least one city
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text("Please select at least one city.")),
                    );
                  }
                },
                child: Text("OK"),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCitySelectionDialog1() {
    // Local state for selected cities
    List<String> cities = ["Mumbai", "Delhi", "Bangalore", "Chennai"];
    List<String> selectedCities = [];

    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: Text("Select Cities"),
            content: Container(
              height: 250,
              width: double.maxFinite,
              child: ListView.builder(
                itemCount: cities.length,
                itemBuilder: (context, index) {
                  String city = cities[index];
                  bool isSelected = selectedCities.contains(city);
                  return CheckboxListTile(
                    title: Text(city),
                    value: isSelected,
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          selectedCities.add(city);
                        } else {
                          selectedCities.remove(city);
                        }
                      });
                    },
                    activeColor:  Color.fromRGBO(81, 120, 237, 1),
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("CANCEL"),
              ),
              TextButton(
                // onPressed: () {
                //   // Do something with selectedCities
                //   print("Selected cities: $selectedCities");
                //   Navigator.pop(context);
                // },
                onPressed: () {
                  if (selectedCities.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectDoctorPage(),
                      ),
                    );
                    // Navigator.pop(context);
                    // Future.delayed(Duration(milliseconds: 200), () {
                    //   _showReasonDialog(selectedCities);
                    // });
                  } else {
                    // Optional: alert user to select at least one city
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text("Please select at least one city.")),
                    );
                  }
                },
                child: Text("OK"),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showReasonDialog(List<String> selectedCities) {
    TextEditingController _reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Enter Reason"),
        content: TextField(
          controller: _reasonController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: "Enter your reason here",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("CANCEL"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor:  Color.fromRGBO(81, 120, 237, 1)),
            onPressed: () {
              String reason = _reasonController.text.trim();
              if (reason.isNotEmpty) {
                Navigator.pop(context);
                print("Selected cities: $selectedCities");
                print("Reason: $reason");

                // Do whatever you need with the data
              }
            },
            child: Text("OK", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void showIncompleteTourPlanDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor:  Color.fromRGBO(81, 120, 237, 1),
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
              Navigator.pop(context);
              // Show snackbar
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(
              //     content: Text("Redirecting to Tour Plan Calendar..."),
              //     backgroundColor:  Color.fromRGBO(81, 120, 237, 1),
              //   ),
              // );

              // Navigate back after short delay
            },
            child: Text("YES",
                style: TextStyle(
                    color:  Color.fromRGBO(81, 120, 237, 1), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _showOtherDialog() {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Add Description"),
        content: TextField(
          controller: controller,
          maxLines: 3,
          decoration: InputDecoration(hintText: "Enter details..."),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text("CANCEL")),
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text("SAVE")),
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
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Tour Plan Calendar',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              focusedDay: _focusedDay,
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: _onDaySelected,
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
                titleCentered: true,
                formatButtonVisible: false,
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
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  showIncompleteTourPlanDialog(
                      context); //delete this when you add backend
                  // if (!is25DaysPlanned) {
                  //   showIncompleteTourPlanDialog(context);
                  // } else {
                  //   // Proceed with actual submission logic
                  // }
                },
                style: ElevatedButton.styleFrom(backgroundColor:  Color.fromRGBO(81, 120, 237, 1)),
                child: Text("SUBMIT ", style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "SAVE AS DRAFT",
                  style: TextStyle(color:  Color.fromRGBO(81, 120, 237, 1)),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
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

Widget _dialogButton(String text, IconData icon, VoidCallback onPressed) {
  return ElevatedButton.icon(
    icon: Icon(icon, color: Colors.white),
    label: Text(
      text,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor:  Color.fromRGBO(81, 120, 237, 1),
      minimumSize: Size(double.infinity, 45),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    onPressed: onPressed,
  );
}
