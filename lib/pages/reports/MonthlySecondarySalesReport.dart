import 'package:flutter/material.dart';

import '../firms/firm_page.dart';

class MonthlySecondarySalesReportPage extends StatefulWidget {
  const MonthlySecondarySalesReportPage({Key? key}) : super(key: key);

  @override
  _MonthlySecondarySalesReportPageState createState() => _MonthlySecondarySalesReportPageState();
}

class _MonthlySecondarySalesReportPageState extends State<MonthlySecondarySalesReportPage> {
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
    'Monthly Secondary Sales Report',
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
                SizedBox(width: 10,),
                Expanded(
                  child: Container(
                    height: 48, // Match dropdown height
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color:  Color.fromRGBO(81, 120, 237, 1)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder:(context) => FirmsPage()));
                        },
                        child: Text(
                          "Select Stockist",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
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
