import 'package:flutter/material.dart';

class PaymentCollectionReportPage extends StatefulWidget {
  const PaymentCollectionReportPage({Key? key}) : super(key: key);

  @override
  _PaymentCollectionReportPageState createState() => _PaymentCollectionReportPageState();
}

class _PaymentCollectionReportPageState extends State<PaymentCollectionReportPage> {
  String selectedStatus = 'All';
  String selectedEmployee = 'Employee 1';
  String selectedWho = 'Doctor';
  String fromDate = '';
  String toDate = '';

  final List<String> Who= ['Doctor','Firm'];
  final List<String> employees = ['Employee 1', 'Employee 2', 'Employee 3', 'Employee 4'];
  final List<String> statusOptions = ['All', 'New', 'Close', 'Skipped', 'Rescheduled'];

  final List<Map<String, String>> PaymentCollectionReportsData = [
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
  title: const Text(
    'Payment Collection Report',
    style: TextStyle(color: Colors.white, fontSize: 20),
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  leading: IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () => Navigator.pop(context),
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
                          hintStyle: TextStyle(
                            color: Colors.black87, // Darker hint text
                            fontWeight: FontWeight.w500,
                          ),
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
                          hintStyle: TextStyle(
                            color: Colors.black87, // Darker hint text
                            fontWeight: FontWeight.w500,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(12),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: primaryGreen),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton<String>(
                      value: selectedWho,
                      isExpanded: true,
                      underline: const SizedBox(),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                      items: Who.map((type) {
                        return DropdownMenuItem<String>(
                          value: type,
                          child: Text(type),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedWho = value!;
                        });
                      },
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
           Expanded(child: Center(child: Text("No Record To Show")))
          ],
        ),
      ),
    );
  }
}
