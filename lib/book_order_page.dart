import 'package:cutis_biotech/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';

class BookOrderPage extends StatefulWidget {
  final String? doctorName;

  const BookOrderPage({super.key, this.doctorName});

  @override
  _BookOrderPageState createState() => _BookOrderPageState();
}

class _BookOrderPageState extends State<BookOrderPage> {
  String? selectedCounter;
  String? selectedDoctor;
  String? selectedMedical;
  String? selectedMedicine;
  int quantity = 1;
  TextEditingController quantityController = TextEditingController(text: "1");

  List<Map<String, dynamic>> medicineList = [];

  final List<String> counters = ["Dr. Counter", "General Counter"];
  final List<String> doctors = [
    "Dr. Pankaj Lande",
    "Dr. Ramesh Patil",
    "Dr. Sneha Verma"
  ];
  final List<String> medicals = [
    "Medical Store 1",
    "Medical Store 2",
    "Medical Store 3"
  ];
  final List<String> medicines = [
    "Paracetamol",
    "Ibuprofen",
    "Amoxicillin",
    "Cough Syrup",
    "Vitamin C"
  ];

  @override
  void initState() {
    super.initState();
    selectedDoctor = widget.doctorName;
  }

  void addMedicine() {
    if (selectedMedicine != null && quantity > 0) {
      setState(() {
        medicineList.add({"medicine": selectedMedicine!, "quantity": quantity});
        selectedMedicine = null;
        quantity = 1;
        quantityController.text = "1";
      });
    }
  }

  void editMedicine(int index) {
    setState(() {
      selectedMedicine = medicineList[index]["medicine"];
      quantity = medicineList[index]["quantity"];
      quantityController.text = quantity.toString();
      medicineList.removeAt(index);
    });
  }

  void deleteMedicine(int index) {
    setState(() {
      medicineList.removeAt(index);
    });
  }

  void submitOrder() {
    if (selectedCounter == null ||
        (selectedCounter == "Dr. Counter" && selectedDoctor == null) ||
        selectedMedical == null ||
        medicineList.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in all required fields!")),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Order submitted successfully!")),
    );

    setState(() {
      selectedDoctor = null;
      selectedMedical = null;
      selectedMedicine = null;
      quantity = 1;
      quantityController.text = "1";
      medicineList.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
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
          title:
              const Text("Book Order", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Counter Selection
            Text("Select Counter"),
            DropdownButtonFormField<String>(
              value: selectedCounter,
              items: counters.map((counter) {
                return DropdownMenuItem(value: counter, child: Text(counter));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCounter = value;
                  selectedDoctor = null;
                });
              },
              decoration: InputDecoration(border: UnderlineInputBorder()),
            ),
            SizedBox(height: 10),

            // Doctor Selection (Only for Dr. Counter)
            if (selectedCounter == "Dr. Counter") ...[
              Text("Select Doctor"),
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
                decoration: InputDecoration(border: UnderlineInputBorder()),
              ),
              SizedBox(height: 10),
            ],

            // Medical Selection
            Text("Select Medical"),
            DropdownButtonFormField<String>(
              value: selectedMedical,
              items: medicals.map((medical) {
                return DropdownMenuItem(value: medical, child: Text(medical));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedMedical = value;
                });
              },
              decoration: InputDecoration(border: UnderlineInputBorder()),
            ),
            SizedBox(height: 10),
            // Medicine Selection
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

            // Quantity Input with "+" and "-" buttons
            Row(
              children: [
                Text("Quantity: ", style: TextStyle(fontSize: 16)),
                Container(
                  width: 120, // Adjust width for better UI
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove, color: Colors.red),
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() {
                              quantity--;
                              quantityController.text = quantity.toString();
                            });
                          }
                        },
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: quantityController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(border: InputBorder.none),
                          onChanged: (value) {
                            setState(() {
                              quantity = int.tryParse(value) ?? 1;
                            });
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add, color:  Color.fromRGBO(81, 120, 237, 1)),
                        onPressed: () {
                          setState(() {
                            quantity++;
                            quantityController.text = quantity.toString();
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: addMedicine,
                  style:
                      ElevatedButton.styleFrom(backgroundColor:  Color.fromRGBO(81, 120, 237, 1)),
                  child: Text("Add", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Display Added Medicines
            if (medicineList.isNotEmpty) ...[
              Text("Added Medicines",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text("Medicine")),
                    DataColumn(label: Text("Quantity")),
                    DataColumn(label: Text("Actions")),
                  ],
                  rows: List.generate(medicineList.length, (index) {
                    return DataRow(cells: [
                      DataCell(Text(medicineList[index]["medicine"])),
                      DataCell(
                          Text(medicineList[index]["quantity"].toString())),
                      DataCell(Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => editMedicine(index),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => deleteMedicine(index),
                          ),
                        ],
                      )),
                    ]);
                  }),
                ),
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
                child:
                    Text("Submit Order", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: 2, //Highlight "Leave" tab
        onItemTapped: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/dashboard');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/visit');
          } else if (index == 3) {
            Navigator.pushNamed(context, '/leave');
          }
        },
      ),
    );
  }
}
