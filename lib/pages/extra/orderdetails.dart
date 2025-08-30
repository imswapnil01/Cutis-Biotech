import 'package:flutter/material.dart';

class SalesReportPage extends StatefulWidget {
  @override
  _SalesReportPageState createState() => _SalesReportPageState();
}

class _SalesReportPageState extends State<SalesReportPage> {
  String selectedYear = '2025';
  String selectedMonth = 'April';
  String selectedEmployee = 'All';
  String selectedStatus = 'All';
  String selectedType = 'Firms';

  bool _isSearching = false;
  TextEditingController _searchController = TextEditingController();

  // These can later be replaced by dynamic values fetched from an API
  final List<String> years = ['2023', '2024', '2025'];
  final List<String> months = ['January', 'February', 'March', 'April', 'May'];
  final List<String> employees = ['All'];
  final List<String> statuses = [
    'All',
    'Pending',
    'Delivered',
    'Rejected',
    'Dispatched'
  ];
  final List<String> types = ['Firms', 'Doctor'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (_isSearching) {
              setState(() {
                _isSearching = false;
                _searchController.clear();
              });
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  // Add dynamic search logic here
                },
              )
            : Text("Sales Report", style: TextStyle(color: Colors.white)),
        actions: [
          if (!_isSearching)
            IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () {
                setState(() {
                  _isSearching = true;
                });
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildDropdown(years, selectedYear, 'Year',
                    (val) => setState(() => selectedYear = val!)),
                _buildDropdown(months, selectedMonth, 'Month',
                    (val) => setState(() => selectedMonth = val!)),
                _buildDropdown(employees, selectedEmployee, 'Employee',
                    (val) => setState(() => selectedEmployee = val!)),
                _buildDropdown(statuses, selectedStatus, 'Status',
                    (val) => setState(() => selectedStatus = val!)),
                _buildDropdown(types, selectedType, 'Type',
                    (val) => setState(() => selectedType = val!)),
              ],
            ),
            SizedBox(height: 40),
            Center(
              child: Text("No data available.",
                  style: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(List<String> items, String selectedValue, String label,
      ValueChanged<String?> onChanged) {
    return SizedBox(
      width: MediaQuery.of(context).size.width /
          2.5, // Responsive for 2 in a row on most screens
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        isDense: true,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: 14),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color:  Color.fromRGBO(81, 120, 237, 1)),
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
        icon: Icon(Icons.arrow_drop_down),
        onChanged: onChanged,
        items: items.map((String val) {
          return DropdownMenuItem<String>(
            value: val,
            child: Text(val, overflow: TextOverflow.ellipsis),
          );
        }).toList(),
      ),
    );
  }
}
