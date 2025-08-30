import 'package:flutter/material.dart';

class YearlySalesTargetPage extends StatefulWidget {
  const YearlySalesTargetPage({Key? key}) : super(key: key);

  @override
  State<YearlySalesTargetPage> createState() => _YearlySalesTargetPageState();
}

class _YearlySalesTargetPageState extends State<YearlySalesTargetPage> {
  final Color primaryGreen =  Color.fromRGBO(81, 120, 237, 1); // Replace blue with green

  final List<Map<String, dynamic>> productList = const [
    {'name': 'AZISKIN 500 MG', 'priPts': '56.9125', 'secPts': '0.0'},
    {'name': 'BASECORT', 'priPts': '67.4242', 'secPts': '0.0'},
  ];

  final List<String> years = ['2024-2025', '2023-2024'];
  final List<String> quarters = ['Quarter 1', 'Quarter 2'];
  final List<String> employees = ['Employee 1', 'Employee 2'];

  String selectedYear = '2024-2025';
  String selectedQuarter = 'Quarter 1';
  String selectedEmployee = 'Employee 1';

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
    'Yearly Sales Target',
    style: TextStyle(color: Colors.white, fontSize: 20),
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  leading: IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () => Navigator.pop(context),
  ),
),

      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 70), // Space for bottom bar
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildDropdown(
                              years,
                              selectedYear,
                                  (val) => setState(() => selectedYear = val),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildDropdown(
                              quarters,
                              selectedQuarter,
                                  (val) => setState(() => selectedQuarter = val),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _buildDropdown(
                        employees,
                        selectedEmployee,
                            (val) => setState(() => selectedEmployee = val),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: productList.length,
                    itemBuilder: (context, index) {
                      final product = productList[index];
                      return _buildProductSection(
                        productName: product['name'],
                        priPts: product['priPts'],
                        secPts: product['secPts'],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // Fixed bottom total section
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 60,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Expanded(
                    flex: 2,
                    child: Text(
                      'Total',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(child: _dataBox('0/0')),
                  Expanded(child: _dataBox('0/0')),
                  Expanded(child: _dataBox('0/0')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(
      List<String> items,
      String selectedValue,
      void Function(String) onChanged,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: primaryGreen),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton<String>(
        value: selectedValue,
        isExpanded: true,
        underline: const SizedBox(),
        icon: const Icon(Icons.keyboard_arrow_down),
        items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
        onChanged: (val) {
          if (val != null) onChanged(val);
        },
      ),
    );
  }

  Widget _buildProductSection({
    required String productName,
    required String priPts,
    required String secPts,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$productName   PRI PTS-$priPts   SEC PTS-$secPts',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryGreen,
              ),
            ),
            const Divider(),
            ...['April', 'May', 'June', 'Total'].map((month) => _buildMonthRow(month)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthRow(String month) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(month, style: const TextStyle(fontWeight: FontWeight.w500)),
          ),
          Expanded(child: _dataBox('0/0')),
          Expanded(child: _dataBox('0/0')),
          Expanded(child: _dataBox('0/0')),
        ],
      ),
    );
  }

  Widget _dataBox(String text) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(text),
    );
  }
}
