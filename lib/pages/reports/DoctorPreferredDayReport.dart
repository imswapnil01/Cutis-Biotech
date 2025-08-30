import 'package:flutter/material.dart';

class DoctorPreferredDayReportPage extends StatefulWidget {
  const DoctorPreferredDayReportPage({Key? key}) : super(key: key);

  @override
  _DoctorPreferredDayReportPageState createState() =>
      _DoctorPreferredDayReportPageState();
}

class _DoctorPreferredDayReportPageState
    extends State<DoctorPreferredDayReportPage> {
  String selectedYear = '2024';
  String selectedMonth = 'April';
  String selectEmployee = 'Employee 1';
  String selectProduct = 'Product 1';
  String selectQuarter = 'Monthly';
  bool isChecked = false;

  final List<String> employees = ['Employee 1', 'Employee 2', 'Employee 3'];
  final List<String> weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday'
  ];
  String selectedWeekday = 'Monday';

  final Color primaryBlue = const Color.fromRGBO(81, 120, 237, 1);

  final List<Map<String, String>> doctorData = [
    {
      'name': 'Dr. Santosh Dabhade',
      'city': 'Dewas',
      'address':
          '1-3, Yamuna Nagar, A.B. Road,\nOpp. Sharadha Mandir, Mishrilal Nagar,\nGarage Nagar, Dewas, MP 455001'
    },
    {
      'name': 'Dr. Narendra Gokhale',
      'city': 'Indore',
      'address':
          '1-106, Old Palasia,\nIndore, Madhya Pradesh,\n452018, India'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Product Wise Target Report',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dropdowns
              Row(
                children: [
                  Expanded(
                    child: _buildDropdown(
                      value: selectedWeekday,
                      items: weekdays,
                      onChanged: (value) =>
                          setState(() => selectedWeekday = value!),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildDropdown(
                      value: selectEmployee,
                      items: employees,
                      onChanged: (value) =>
                          setState(() => selectEmployee = value!),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Doctor cards
              ...doctorData.map((doctor) => SizedBox(
                    width: double.infinity,
                    child: DoctorCard(
                      name: doctor['name']!,
                      city: doctor['city']!,
                      address: doctor['address']!,
                      highlightColor: primaryBlue,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: primaryBlue),
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
    );
  }
}

class DoctorCard extends StatelessWidget {
  final String name;
  final String city;
  final String address;
  final Color highlightColor;

  const DoctorCard({
    Key? key,
    required this.name,
    required this.city,
    required this.address,
    this.highlightColor = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: highlightColor.withOpacity(0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: highlightColor,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              city,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 6),
            Text(
              address,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
