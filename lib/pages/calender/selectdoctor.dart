import 'package:flutter/material.dart';

class SelectDoctorPage extends StatefulWidget {
  @override
  _SelectDoctorPageState createState() => _SelectDoctorPageState();
}

class _SelectDoctorPageState extends State<SelectDoctorPage> {
  String? selectedOption;
  List<String> options = ['Option 1', 'Option 2', 'Option 3'];

  // Sample doctor data
  List<Map<String, dynamic>> doctors = [
    {'name': 'Dr. Sumit Patil (0/1)', 'specialty': 'DVD Derma', 'city': 'Mumbai', 'selected': false},
    {'name': 'Dr. Yash Patil (0/1)', 'specialty': 'Cardio', 'city': 'Delhi', 'selected': false},
    {'name': 'Dr. Pratik Mohod (0/1)', 'specialty': 'Neuro', 'city': 'Bangalore', 'selected': false},
    {'name': 'Dr. Kapil Sharma (0/1)', 'specialty': 'Ortho', 'city': 'Chennai', 'selected': false},
  ];

  void _submitSelection() {
    List<Map<String, dynamic>> selectedDoctors = doctors.where((doc) => doc['selected']).toList();

    if (selectedDoctors.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select at least one doctor")),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: EdgeInsets.all(20),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Opening map...")));
                // Add actual map navigation logic here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:  Color.fromRGBO(81, 120, 237, 1),
                minimumSize: Size(double.infinity, 48),
              ),
              child: Text("VIEW LOCATION ON MAP", style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Add Visit tapped")));
                // Add actual visit-adding logic here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:  Color.fromRGBO(81, 120, 237, 1),
                minimumSize: Size(double.infinity, 48),
              ),
              child: Text("ADD VISIT(S)", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
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
    'Select Doctors',
    style: TextStyle(color: Colors.white),
  ),
  iconTheme: const IconThemeData(color: Colors.white),
),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Select Option",
                border: OutlineInputBorder(),
              ),
              value: selectedOption,
              items: options
                  .map((option) => DropdownMenuItem(
                child: Text(option),
                value: option,
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedOption = value;
                });
              },
            ),

            SizedBox(height: 16),

            // Label for doctor count
            Text(
              "Doctor count: ${doctors.length}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 16),

            // Doctor list
            Expanded(
              child: ListView.builder(
                itemCount: doctors.length,
                itemBuilder: (context, index) {
                  var doctor = doctors[index];
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0), // Added padding to fix overflow
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${doctor['name']}", style: TextStyle(fontWeight: FontWeight.bold)),
                                    SizedBox(height: 4),
                                    Text("${doctor['specialty']}"),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Checkbox(
                                    value: doctor['selected'],
                                    onChanged: (value) {
                                      setState(() {
                                        doctor['selected'] = value!;
                                        print(value);
                                      });
                                    },
                                    activeColor:  Color.fromRGBO(81, 120, 237, 1),
                                  ),
                                  Text(
                                    doctor['city'],
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          // "View Last Five Visits" Button
                          if (doctor['selected']) ...[
                            SizedBox(height: 8),
                            TextButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Showing last five visits for ${doctor['name']}")),
                                );
                              },
                              child: Text("View Last Five Visits"),
                              style: TextButton.styleFrom(
                                foregroundColor:  Color.fromRGBO(81, 120, 237, 1),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 10),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitSelection,
                style: ElevatedButton.styleFrom(backgroundColor:  Color.fromRGBO(81, 120, 237, 1)),
                child: Text("Submit", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
