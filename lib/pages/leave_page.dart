import 'package:flutter/material.dart';
import 'leave_form.dart';
import 'package:cutis_biotech/widgets/bottom_navbar.dart'; // ✅ Import Bottom Navbar

class LeavePage extends StatefulWidget {
  LeavePage({Key? key}) : super(key: key);

  @override
  _LeavePageState createState() => _LeavePageState();
}

class _LeavePageState extends State<LeavePage> {
  List<Map<String, dynamic>> leaves = [
    {
      'type': 'sick',
      'fromDate': '2022-12-12',
      'toDate': '2022-12-14',
      'reason': 'Dear Sir I am suffering with high fever',
      'status': 'active',
    },
    {
      'type': 'earned',
      'fromDate': '2023-05-24',
      'toDate': '2023-05-27',
      'reason': 'Suffering from fever',
      'status': 'active',
    }
  ]; //Added dummy entries

  void _navigateToLeaveForm() async {
    final newLeave = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LeaveFormPage()),
    );

    if (newLeave != null) {
      setState(() {
        leaves.insert(0, newLeave); // ✅ Add new leave on top dynamically
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  automaticallyImplyLeading: true,
  iconTheme: const IconThemeData(color: Colors.white),
  title: const Text(
    "Leaves",
    style: TextStyle(color: Colors.white),
  ),
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
),

      body: Padding(
        padding: EdgeInsets.all(10),
        child: leaves.isEmpty
            ? Center(child: Text("No Leaves Available"))
            : ListView.builder(
          itemCount: leaves.length,
          itemBuilder: (context, index) {
            return LeaveCard(leave: leaves[index]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToLeaveForm,
        backgroundColor: const Color.fromARGB(255, 80, 113, 223),
        child: Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 3, //Highlight "Leave" tab
        onItemTapped: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/dashboard');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/visit');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/bookOrder');
          }
        },
      ),
    );
  }
}

class LeaveCard extends StatelessWidget {
  final Map<String, dynamic> leave;

  LeaveCard({required this.leave});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Leave Type: ${leave['type']}", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text("From Date: ${leave['fromDate']}"),
            Text("To Date: ${leave['toDate']}"),
            SizedBox(height: 5),
            Text("Reason: ${leave['reason']}", style: TextStyle(color: Colors.orange)),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 88, 147, 196),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text("Status: ${leave['status']}", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
