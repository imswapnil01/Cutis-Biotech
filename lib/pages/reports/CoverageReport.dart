import 'package:flutter/material.dart';

class CoveragereportPage extends StatefulWidget {
  const CoveragereportPage({Key? key}) : super(key: key);

  @override
  _CoveragereportPageState createState() => _CoveragereportPageState();
}

class _CoveragereportPageState extends State<CoveragereportPage> {
  final Color primaryGreen =  Color.fromRGBO(81, 120, 237, 1);

  String selectedYear = '2024';
  String selectedMonth = 'April';
  String selectedEmployee = 'Amit';
  String selectedCategory = 'All Category';
  String searchQuery = '';
  bool _isSearching = false;
  TextEditingController _searchController = TextEditingController();


  final List<String> years = ['2022', '2023', '2024', '2025'];
  final List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];
  final List<String> employees = ['Amit'];
  final List<String> categories = ['All Category', 'A','B','C'];

  final List<Map<String, String>> reportData = [
    {'Name': 'Amit', 'city': 'Amravati', 'days': '0', 'count': '0','Category':'A'},
    {'Name': 'Jane', 'city': 'Pune', 'days': '0', 'count': '0','Category':'B'},

  ];

  List<Map<String, String>> get filteredData {
    return reportData.where((report) {
      return report['Name']!.toLowerCase().contains(searchQuery.toLowerCase()) ||
          report['city']!.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  Widget buildDropdown({
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(color: primaryGreen),
          borderRadius: BorderRadius.circular(10),
        ),
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          underline: const SizedBox(),
          icon: const Icon(Icons.keyboard_arrow_down),
          style: const TextStyle(color: Colors.black, fontSize: 14),
          items: items.map((item) {
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

  // void showSearchDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (_) => AlertDialog(
  //       title: const Text('Search'),
  //       content: TextField(
  //         decoration: const InputDecoration(hintText: 'Search by user or city'),
  //         onChanged: (value) {
  //           setState(() {
  //             searchQuery = value;
  //           });
  //         },
  //       ),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context),
  //           child: const Text('Close'),
  //         )
  //       ],
  //     ),
  //   );
  // }
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
            hintText: 'Search by name ',
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
          'Coverage Report',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
  iconTheme: const IconThemeData(color: Colors.white),
  leading: IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () => Navigator.pop(context),
  ),
  actions: [
    IconButton(
      icon: Icon(_isSearching ? Icons.close : Icons.search, color: Colors.white),
      onPressed: () {
        setState(() {
          if (_isSearching) {
            searchQuery = '';
            _searchController.clear();
          }
          _isSearching = !_isSearching;
        });
      },
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
                buildDropdown(
                  value: selectedYear,
                  items: years,
                  onChanged: (val) => setState(() => selectedYear = val!),
                ),
                const SizedBox(width: 10),
                buildDropdown(
                  value: selectedMonth,
                  items: months,
                  onChanged: (val) => setState(() => selectedMonth = val!),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                buildDropdown(
                  value: selectedEmployee,
                  items: employees,
                  onChanged: (val) => setState(() => selectedEmployee = val!),
                ),
                const SizedBox(width: 10),
                buildDropdown(
                  value: selectedCategory,
                  items: categories,
                  onChanged: (val) => setState(() => selectedCategory = val!),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Table Header
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: primaryGreen, width: 2),
                ),
              ),
              child: Row(
                children: const [
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Name',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Days',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Count',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),

            // Table Rows
            Expanded(
              child: ListView.builder(
                itemCount: filteredData.length,
                itemBuilder: (context, index) {
                  final report = filteredData[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 0.5),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                report['Name']!,
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                report['city']!,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            report['days']!,
                            style: const TextStyle(fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            report['count']!,
                            style: const TextStyle(fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
