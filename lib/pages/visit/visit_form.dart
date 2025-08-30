import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

import '../presentation/PresentationPage.dart';
import 'SelectWorkingWithPage.dart';

class VisitFormPage extends StatefulWidget {
  @override
  _VisitFormPageState createState() => _VisitFormPageState();
}

class _VisitFormPageState extends State<VisitFormPage> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController doctorNameController = TextEditingController();
  final TextEditingController hospitalNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController extraInfoController = TextEditingController();
  final TextEditingController objectiveController = TextEditingController();
  final TextEditingController remarkController = TextEditingController();

  String? doctorType;
  String? specialty;
  String? priority;
  String? visitObjective;
  File? _pickedImage;
  bool showPostSubmitDialog = false;
  bool showPostVisitButtons = false;

  late TabController _tabController;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }


  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
          Color.fromRGBO(88, 125, 237, 1), // rgba(88, 125, 237, 1)
          Color.fromRGBO(81, 120, 237, 1), // rgba(81, 120, 237, 1)
          Color.fromRGBO(114, 142, 242, 1), // rgba(114, 142, 242, 1)
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    ),
  ),
  title: const Text("Visit", style: TextStyle(color: Colors.white)),
  leading: const BackButton(color: Colors.white),
  bottom: TabBar(
    controller: _tabController,
    labelColor: Colors.white,
    indicatorColor: Colors.white,
    unselectedLabelColor: Colors.white60,
    tabs: const [
      Tab(text: 'BASIC INFO'),
      Tab(text: 'TIMELINE'),
    ],
  ),
),

      body: Column(
        children: [
          Expanded(
            child: Form(
              key: _formKey,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildBasicInfoTab(),
                  _buildTimelineTab(),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: showPostVisitButtons ? _buildPostVisitButtons() : _buildSubmitButton(),
          )
        ],
      ),
    );
  }

  Widget _buildBasicInfoTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildTextField(doctorNameController, "Doctor Name",),
        _buildTextField(hospitalNameController, "Hospital Name", ),
        _buildTextField(addressController, "Address"),
        _buildDropdown("Type", ["Prescriber", "Non Prescriber", "Other"], (val) => setState(() => doctorType = val), doctorType),
        _buildDropdown("Speciality", ["Derma", "Ortho"], (val) => setState(() => specialty = val), specialty),
        _buildDropdown("Priority", ["A", "B", "C"], (val) => setState(() => priority = val), priority),
        _buildDateField(dobController, "DOB"),
        _buildTextField(extraInfoController, "Extra Info (optional)", required: false),
        _buildTextField(objectiveController, "Objective (optional)", required: false),
        SizedBox(height: 12),
        ElevatedButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.camera_alt, color: Colors.white),
          label: Text("Take Picture"),
          style: ElevatedButton.styleFrom(
            backgroundColor:  Color.fromRGBO(81, 120, 237, 1),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),

      ],
    );
  }

  Widget _buildTimelineTab() {
    return Center(child: Text("Timeline content goes here"));
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        // if (_formKey.currentState!.validate()) {
        //   _showVisitObjectiveDialog();
        // }
        _showVisitObjectiveDialog();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:  Color.fromRGBO(81, 120, 237, 1),
        foregroundColor: Colors.white,
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text("I Am Here"),
    );
  }

  Widget _buildPostVisitButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              _showDoctorMetDialog();
            },
            child: Text("Close Visit"),
            style: ElevatedButton.styleFrom(
              backgroundColor:  Color.fromRGBO(81, 120, 237, 1),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PresentationPage()),
              );
            },
            child: Text("Show Presentation"),
            style: ElevatedButton.styleFrom(
              backgroundColor:  Color.fromRGBO(81, 120, 237, 1),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }

  void _showVisitObjectiveDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.flag_circle_outlined, color:  Color.fromRGBO(81, 120, 237, 1)),
            SizedBox(width: 8),
            Text("Visit Objective", style: TextStyle(color:  Color.fromRGBO(81, 120, 237, 1))),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: visitObjective,
                hint: Text("Select Objective"),
                decoration: InputDecoration(
                  filled: true,
                  fillColor:  Color.fromRGBO(81, 120, 237, 1).withOpacity(0.05),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                onChanged: (value) => setState(() => visitObjective = value),
                items: ["Thank You Call", "Business Call"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                validator: (val) => val == null ? 'Required' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: remarkController,
                decoration: InputDecoration(
                  labelText: "Call Objective Remark",
                  labelStyle: TextStyle(color: Colors.black87),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.cancel_outlined, color: Colors.red),
            label: Text("Cancel", style: TextStyle(color: Colors.red)),
          ),
          ElevatedButton.icon(
            onPressed: () {
              if (visitObjective != null) {
                Navigator.pop(context);
                setState(() => showPostVisitButtons = true);
              }
            },
            icon: Icon(Icons.check_circle_outline),
            label: Text("OK"),
            style: ElevatedButton.styleFrom(
              backgroundColor:  Color.fromRGBO(81, 120, 237, 1),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  void _showDoctorMetDialog() {
    String? doctorMet;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Green title header
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color:  Color.fromRGBO(81, 120, 237, 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Were you able to meet the Doctors?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              // Radio options
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildRadioOption("No", doctorMet, (val) {
                      doctorMet = val;
                      (context as Element).markNeedsBuild(); // Refresh only dialog
                    }),
                    _buildRadioOption("Yes", doctorMet, (val) {
                      doctorMet = val;
                      (context as Element).markNeedsBuild();
                    }),
                  ],
                ),
              ),

              // Divider
              Divider(height: 1, color: Colors.grey.shade300),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("CANCEL", style: TextStyle(color: Colors.grey[800])),
                    ),
                  ),
                  Container(width: 1, height: 48, color: Colors.grey.shade300),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        if (doctorMet == "Yes") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SelectWorkingWithPage()),
                          );

                        } else if (doctorMet == "No") {
                          Navigator.pop(context);
                        }
                      },
                      child: Text("OK", style: TextStyle(color:  Color.fromRGBO(81, 120, 237, 1), fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }


  Widget _buildRadioOption(String label, String? groupVal, ValueChanged<String?> onChanged) {
    return Row(
      children: [
        Radio<String>(
          value: label,
          groupValue: groupVal,
          onChanged: onChanged,
          activeColor:  Color.fromRGBO(81, 120, 237, 1),
        ),
        Text(label, style: TextStyle(fontSize: 14)),
      ],
    );
  }


  Widget _buildTextField(TextEditingController controller, String label, {bool required = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: (value) => required && (value == null || value.isEmpty) ? 'Required' : null,
      ),
    );
  }


  Widget _buildDateField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          suffixIcon: Icon(Icons.calendar_today),
        ),
        onTap: () async {
          DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
          );
          if (picked != null) {
            controller.text = DateFormat('yyyy-MM-dd').format(picked);
          }
        },
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items, ValueChanged<String?> onChanged, String? currentValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: DropdownButtonFormField<String>(
        value: currentValue,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        items: items.map((val) => DropdownMenuItem(value: val, child: Text(val))).toList(),
        onChanged: onChanged,
        validator: (value) => value == null ? 'Required' : null,
      ),
    );
  }
}
