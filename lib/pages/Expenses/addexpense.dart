import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({Key? key}) : super(key: key);

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  DateTime? selectedDate;
  String selectedType = 'Other';
  TextEditingController amountController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  File? pickedFile;
  File? capturedImage;

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 2),
      lastDate: DateTime(now.year + 1),
    );
    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  Future<void> _pickFile() async {
    final result = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (result != null) setState(() => pickedFile = File(result.path));
  }

  Future<void> _takePhoto() async {
    final result = await ImagePicker().pickImage(source: ImageSource.camera);
    if (result != null) setState(() => capturedImage = File(result.path));
  }

  void _addExpense() {
    if (selectedDate != null &&
        amountController.text.isNotEmpty &&
        selectedType.isNotEmpty) {
      Navigator.pop(context, {
        'date': selectedDate,
        'type': selectedType,
        'amount': amountController.text,
        'note': noteController.text,
        'file': pickedFile,
        'image': capturedImage,
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all required fields")),
      );
    }
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
  leading: BackButton(color: Colors.white),
  title: Text("Add Expense", style: TextStyle(color: Colors.white)),
),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _formField(
              label: "Select Date",
              child: InkWell(
                onTap: _pickDate,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    selectedDate != null
                        ? "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}"
                        : "Choose a date",
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
            _formField(
              label: "Expense Type",
              child: Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: Theme.of(context).colorScheme.copyWith(primary:  Color.fromRGBO(81, 120, 237, 1)),
                ),
                child: DropdownButtonFormField<String>(
                  value: selectedType,
                  decoration: _inputDecoration(),
                  items: ['Other', 'MISC']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (val) => setState(() => selectedType = val!),
                ),
              ),
            ),
            SizedBox(height: 12),
            _formField(
              label: "Amount",
              child: TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration(hintText: 'Enter amount'),
              ),
            ),
            SizedBox(height: 12),
            _formField(
              label: "Note",
              child: TextField(
                controller: noteController,
                decoration: _inputDecoration(hintText: 'Optional note'),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.attach_file, color:  Color.fromRGBO(81, 120, 237, 1)),
                  onPressed: _pickFile,
                ),
                IconButton(
                  icon: Icon(Icons.camera_alt, color:  Color.fromRGBO(81, 120, 237, 1)),
                  onPressed: _takePhoto,
                ),
                if (pickedFile != null) Text("📎 File", style: TextStyle(fontSize: 12)),
                if (capturedImage != null) Text("📷 Pic", style: TextStyle(fontSize: 12)),
              ],
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:  Color.fromRGBO(81, 120, 237, 1),
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: _addExpense,
                child: Text("Add Expense", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _formField({required String label, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
        SizedBox(height: 4),
        child,
      ],
    );
  }

  InputDecoration _inputDecoration({String? hintText}) {
    return InputDecoration(
      hintText: hintText,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color:  Color.fromRGBO(81, 120, 237, 1)),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
