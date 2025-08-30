import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class JourneyPlanForm extends StatefulWidget {
  @override
  _JourneyPlanFormState createState() => _JourneyPlanFormState();
}

class _JourneyPlanFormState extends State<JourneyPlanForm> {
  final _formKey = GlobalKey<FormState>();

  // Dropdown selections
  String? selectedDoctor;
  String? selectedProjectType;
  String? selectedJourneyPlanType;
  String? selectedVisitType;
  String? selectedState;
  String? selectedDistrict;
  String? selectedTahsil;
  String? selectedModeOfTravel;
  DateTime? fromDate;
  DateTime? toDate;
  TimeOfDay? fromTime;
  TimeOfDay? toTime;
  String? fromLocation;
  String? toLocation;
  String? selectedImage;

  // Options
  final Doctors = ["Doctor 1", "Doctor 2"];
  // final projectTypes = ["Cattle Feed", "Agri Input"];
  // final journeyPlanTypes = ["Single Day", "Multiple Day"];
  // final visitTypes = ["Market Visit", "HO Visit"];
  final states = ["State 1", "State 2", "State 3"];
  final districts = ["District A", "District B", "District C"];
  final tahsils = ["Tahsil X", "Tahsil Y", "Tahsil Z"];
  final travelModes = ["Two Wheeler", "Four Wheeler", "By Bus", "By Train"];

  // Image Picker
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImage = kIsWeb ? pickedFile.path : File(pickedFile.path).path;
      });
    }
  }

  // Date Picker
  Future<void> _selectDate(bool isFrom) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && mounted) {
      setState(() {
        if (isFrom) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });
    }
  }

  // Time Picker
  Future<void> _selectTime(bool isFrom) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    // if (picked != null) {
    //   setState(() {
    //     isFrom ? fromTime = picked : toTime = picked;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Schedule Visit",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDropdown("Select Doctor", selectedDoctor, Doctors, (val) {
                  setState(() => selectedDoctor = val);
                }),
                SizedBox(height: 10),

                // project
                // _buildDropdown("Select Project Type", selectedProjectType, projectTypes, (val) {
                //   setState(() => selectedProjectType = val);
                // }),
                // SizedBox(height: 10),

                // _buildDropdown("Select Journey Plan Type", selectedJourneyPlanType, journeyPlanTypes, (val) {
                //   setState(() => selectedJourneyPlanType = val);
                // }),
                // SizedBox(height: 10),

                // _buildDropdown("Select Visit Type", selectedVisitType, visitTypes, (val) {
                //   setState(() => selectedVisitType = val);
                // }),
                // SizedBox(height: 10),

                _buildDatePicker(
                    "Visiting Date", fromDate, () => _selectDate(true)),
                SizedBox(height: 10),

                // Row(
                //   children: [
                //     Expanded(child: _buildTimePicker("From Time", fromTime, () => _selectTime(true))),
                //     SizedBox(width: 10),
                //     Expanded(child: _buildTimePicker("To Time", toTime, () => _selectTime(false))),
                //   ],
                // ),
                // SizedBox(height: 10),

                _buildDropdown("State", selectedState, states, (val) {
                  setState(() => selectedState = val);
                }),
                SizedBox(height: 10),

                _buildDropdown("District", selectedDistrict, districts, (val) {
                  setState(() => selectedDistrict = val);
                }),
                SizedBox(height: 10),

                _buildDropdown("Tahsil", selectedTahsil, tahsils, (val) {
                  setState(() => selectedTahsil = val);
                }),
                SizedBox(height: 10),

                // _buildTextField("From Location", (val) => fromLocation = val),
                // SizedBox(height: 10),
                //
                // _buildTextField("To Location", (val) => toLocation = val),
                // SizedBox(height: 10),
                //
                // _buildDropdown("Select Mode of Travel", selectedModeOfTravel, travelModes, (val) {
                //   setState(() => selectedModeOfTravel = val);
                // }),
                // SizedBox(height: 10),

                // TextFormField(
                //   keyboardType: TextInputType.number,
                //   decoration: InputDecoration(labelText: "Meter Reading", border: UnderlineInputBorder()),
                // ),
                // SizedBox(height: 10),

                TextFormField(
                  decoration: InputDecoration(
                      labelText: "Working With",
                      border: UnderlineInputBorder()),
                ),
                SizedBox(height: 10),

                // Text("Upload Meter Reading Photo", style: TextStyle(fontWeight: FontWeight.bold)),
                // SizedBox(height: 5),
                // ElevatedButton.icon(
                //   icon: Icon(Icons.camera_alt),
                //   label: Text("Pick Image"),
                //   onPressed: _pickImage,
                // ),
                // if (selectedImage != null)
                //   Padding(
                //     padding: EdgeInsets.symmetric(vertical: 10),
                //     child: kIsWeb
                //         ? Image.network(selectedImage!, height: 100, width: 100, fit: BoxFit.cover)
                //         : Image.file(File(selectedImage!), height: 100, width: 100, fit: BoxFit.cover),
                //   ),
                // SizedBox(height: 20),

                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(81, 120, 237, 1)),
                    child:
                        Text("Submit", style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Form Submitted!")),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper Functions
  Widget _buildDropdown(String title, String? value, List<String> options,
      Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      decoration:
          InputDecoration(labelText: title, border: UnderlineInputBorder()),
      value: value,
      items: options
          .map((e) => DropdownMenuItem(child: Text(e), value: e))
          .toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildTextField(String label, Function(String) onSaved) {
    return TextFormField(
      decoration:
          InputDecoration(labelText: label, border: UnderlineInputBorder()),
      onSaved: (val) => onSaved(val!),
    );
  }

  Widget _buildDatePicker(
      String title, DateTime? date, VoidCallback onPressed) {
    return ListTile(
      title: Text(
        date != null ? "$title: ${date.year}-${date.month}-${date.day}" : title,
        style: TextStyle(fontSize: 16),
      ),
      trailing:
          Icon(Icons.calendar_today, color: Color.fromRGBO(81, 120, 237, 1)),
      tileColor: Colors.grey.shade200,
      onTap: onPressed,
    );
  }
}
