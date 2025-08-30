import 'package:flutter/material.dart';

class MedicineOrderPage extends StatefulWidget {
  // final String doctorName; // Doctor is pre-filled

  // const MedicineOrderPage({super.key, required this.doctorName});

  @override
  _MedicineOrderPageState createState() => _MedicineOrderPageState();
}

class _MedicineOrderPageState extends State<MedicineOrderPage> {
  String? selectedMedicine;
  int quantity = 1;
  List<Map<String, dynamic>> medicineList = [];

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
        medicineList.add({"medicine": selectedMedicine!, "quantity": quantity});
      });
    }
  }

  void editMedicine(int index) {
    setState(() {
      selectedMedicine = medicineList[index]["medicine"];
      quantity = medicineList[index]["quantity"];
      medicineList.removeAt(index);
    });
  }

  void deleteMedicine(int index) {
    setState(() {
      medicineList.removeAt(index);
    });
  }

  void submitOrder() {
    if (medicineList.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please add at least one medicine!")),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Order submitted successfully!")),
    );

    setState(() {
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
        centerTitle: true,
        title: const Text(
          "Medicine Order",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(88, 125, 237, 1), // Start
                Color.fromRGBO(81, 120, 237, 1), // Middle
                Color.fromRGBO(114, 142, 242, 1), // End
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
            // Text("Doctor: ${widget.doctorName}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            // SizedBox(height: 10),

            Text("Select Medicine"),
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
              decoration: InputDecoration(border: UnderlineInputBorder()),
            ),
            SizedBox(height: 10),

            Text("Quantity"),
            TextFormField(
              keyboardType: TextInputType.number,
              initialValue: "1",
              onChanged: (value) {
                setState(() {
                  quantity = int.tryParse(value) ?? 1;
                });
              },
              decoration: InputDecoration(border: UnderlineInputBorder()),
            ),
            SizedBox(height: 10),

            ElevatedButton(
              onPressed: addMedicine,
              style: ElevatedButton.styleFrom(backgroundColor:  Color.fromRGBO(81, 120, 237, 1)),
              child:
                  Text("Add Medicine", style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 20),

            if (medicineList.isNotEmpty) ...[
              Text("Added Medicines", style: TextStyle(fontSize: 16)),
              DataTable(
                columns: [
                  DataColumn(label: Text("Medicine")),
                  DataColumn(label: Text("Quantity")),
                  DataColumn(label: Text("Actions")),
                ],
                rows: medicineList.asMap().entries.map((entry) {
                  int index = entry.key;
                  return DataRow(cells: [
                    DataCell(Text(entry.value["medicine"])),
                    DataCell(Text(entry.value["quantity"].toString())),
                    DataCell(Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.orange),
                          onPressed: () => editMedicine(index),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deleteMedicine(index),
                        ),
                      ],
                    )),
                  ]);
                }).toList(),
              ),
              SizedBox(height: 20),
            ],

            Center(
              child: ElevatedButton(
                onPressed: submitOrder,
                style: ElevatedButton.styleFrom(backgroundColor:  Color.fromRGBO(81, 120, 237, 1)),
                child:
                    Text("Submit Order", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
