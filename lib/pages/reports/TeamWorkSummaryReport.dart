import 'package:flutter/material.dart';

class TeamWorkSummaryReportPage extends StatefulWidget {
  const TeamWorkSummaryReportPage({Key? key}) : super(key: key);

  @override
  _TeamWorkSummaryReportPageState createState() => _TeamWorkSummaryReportPageState();
}

class _TeamWorkSummaryReportPageState extends State<TeamWorkSummaryReportPage> with SingleTickerProviderStateMixin{
  String selectedStatus = 'All';
  String selectedEmployee = 'Employee 1';
  String fromDate = '';
  String toDate = '';
  late TabController _tabController;


  final List<String> employees = ['Employee 1', 'Employee 2','Employee 3'];




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
    'Team Work Summary Report',
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
                          hintText: fromDate.isEmpty ? 'Date' : fromDate,
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
            // Employee Dropdown
            Row(
              children: [

              ],
            ),
            const SizedBox(height: 10),




            const SizedBox(height: 20),


          ],
        ),
      ),
    );
  }

}
// Visit List Builder
