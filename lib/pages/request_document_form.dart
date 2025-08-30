import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RequestDocumentFormPage extends StatefulWidget {
  @override
  _RequestDocumentFormPageState createState() => _RequestDocumentFormPageState();
}

class _RequestDocumentFormPageState extends State<RequestDocumentFormPage> {
  final _formKey = GlobalKey<FormState>();

  String? selectedDocument;
  DateTime? selectedDate;
  TextEditingController reasonController = TextEditingController();

  List<String> documentOptions = [
    "Salary Slip",
    "Experience Letter",
    "Offer Letter",
    "Relieving Letter",
    "Other"
  ];

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _submitRequest() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Request Submitted Successfully"), backgroundColor:  Color.fromRGBO(81, 120, 237, 1)),
      );
      Navigator.pop(context); // Go back after submission
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
  title: const Text(
    "Request Document",
    style: TextStyle(color: Colors.white),
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  backgroundColor: Colors.transparent,
  elevation: 0,
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
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dropdown for Document Selection
              Text("Select Document", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              DropdownButtonFormField<String>(
                value: selectedDocument,
                hint: Text("Choose a document"),
                items: documentOptions.map((String doc) {
                  return DropdownMenuItem<String>(
                    value: doc,
                    child: Text(doc),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedDocument = newValue;
                  });
                },
                validator: (value) => value == null ? "Please select a document" : null,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                ),
              ),
              SizedBox(height: 15),

              // Date Picker for Selecting Date
              Text("Select Date", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: selectedDate == null ? "Choose a date" : DateFormat('yyyy-MM-dd').format(selectedDate!),
                      border: UnderlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    validator: (value) => selectedDate == null ? "Please select a date" : null,
                  ),
                ),
              ),
              SizedBox(height: 15),

              // Text Field for Reason
              Text("Reason", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              TextFormField(
                controller: reasonController,
                maxLines: 3,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: "Enter reason for request",
                ),
                validator: (value) => value!.isEmpty ? "Please enter a reason" : null,
              ),
              SizedBox(height: 20),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitRequest,
                  style: ElevatedButton.styleFrom(backgroundColor:  Color.fromRGBO(81, 120, 237, 1)),
                  child: Text("Submit Request", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
