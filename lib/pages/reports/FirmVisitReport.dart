import 'package:flutter/material.dart';

class Firmvisitreport extends StatefulWidget {
  const Firmvisitreport({Key? key}) : super(key: key);

  @override
  _FirmvisitreportState createState() => _FirmvisitreportState();
}

class _FirmvisitreportState extends State<Firmvisitreport> {
  String selectedFilterOption = 'Today';
  String selectedYear = '';
  String selectedMonth = '';
  String fromDate = '';
  String toDate = '';
  String selectedSortOption = 'A to Z';

  final List<String> years = ['2020', '2021', '2022', '2023', '2024'];
  final List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];
  final List<String> sortOptions = [
    'A to Z', 'Z to A', 'Date Time Created', 'Date Time Checked-in'
  ];

  final Color primaryGreen =  Color.fromRGBO(81, 120, 237, 1);

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
          fromDate = selectedDate.toString().split(' ')[0];
        } else if (field == 'to') {
          toDate = selectedDate.toString().split(' ')[0];
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
    'Firm Visit Report',
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
            // Main Filter Dropdown
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
                      value: selectedFilterOption,
                      isExpanded: true,
                      underline: const SizedBox(),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                      items: ['Today', 'All', 'Date'].map((option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedFilterOption = value!;

                          // Reset dependent fields to avoid crash
                          selectedYear = '';
                          selectedMonth = '';
                          fromDate = '';
                          toDate = '';
                          selectedSortOption = 'A to Z';
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Conditional Filters Based on Main Dropdown
            if (selectedFilterOption == 'All') ...[
              // Year Dropdown
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
                        value: selectedYear.isEmpty ? null : selectedYear,
                        isExpanded: true,
                        underline: const SizedBox(),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        style: const TextStyle(color: Colors.black, fontSize: 14),
                        hint: const Text('Select Year'),
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
                ],
              ),
              const SizedBox(height: 10),
              // Month Dropdown
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
                        value: selectedMonth.isEmpty ? null : selectedMonth,
                        isExpanded: true,
                        underline: const SizedBox(),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        style: const TextStyle(color: Colors.black, fontSize: 14),
                        hint: const Text('Select Month'),
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
            ] else if (selectedFilterOption == 'Date') ...[
              // From Date
              Row(
                children: [
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
              // const SizedBox(height: 10),
              // Sort Dropdown

            // Sort Dropdown (always visible)

            ],
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
                      value: selectedSortOption,
                      isExpanded: true,
                      underline: const SizedBox(),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                      items: sortOptions.map((sortOption) {
                        return DropdownMenuItem<String>(
                          value: sortOption,
                          child: Text(sortOption),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedSortOption = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            // Empty Body (to be designed later)
          ],
        ),
      ),
    );
  }
}
