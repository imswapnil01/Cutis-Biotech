import 'package:flutter/material.dart';

class CallObjectiveRecordPage extends StatefulWidget {
  const CallObjectiveRecordPage({Key? key}) : super(key: key);

  @override
  _CallObjectiveRecordPageState createState() => _CallObjectiveRecordPageState();
}

class _CallObjectiveRecordPageState extends State<CallObjectiveRecordPage> with SingleTickerProviderStateMixin{
  String selectedStatus = 'All';
  String selectedCall = 'Thank You Call';
  String fromDate = '';
  String toDate = '';
  late TabController _tabController;


  final List<String> employees = ['Thank You Call', 'Business Call'];


  final List<Map<String, String>> callRecordsData = [
    {'status': 'New', 'employee': 'Employee 1', 'date': '2024-04-01'},
    {'status': 'Close', 'employee': 'Employee 2', 'date': '2024-04-03'},
    {'status': 'Rescheduled', 'employee': 'Employee 3', 'date': '2024-04-05'},
    // Add more records as necessary
  ];
  final visits = [
    {'name': 'HARSHAL PATIL Sarvadnya ', 'location': 'Amravati', 'status': 'Open'},
    {'name': 'SANDEEP RATHOD NITYASEVA ', 'location': 'Wardha', 'status': 'Open'},
    {'name': 'SHANTANU BAVASKAR SHREE ', 'location': 'Nagpur', 'status': 'Open'},
  ];

  final Color primaryGreen =  Color.fromRGBO(81, 120, 237, 1);

  // Date pickers
  Future<void> _selectDate(BuildContext context, String field) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (selectedDate != null) {
      setState(() {
        if (field == 'from') {
          fromDate = selectedDate.toString().split(' ')[0]; // Format date
        } else if (field == 'to') {
          toDate = selectedDate.toString().split(' ')[0]; // Format date
        }
      });
    }
  }
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   appBar: AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  title: const Text(
    'Call Objective Report',
    style: TextStyle(color: Colors.white, fontSize: 20),
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  leading: IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () => Navigator.pop(context),
  ),
  flexibleSpace: Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color.fromRGBO(88, 125, 237, 1),  // rgba(88, 125, 237, 1)
          Color.fromRGBO(81, 120, 237, 1),  // rgba(81, 120, 237, 1)
          Color.fromRGBO(114, 142, 242, 1), // rgba(114, 142, 242, 1)
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    ),
  ),
),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filters Section
            Row(
              children: [
                // From Date
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectDate(context, 'from'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: primaryGreen),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: fromDate.isEmpty ? 'From Date' : fromDate,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(12),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // To Date
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectDate(context, 'to'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: primaryGreen),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: toDate.isEmpty ? 'To Date' : toDate,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(12),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Employee Dropdown
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: primaryGreen),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton<String>(
                      value: selectedCall,
                      isExpanded: true,
                      underline: const SizedBox(),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                      items: employees.map((employee) {
                        return DropdownMenuItem<String>(
                          value: employee,
                          child: Text(employee),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCall = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Status Dropdown

              Expanded(
                child:
                     TabBarView(
                       controller: _tabController,
                  children: [
                    _buildVisitList(),
                    _buildVisitList(),
                  ],
                )

              ),

            const SizedBox(height: 10),



          ],
        ),
      ),
    );
  }
  Widget _buildVisitList() {
    return ListView.builder(
      itemCount: visits.length,

      itemBuilder: (context, index) {
        final visit = visits[index];
        final initial = visit['name']![0];



        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue.shade100,
              child: Text(initial, style: TextStyle(color: primaryGreen, fontWeight: FontWeight.bold)),
            ),
            title: Text(visit['name']!, overflow: TextOverflow.ellipsis),
            subtitle: Row(
              children: [
                const Icon(Icons.location_on, size: 14, color: Colors.grey),
                Text(" ${visit['location']}  "),
                Icon(Icons.check_circle, size: 14, color: primaryGreen),
                Text(" ${visit['status']!}", style: TextStyle(color: primaryGreen)),
              ],
            ),
            onTap: () {
              showVisitPopup(context, visit['name']!);
            },


          ),
        );
      },
    );
  }
  //make change by taking visited date, date is not taken dynamically....
  void showVisitPopup(BuildContext context, String doctorName) {
    final TextEditingController feedbackController = TextEditingController();
    final String visitedDate = DateTime.now().toString().split(' ')[0]; // Current date

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Visit Details",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color:  Color.fromRGBO(81, 120, 237, 1)),
                  ),
                ),
                const SizedBox(height: 16),
                Text("Employee Name: $doctorName", style: TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                Text("Visited Date: $visitedDate", style: TextStyle(fontSize: 16)),
                const SizedBox(height: 16),
                Text("Feedback:", style: TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                // TextField(
                //   controller: feedbackController,
                //   maxLines: 3,
                //   decoration: InputDecoration(
                //     hintText: "Enter your feedback...",
                //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                //   ),
                // ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor:  Color.fromRGBO(81, 120, 237, 1)),
                    onPressed: () {
                      Navigator.of(context).pop();
                      String feedback = feedbackController.text;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Feedback saved for $doctorName")),
                      );
                    },
                    child: const Text("OK", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
// Visit List Builder
