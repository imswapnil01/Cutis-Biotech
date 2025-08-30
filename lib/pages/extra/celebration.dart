import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CelebrationPage extends StatefulWidget {
  @override
  _CelebrationPageState createState() => _CelebrationPageState();
}

class _CelebrationPageState extends State<CelebrationPage> with TickerProviderStateMixin {
  DateTime? fromDate;
  DateTime? toDate;
  late TabController _tabController;

  final List<Map<String, String>> birthdays = [
    {"name": "Dr. Suresh", "location": "Pune", "date": "25 Apr", "phone": "1234567890"},
    {"name": "Dr. Meera", "location": "Mumbai", "date": "27 Apr", "phone": "9876543210"},
  ];

  final List<Map<String, String>> anniversaries = [
    {"name": "Dr. Ravi", "location": "Nagpur", "date": "28 Apr", "phone": "9988776655"},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    DateTime initialDate = DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        if (isFromDate) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });
    }
  }

  Widget _dateFilterRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () => _selectDate(context, true),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                decoration: BoxDecoration(
                  border: Border.all(color:  Color.fromRGBO(81, 120, 237, 1)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  fromDate != null
                      ? "From: ${DateFormat('dd MMM').format(fromDate!)}"
                      : "From Date",
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: InkWell(
              onTap: () => _selectDate(context, false),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                decoration: BoxDecoration(
                  border: Border.all(color:  Color.fromRGBO(81, 120, 237, 1)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  toDate != null
                      ? "To: ${DateFormat('dd MMM').format(toDate!)}"
                      : "To Date",
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _doctorCard(Map<String, String> doctor) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor:  Color.fromRGBO(81, 120, 237, 1),
              child: Icon(Icons.person, color:  Colors.white),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor["name"]!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "${doctor["location"]!} | ${doctor["date"]!}",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.call, color:  Color.fromRGBO(81, 120, 237, 1)),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Calling ${doctor["phone"]}'),
                ));
              },
            )
          ],
        ),
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
  title: Text("Celebration", style: TextStyle(color: Colors.white)),
  leading: IconButton(
    icon: Icon(Icons.arrow_back, color: Colors.white),
    onPressed: () => Navigator.pop(context),
  ),
),

      body: Column(
        children: [
          // Tab Bar just below the AppBar
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              indicatorColor:  Color.fromRGBO(81, 120, 237, 1),
              indicatorWeight: 3,
              labelColor:  Color.fromRGBO(81, 120, 237, 1),
              unselectedLabelColor: Colors.grey,
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
              tabs: [
                Tab(text: "🎂 BIRTHDAYS"),
                Tab(text: "💍 ANNIVERSARIES"),
              ],
            ),
          ),
          _dateFilterRow(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.builder(
                    itemCount: birthdays.length,
                    itemBuilder: (context, index) => _doctorCard(birthdays[index]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.builder(
                    itemCount: anniversaries.length,
                    itemBuilder: (context, index) => _doctorCard(anniversaries[index]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
