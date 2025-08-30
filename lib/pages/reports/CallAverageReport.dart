import 'package:flutter/material.dart';

class CallAverageReportPage extends StatefulWidget {
  const CallAverageReportPage({Key? key}) : super(key: key);

  @override
  _CallAverageReportPageState createState() => _CallAverageReportPageState();
}

class _CallAverageReportPageState extends State<CallAverageReportPage> {
  String selectedYear = '2024';
  String selectedMonth = 'April';
  String selectedEmployee = 'Employee 1';

  final List<String> employees = ['Employee 1', 'Employee 2', 'Employee 3'];
  final List<String> years = ['2022', '2023', '2024', '2025'];
  final List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  final Color primaryGreen =  Color.fromRGBO(81, 120, 237, 1); // Constant primary color

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  title: const Text(
    'Call Average Report',
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
            // Year and Month Dropdowns
            Row(
              children: [
                buildDropdown(selectedYear, years, (val) {
                  setState(() => selectedYear = val!);
                }),
                const SizedBox(width: 10),
                buildDropdown(selectedMonth, months, (val) {
                  setState(() => selectedMonth = val!);
                }),
              ],
            ),
            const SizedBox(height: 10),

            // Employee Dropdown
            Row(
              children: [
                Expanded(
                  child: buildDropdown(selectedEmployee, employees, (val) {
                    setState(() => selectedEmployee = val!);
                  }),
                ),
              ],
            ),
            const SizedBox(height: 20),

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

            // Placeholder content
            // const Expanded(child: Center(child: Text("Item Not Found"))),
          ],
        ),
      ),
    );
  }

  Widget buildDropdown(String currentValue, List<String> options, ValueChanged<String?> onChanged) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(color: primaryGreen),
          borderRadius: BorderRadius.circular(10),
        ),
        child: DropdownButton<String>(
          value: currentValue,
          isExpanded: true,
          underline: const SizedBox(),
          icon: const Icon(Icons.keyboard_arrow_down),
          style: const TextStyle(color: Colors.black, fontSize: 14),
          items: options.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

}
