import 'package:flutter/material.dart';

class BookOrderPage extends StatefulWidget {
  @override
  _BookOrderPageState createState() => _BookOrderPageState();
}

class _BookOrderPageState extends State<BookOrderPage> {
  String? selectedDoctor;
  String? selectedMedicine;
  int quantity = 1;

  List<Map<String, dynamic>> medicineList = [];

  final List<String> doctors = [
    "Dr. Pankaj Lande",
    "Dr. Ramesh Patil",
    "Dr. Sneha Verma"
  ];

  final List<String> medicines = [
    "Paracetamol",
    "Ibuprofen",
    "Amoxicillin",
    "Cough Syrup",
    "Vitamin C"
  ];

  void addMedicine() {
    if (selectedMedicine != null && quantity > 0) {
      setState(() {
        medicineList.add({
          "medicine": selectedMedicine!,
          "quantity": quantity,
        });
      });
    }
  }

  void submitOrder() {
    if (selectedDoctor == null || medicineList.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select a doctor and add medicines!")),
      );
      return;
    }

    // Submit logic here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Order submitted successfully!")),
    );

    // Clear fields after submission
    setState(() {
      selectedDoctor = null;
      selectedMedicine = null;
      quantity = 1;
      medicineList.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  title: const Text(
    "Book Order",
    style: TextStyle(color: Colors.white),
  ),
  flexibleSpace: Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color.fromRGBO(88, 125, 237, 1),  // rgba(88, 125, 237, 1)
          Color.fromRGBO(81, 120, 237, 1),  // rgba(81, 120, 237, 1)
          Color.fromRGBO(114, 142, 242, 1), // rgba(114, 142, 242, 1)
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    ),
  ),
),

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor Selection Dropdown
            Text("Select Doctor", style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButtonFormField<String>(
              value: selectedDoctor,
              items: doctors.map((doctor) {
                return DropdownMenuItem(value: doctor, child: Text(doctor));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedDoctor = value;
                });
              },
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),

            // Medicine Selection Dropdown
            Text("Select Medicine", style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButtonFormField<String>(
              value: selectedMedicine,
              items: medicines.map((medicine) {
                return DropdownMenuItem(value: medicine, child: Text(medicine));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedMedicine = value;
                });
              },
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),

            // Quantity Input Field
            Text("Quantity", style: TextStyle(fontWeight: FontWeight.bold)),
            TextFormField(
              keyboardType: TextInputType.number,
              initialValue: "1",
              onChanged: (value) {
                setState(() {
                  quantity = int.tryParse(value) ?? 1;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter quantity",
              ),
            ),
            SizedBox(height: 10),

            // Add Medicine Button
            ElevatedButton(
              onPressed: addMedicine,
              style: ElevatedButton.styleFrom(backgroundColor:  Color.fromRGBO(81, 120, 237, 1)),
              child: Text("Add Medicine", style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 20),

            // Table Displaying Added Medicines
            if (medicineList.isNotEmpty) ...[
              Text("Added Medicines", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              DataTable(
                columns: [
                  DataColumn(label: Text("Medicine")),
                  DataColumn(label: Text("Quantity")),
                ],
                rows: medicineList.map((med) {
                  return DataRow(cells: [
                    DataCell(Text(med["medicine"])),
                    DataCell(Text(med["quantity"].toString())),
                  ]);
                }).toList(),
              ),
              SizedBox(height: 20),
            ],

            // Submit Button
            Center(
              child: ElevatedButton(
                onPressed: submitOrder,
                style: ElevatedButton.styleFrom(
                  backgroundColor:  Color.fromRGBO(81, 120, 237, 1),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: Text("Submit Order", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
