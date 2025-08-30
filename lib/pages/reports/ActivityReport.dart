import 'package:flutter/material.dart';

class ActivityReportPage extends StatefulWidget {
  const ActivityReportPage({Key? key}) : super(key: key);

  @override
  _ActivityReportPageState createState() => _ActivityReportPageState();
}

class _ActivityReportPageState extends State<ActivityReportPage> with SingleTickerProviderStateMixin{
  String selectedStatus = 'All';
  String selectedZone = 'ALL';
  String fromDate = '';
  String toDate = '';
  late TabController _tabController;


  final List<String> zones = ['ALL', 'Zone 1'];


  final List<Map<String, String>> callRecordsData = [
    {'status': 'New', 'employee': 'Employee 1', 'date': '2024-04-01'},
    {'status': 'Close', 'employee': 'Employee 2', 'date': '2024-04-03'},
    {'status': 'Rescheduled', 'employee': 'Employee 3', 'date': '2024-04-05'},
    // Add more records as necessary
  ];
  final visits = [
    {'name': 'HARSHAL PATIL Sarvadnya ', 'location': 'Amravati', 'specification': 'Derma'},
    {'name': 'SANDEEP RATHOD NITYASEVA ', 'location': 'Wardha', 'specification': 'Ortho'},
    {'name': 'SHANTANU BAVASKAR SHREE ', 'location': 'Nagpur', 'specification': 'Other'},
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
  iconTheme: const IconThemeData(color: Colors.white),
  leading: IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () => Navigator.pop(context),
  ),
  title: const Text(
    'Activity Report',
    style: TextStyle(color: Colors.white, fontSize: 20),
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
                      value: selectedZone,
                      isExpanded: true,
                      underline: const SizedBox(),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                      items: zones.map((zone) {
                        return DropdownMenuItem<String>(
                          value: zone,
                          child: Text(zone),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedZone = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),



            // Download Button
            ElevatedButton.icon(
              icon: const Icon(Icons.download),
              label: const Text('Download Excel Report'),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryGreen,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                // Static version: functionality to be implemented later
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Download functionality not implemented')),
                );
              },
            ),
            const SizedBox(height: 20),


          ],
        ),
      ),
    );
  }


}
// Visit List Builder
