import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddFirmPage extends StatefulWidget {
  @override
  _AddFirmPageState createState() => _AddFirmPageState();
}

class _AddFirmPageState extends State<AddFirmPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController firmNameController = TextEditingController();
  final TextEditingController establishedDateController =
      TextEditingController();
  final TextEditingController contactPersonController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController gstinController = TextEditingController();
  final TextEditingController licenseController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController assignedFirmController = TextEditingController();
  final TextEditingController assignedFirmEmailController =
      TextEditingController();
  final TextEditingController assignClientsController = TextEditingController();

  // Dropdown values
  String? firmType;
  String? selectedZone;
  String? selectedCity;
  String? selectedDivision;

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
        title: const Text("Add Firm", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Firm type dropdown
            _buildDropdown(
                "Select Type",
                ["Retailer", "Distributor", "Stockist"],
                (val) => setState(() => firmType = val),
                firmType),

            _buildTextField(firmNameController, "Firm Name"),
            _buildDateField(establishedDateController, "Established Date"),
            _buildTextField(contactPersonController, "Contact Person Name"),
            _buildTextField(phoneController, "Phone Number",
                inputType: TextInputType.phone),
            _buildTextField(emailController, "Email",
                inputType: TextInputType.emailAddress),
            _buildTextField(gstinController, "GSTIN"),
            _buildTextField(licenseController, "Drug License Number"),

            // Address with icon to open map (future feature)
            _buildTextFieldWithIcon(
                addressController, "Address", Icons.location_on_outlined, () {
              // Future: Show location map
            }),

            _buildDropdown("Select Zone", ["zone1", "zone2"], (val) {
              setState(() => selectedZone = val);
              selectedCity = null; // Reset city when zone changes
            }, selectedZone),

            // Dynamic city dropdown based on selected zone
            if (selectedZone != null)
              _buildDropdown(
                "Select City",
                selectedZone == "zone1"
                    ? ["City A1", "City A2"]
                    : ["City B1", "City B2"],
                (val) => setState(() => selectedCity = val),
                selectedCity,
              ),

            _buildDropdown(
                "Select Division",
                ["Medcutis", "Cosmocutis"],
                (val) => setState(() => selectedDivision = val),
                selectedDivision),

            _buildTextField(assignedFirmController, "Assigned to (Firm Name)"),
            _buildTextField(
                assignedFirmEmailController, "Email of Assigned Firm"),
            _buildTextField(assignClientsController, "Assign Clients"),

            // Attachments section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.attach_file_outlined,
                        color:  Color.fromRGBO(81, 120, 237, 1), size: 28),
                    onPressed: () {
                      // Future: Attach file logic
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.camera_alt_outlined,
                        color:  Color.fromRGBO(81, 120, 237, 1), size: 28),
                    onPressed: () {
                      // Future: Camera capture logic
                    },
                  ),
                ],
              ),
            ),

            // Submit button
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // TODO: Submit logic
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:  Color.fromRGBO(81, 120, 237, 1),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: Text("Submit",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  // Basic reusable text field
  Widget _buildTextField(TextEditingController controller, String label,
      {TextInputType inputType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color:  Color.fromRGBO(81, 120, 237, 1), width: 2),
          ),
        ),
        validator: (value) =>
            value == null || value.isEmpty ? 'Required' : null,
      ),
    );
  }

  // Text field with a clickable icon
  Widget _buildTextFieldWithIcon(TextEditingController controller, String label,
      IconData icon, VoidCallback onIconTap,
      {TextInputType inputType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color:  Color.fromRGBO(81, 120, 237, 1), width: 2),
          ),
          suffixIcon: IconButton(
              icon: Icon(icon, color:  Color.fromRGBO(81, 120, 237, 1)), onPressed: onIconTap),
        ),
        validator: (value) =>
            value == null || value.isEmpty ? 'Required' : null,
      ),
    );
  }

  // Date picker field
  Widget _buildDateField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color:  Color.fromRGBO(81, 120, 237, 1), width: 2),
          ),
          suffixIcon: Icon(Icons.calendar_today, color:  Color.fromRGBO(81, 120, 237, 1)),
        ),
        onTap: () async {
          DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime(2100),
          );
          if (picked != null) {
            controller.text = DateFormat('yyyy-MM-dd').format(picked);
          }
        },
      ),
    );
  }

  // Dropdown field
  Widget _buildDropdown(String label, List<String> items,
      ValueChanged<String?> onChanged, String? currentValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: DropdownButtonFormField<String>(
        value: currentValue,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        items: items
            .map((val) => DropdownMenuItem(value: val, child: Text(val)))
            .toList(),
        onChanged: onChanged,
        validator: (value) => value == null ? 'Required' : null,
      ),
    );
  }
}
