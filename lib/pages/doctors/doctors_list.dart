import 'package:flutter/material.dart';

import 'add_doctor.dart';

const Color visitBlue = Color(0xFF1976D2); // Main blue
const Color visitBlueLight =
    const Color.fromRGBO(114, 142, 242, 1); // Light blue background
const Color visitRed = Color(0xFFD32F2F); // For pending/red indicators

const LinearGradient primaryGradient = LinearGradient(
  colors: [Color(0xFF42A5F5), Color(0xFF1976D2)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

class DoctorsPage extends StatefulWidget {
  @override
  _DoctorsPageState createState() => _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> doctors = [
    {
      'name': 'ASHWINI BHOPLE',
      'location': 'Aurangabad, Maharashtra',
      'type': 'Non Prescriber',
      'range': '0-5000',
    },
    {
      'name': 'AJINKYA SAWANT (0/1)',
      'location': 'Aurangabad, Maharashtra',
      'type': 'Non Prescriber',
      'range': '0-5000',
    },
    // Add more doctors here
  ];

  List<Map<String, String>> filteredDoctors = [];

  @override
  void initState() {
    super.initState();
    filteredDoctors = List.from(doctors);
    _searchController.addListener(_filterDoctors);
  }

  void _filterDoctors() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredDoctors = doctors.where((doctor) {
        final name = doctor['name']!.toLowerCase();
        final location = doctor['location']!.toLowerCase();
        final type = doctor['type']!.toLowerCase();
        return name.contains(query) ||
            location.contains(query) ||
            type.contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Doctors", style: TextStyle(color: Colors.white)),
        backgroundColor: visitBlue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search by Name, City, Hospital Name",
                hintStyle: TextStyle(
                  color: Colors.grey[600], // Slightly lighter font color
                  fontSize: 14,
                ),
                prefixIcon: const Icon(Icons.search),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                      color: visitBlue), // Blue border when not focused
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                      color: visitBlue,
                      width: 2), // Thicker blue border when focused
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: filteredDoctors.length,
              itemBuilder: (context, index) {
                final doctor = filteredDoctors[index];
                return GestureDetector(
                  onTap: () => _showDoctorOptions(context),
                  child: _buildDoctorCard(doctor),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddDoctorPage()));
        },
        backgroundColor: visitBlue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildDoctorCard(Map<String, String> doctor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row with avatar, name/address, and call button
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: const Color.fromARGB(255, 192, 203, 212),
                child: Text(
                  doctor['name']![0], // First initial
                  style: const TextStyle(
                      color: Color.fromARGB(255, 33, 74, 221),
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(doctor['name']!,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(doctor['location']!,
                            style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: visitBlue,
                  padding: const EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8), // Adjust the value as needed
                  ),
                ),
                child: const Icon(Icons.call, size: 16, color: Colors.white),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Divider line
          const Divider(height: 1, color: Colors.grey),

          const SizedBox(height: 12),

          // Row with two pieces of text spaced apart

          Text(
            doctor['type']!,
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
          Text(
            "👥 ${doctor['range']!}",
            style: const TextStyle(fontSize: 12),
          ),

          const SizedBox(height: 8),
          // Preferred Day/Time

          // Bottom right "Order Detail" button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Pref Day/Time",
                style: TextStyle(
                    color: visitBlue,
                    fontWeight: FontWeight.w600,
                    fontSize: 13),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: visitBlue,
                  side: BorderSide(color: visitBlue),
                ),
                child: const Text("Order Detail"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showDoctorOptions(BuildContext context) {
    String? selectedOption;
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RadioListTile(
                      title: const Text("View/Edit Client"),
                      value: "View/Edit",
                      groupValue: selectedOption,
                      onChanged: (value) =>
                          setState(() => selectedOption = value as String),
                    ),
                    RadioListTile(
                      title: const Text("Add Visit"),
                      value: "Add Visit",
                      groupValue: selectedOption,
                      onChanged: (value) =>
                          setState(() => selectedOption = value as String),
                    ),
                    RadioListTile(
                      title: const Text("Delete Client"),
                      value: "Delete",
                      groupValue: selectedOption,
                      onChanged: (value) =>
                          setState(() => selectedOption = value as String),
                    ),
                    RadioListTile(
                      title: const Text("View Last Five Visits"),
                      value: "Last Five",
                      groupValue: selectedOption,
                      onChanged: (value) =>
                          setState(() => selectedOption = value as String),
                    ),
                    RadioListTile(
                      title: const Text("Add Payment"),
                      value: "Add Payment",
                      groupValue: selectedOption,
                      onChanged: (value) =>
                          setState(() => selectedOption = value as String),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("CANCEL",
                              style: TextStyle(color: visitBlue)),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("SUBMIT",
                              style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: visitBlue,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
