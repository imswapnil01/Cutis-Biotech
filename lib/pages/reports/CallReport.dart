import 'package:flutter/material.dart';

class CallRecordPage extends StatefulWidget {
  const CallRecordPage({Key? key}) : super(key: key);

  @override
  _CallRecordPageState createState() => _CallRecordPageState();
}

class _CallRecordPageState extends State<CallRecordPage> {
  String selectedStatus = 'All';
  String selectedEmployee = 'Employee 1';
  String fromDate = '';
  String toDate = '';

  final List<String> employees = ['Employee 1', 'Employee 2', 'Employee 3', 'Employee 4'];
  final List<String> statusOptions = ['All', 'New', 'Close', 'Skipped', 'Rescheduled'];

  final List<Map<String, String>> callRecordsData = [
    {'status': 'New', 'employee': 'Employee 1', 'date': '2024-04-01'},
    {'status': 'Close', 'employee': 'Employee 2', 'date': '2024-04-03'},
    {'status': 'Rescheduled', 'employee': 'Employee 3', 'date': '2024-04-05'},
    // Add more records as necessary
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
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  title: const Text(
    'Call Reports',
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
                      value: selectedEmployee,
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
                          selectedEmployee = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Status Dropdown
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
                      value: selectedStatus,
                      isExpanded: true,
                      underline: const SizedBox(),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                      items: statusOptions.map((status) {
                        return DropdownMenuItem<String>(
                          value: status,
                          child: Text(status),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedStatus = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Total Visits
            Text(
              'Total Visits: ${callRecordsData.length}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Table Headers (commented out)
            // Container(
            //   padding: const EdgeInsets.symmetric(vertical: 8),
            //   decoration: BoxDecoration(
            //     border: Border(
            //       bottom: BorderSide(color: primaryGreen, width: 2),
            //     ),
            //   ),
            //   child: Row(
            //     children: const [
            //       Expanded(
            //         flex: 2,
            //         child: Text(
            //           'Status',
            //           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            //         ),
            //       ),
            //       Expanded(
            //         flex: 2,
            //         child: Text(
            //           'Employee',
            //           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            //         ),
            //       ),
            //       Expanded(
            //         flex: 2,
            //         child: Text(
            //           'Date',
            //           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(height: 10),
            // Table Rows (commented out)
            // Expanded(
            //   child: callRecordsData.isEmpty
            //       ? const Center(child: Text('No items found'))
            //       : ListView.builder(
            //           itemCount: callRecordsData.length,
            //           itemBuilder: (context, index) {
            //             final record = callRecordsData[index];
            //             return Container(
            //               padding: const EdgeInsets.symmetric(vertical: 12),
            //               decoration: const BoxDecoration(
            //                 border: Border(
            //                   bottom: BorderSide(color: Colors.grey, width: 0.5),
            //                 ),
            //               ),
            //               child: Row(
            //                 children: [
            //                   Expanded(
            //                     flex: 2,
            //                     child: Text(
            //                       record['status']!,
            //                       style: const TextStyle(fontSize: 14),
            //                     ),
            //                   ),
            //                   Expanded(
            //                     flex: 2,
            //                     child: Text(
            //                       record['employee']!,
            //                       style: const TextStyle(fontSize: 14),
            //                     ),
            //                   ),
            //                   Expanded(
            //                     flex: 2,
            //                     child: Text(
            //                       record['date']!,
            //                       style: const TextStyle(fontSize: 14),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             );
            //           },
            //         ),
            // ),
          ],
        ),
      ),
    );
  }
}
