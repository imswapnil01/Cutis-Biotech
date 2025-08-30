import 'package:flutter/material.dart';

class ExpenceReportPage extends StatefulWidget {
  const ExpenceReportPage({Key? key}) : super(key: key);

  @override
  _ExpenceReportPageState createState() => _ExpenceReportPageState();
}

class _ExpenceReportPageState extends State<ExpenceReportPage> {
  String selectedYear = '2024';
  String selectedMonth = 'April';
  String selectEmployee= 'Employee 1';


  final List<String> employees = ['Employee 1', 'Employee 2','Employee 3'];
  final List<String> years = ['2022', '2023', '2024', '2025'];
  final List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];


  final Color primaryGreen =  Color.fromRGBO(81, 120, 237, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  title: const Text(
    'Expense Report',
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
            // Filters
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
                      value: selectedYear,
                      isExpanded: true,
                      underline: const SizedBox(),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                      items: years.map((year) {
                        return DropdownMenuItem<String>(
                          value: year,
                          child: Text(year),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedYear = value!;
                        });
                      },
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
                      value: selectedMonth,
                      isExpanded: true,
                      underline: const SizedBox(),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                      items: months.map((month) {
                        return DropdownMenuItem<String>(
                          value: month,
                          child: Text(month),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedMonth = value!;
                        });
                      },
                    ),
                  ),
                ),

              ],
            ),

            const SizedBox(height: 10),
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
                      value: selectEmployee,
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
                          selectEmployee = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Expanded(
              child: Column(
                children: [
                  // Table in Card
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        headingRowColor: MaterialStateProperty.all( Color.fromRGBO(81, 120, 237, 1)),
                        dataRowColor: MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                            return states.contains(MaterialState.selected)
                                ?  Color.fromRGBO(81, 120, 237, 1)
                                : null; // default
                          },
                        ),
                        headingTextStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: 14,
                        ),
                        dataTextStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                        ),
                        columnSpacing: 24,
                        horizontalMargin: 16,
                        columns: const [
                          DataColumn(label: Text('Date')),
                          DataColumn(label: Text('Day Status')),
                          DataColumn(label: Text('Working Area')),
                          DataColumn(label: Text('₹TA/DA/MISC/Other')),
                        ],
                        rows: const [
                          DataRow(cells: [
                            DataCell(Text('01-06-2025')),
                            DataCell(Text('AB')),
                            DataCell(Text('HO')),
                            DataCell(Text('₹0')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('02-06-2025')),
                            DataCell(Text('P')),
                            DataCell(Text('HO')),
                            DataCell(Text('₹0')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('03-06-2025')),
                            DataCell(Text('P')),
                            DataCell(Text('HO')),
                            DataCell(Text('₹0')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('04-06-2025')),
                            DataCell(Text('P')),
                            DataCell(Text('HO')),
                            DataCell(Text('₹0')),
                          ]),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Total Other = ₹0    Total TA/DA = ₹0    Total = ₹0.0',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),





          ],
        ),
      ),
    );
  }
}
