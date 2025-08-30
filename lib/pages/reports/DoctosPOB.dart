import 'package:flutter/material.dart';

class DoctorsPOBPage extends StatefulWidget {
  const DoctorsPOBPage({Key? key}) : super(key: key);

  @override
  _DoctorsPOBPageState createState() => _DoctorsPOBPageState();
}

class _DoctorsPOBPageState extends State<DoctorsPOBPage> {
  String selectedYear = '2024';
  String selectedMonth = 'April';
  String selectEmployee= 'Employee 1';
  String searchQuery = '';
  bool _isSearching = false;
  TextEditingController _searchController = TextEditingController();

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
  title: _isSearching
      ? TextField(
          controller: _searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search here',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white54),
          ),
          style: const TextStyle(color: Colors.white, fontSize: 16),
          onChanged: (value) {
            setState(() {
              searchQuery = value;
            });
          },
        )
      : const Text(
          'Doctor POB Report',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
  iconTheme: const IconThemeData(color: Colors.white),
  leading: IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () => Navigator.pop(context),
  ),
  actions: [
    IconButton(
      icon: Icon(_isSearching ? Icons.close : Icons.search),
      onPressed: () {
        setState(() {
          if (_isSearching) {
            searchQuery = '';
            _searchController.clear();
          }
          _isSearching = !_isSearching;
        });
      },
      color: Colors.white,
    ),
  ],
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
                // const SizedBox(width: 10),
                // Expanded(
                //   child: Container(
                //     padding: const EdgeInsets.symmetric(horizontal: 8),
                //     decoration: BoxDecoration(
                //       border: Border.all(color: primaryGreen),
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     child: DropdownButton<String>(
                //       value: selectEmployee,
                //       isExpanded: true,
                //       underline: const SizedBox(),
                //       icon: const Icon(Icons.keyboard_arrow_down),
                //       style: const TextStyle(color: Colors.black, fontSize: 14),
                //       items: employees.map((employee) {
                //         return DropdownMenuItem<String>(
                //           value: employee,
                //           child: Text(employee),
                //         );
                //       }).toList(),
                //       onChanged: (value) {
                //         setState(() {
                //           selectEmployee = value!;
                //         });
                //       },
                //     ),
                //   ),
                // ),
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

            Expanded(child: Center(child: Text("Item Not Found")))


          ],
        ),
      ),
    );
  }
}
