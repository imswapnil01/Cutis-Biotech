import 'package:flutter/material.dart';

class HQWiseTargetReportPage extends StatefulWidget {
  const HQWiseTargetReportPage({Key? key}) : super(key: key);

  @override
  _HQWiseTargetReportPageState createState() => _HQWiseTargetReportPageState();
}

class _HQWiseTargetReportPageState extends State<HQWiseTargetReportPage> {
  String selectedYear = '2024';
  String selectedMonth = 'April';
  String selectHQCity= 'ALL';
  String selectQuarter='Monthly';
  bool isChecked= false;


  final List<String> cities = ['ALL', 'City 1'];
  final List<String> quarter = ['Weekly','Monthly', 'Year',];
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
    'HQ Wise Target Report',
    style: TextStyle(color: Colors.white, fontSize: 20),
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  leading: IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () => Navigator.pop(context),
  ),
),

      body: SingleChildScrollView(
        child: Padding(
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
                        value: selectQuarter,
                        isExpanded: true,
                        underline: const SizedBox(),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        style: const TextStyle(color: Colors.black, fontSize: 14),
                        items: quarter.map((qtr) {
                          return DropdownMenuItem<String>(
                            value: qtr,
                            child: Text(qtr),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectQuarter = value!;
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
                  SizedBox(width: 10,),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: primaryGreen),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButton<String>(
                        value: selectHQCity,
                        isExpanded: true,
                        underline: const SizedBox(),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        style: const TextStyle(color: Colors.black, fontSize: 14),
                        items: cities.map((HQ) {
                          return DropdownMenuItem<String>(
                            value: HQ,
                            child: Text(HQ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectHQCity = value!;
                          });
                        },
                      ),
                    ),
                  ),
        
                ],
              ),
              const SizedBox(height: 20),


              SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildReportSection("POB VALUE"),
                        buildReportSection("STOCKIST SECONDARY VALUE"),
                        buildReportSection("NO OF DR VISIT"),
                        buildReportSection("NO OF CHEMIST VISIT"),
                        buildReportSection("NO OF NEW CHEMIST ADDITION"),
                        buildReportSection("NO OF NEW DOCTOR ADDITION"),
                        buildReportSection("PRIMARY VALUE"),
                      ],
                    ),
                  ),
            ],
          ),
        ),
      ),

    );
  }
  Widget buildReportSection(String title) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color:  Color.fromRGBO(81, 120, 237, 1),
                  ),
                ),
                Text("Target-0")
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Center(child: Text("Target Achieved"))),
                Expanded(child: Center(child: Text("Target Achieved %"))),
                Expanded(child: Center(child: Text("Balance"))),
              ],
            ),
            const SizedBox(height: 4),
            const Divider(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Center(child: Text("0"))),
                Expanded(child: Center(child: Text("0"))),
                Expanded(child: Center(child: Text("0"))),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
