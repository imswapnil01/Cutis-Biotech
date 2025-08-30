import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddDoctorPage extends StatefulWidget {
  @override
  _AddDoctorPageState createState() => _AddDoctorPageState();
}

class _AddDoctorPageState extends State<AddDoctorPage>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  // Basic Info Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController hospitalController = TextEditingController();
  final TextEditingController registrationController = TextEditingController();
  final TextEditingController qualificationController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController anniversaryController = TextEditingController();

  // Address Info
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController addressLineController = TextEditingController();

  // Other Info
  String? gender;
  String? maritalStatus;
  String? visitFrequency;
  String? division;
  String? doctorType;
  String? businessRange;
  String? selectedZone;
  String? selectedCity;
  String? appointmentType;
  String? assignTo;
  String? status;
  String? chemistName;
  String? stockistName;
  String? scheme;
  String? activity;
  String? reportingManager;

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
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
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Add Doctor", style: TextStyle(color: Colors.white)),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: "Basic Info"),
            Tab(text: "Address"),
            Tab(text: "Work Info"),
            Tab(text: "Other"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // logic
              }
            },
            child: const Text("Save", style: TextStyle(color: Colors.white)),
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: TabBarView(
          controller: _tabController,
          children: [
            _styledContainer(child: _buildBasicInfoSection()),
            _styledContainer(child: _buildAddressInfoSection()),
            _styledContainer(child: _buildWorkInfoSection()),
            _styledContainer(child: _buildOtherInfoSection()),
          ],
        ),
      ),
    );
  }

  Widget _styledContainer({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(child: child),
    );
  }

  Widget _buildBasicInfoSection() {
    return Column(
      children: [
        _buildDropdown("Select Prefix", ["Dr.", "Mr.", "Ms."], (_) {}),
        _buildTextField(nameController, "Doctor Name"),
        _buildTextField(hospitalController, "Hospital Name"),
        _buildDropdown("Gender", ["Male", "Female", "Other"],
            (val) => setState(() => gender = val), gender),
        _buildTextField(phoneController, "Mobile",
            inputType: TextInputType.phone),
        _buildTextField(emailController, "Email",
            inputType: TextInputType.emailAddress),
        _buildDateField(dobController, "Date of Birth"),
        _buildDropdown("Marital Status", ["Single", "Married"],
            (val) => setState(() => maritalStatus = val), maritalStatus),
        _buildDateField(anniversaryController, "Anniversary"),
        _buildTextField(qualificationController, "Qualification"),
      ],
    );
  }

  Widget _buildAddressInfoSection() {
    return Column(
      children: [
        _buildDropdown(
            "Select State", ["Maharashtra", "Gujarat", "Delhi"], (_) {}),
        _buildDropdown("Select City", ["Mumbai", "Pune", "Aurangabad"],
            (val) => setState(() => selectedCity = val), selectedCity),
        _buildDropdown("Division", ["Division 1", "Division 2"],
            (val) => setState(() => division = val), division),
        _buildDropdown("Zone", ["Zone 1"],
            (val) => setState(() => selectedZone = val), selectedZone),
        _buildTextField(pincodeController, "Pincode",
            inputType: TextInputType.number),
        // Preferred visit details
        _buildDropdown("Preferred Day 1", ["Mon", "Tue", "Wed"], (_) {}),
        _buildDropdown("Preferred Time 1", ["10 AM", "12 PM", "3 PM"], (_) {}),
        _buildDropdown("Preferred Day 2", ["Thu", "Fri", "Sat"], (_) {}),
        _buildDropdown("Preferred Time 2", ["10 AM", "12 PM", "3 PM"], (_) {}),
        _buildDropdown("Preferred Day 3", ["Thu", "Fri", "Sat"], (_) {}),
        _buildDropdown("Preferred Time 3", ["10 AM", "12 PM", "3 PM"], (_) {}),
        _buildTextField(addressLineController, "Address"),
      ],
    );
  }

  Widget _buildWorkInfoSection() {
    return Column(
      children: [
        _buildDropdown(
            "Speciality", ["Dermatologist", "Cosmetologist"], (_) {}),
        _buildDropdown("Select Type (COP)", ["Prescriber", "Non Prescriber"],
            (val) => setState(() => doctorType = val), doctorType),
        _buildDropdown("Select Category (COP)", ["A", "B", "C"], (_) {}),
        _buildDropdown("Select Appointment", ["Monthly", "Weekly"],
            (val) => setState(() => appointmentType = val), appointmentType),
        _buildDropdown("Business Range", ["0-5000", "5001-10000", "10000+"],
            (val) => setState(() => businessRange = val), businessRange),
        _buildDropdown("Assign To", ["Rep1", "Rep2"],
            (val) => setState(() => assignTo = val), assignTo),
        _buildTextField(registrationController, "Registration Number"),
        _buildDropdown("Immediate Reporting Manager", ["Manager1", "Manager2"],
            (val) => setState(() => reportingManager = val), reportingManager),
        _buildDropdown("Status", ["Active", "Inactive"],
            (val) => setState(() => status = val), status),
      ],
    );
  }

  Widget _buildOtherInfoSection() {
    return Column(
      children: [
        _buildDropdown("Chemist Name", ["Chemist A", "Chemist B"],
            (val) => setState(() => chemistName = val), chemistName),
        _buildDropdown("Stockist Name", ["Stockist A", "Stockist B"],
            (val) => setState(() => stockistName = val), stockistName),
        _buildDropdown("Scheme", ["Scheme 1", "Scheme 2"],
            (val) => setState(() => scheme = val), scheme),
        _buildDropdown("Activity", ["Greeted", "Visited", "Follow Up"],
            (val) => setState(() => activity = val), activity),
      ],
    );
  }

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
        ),
        validator: (value) =>
            value == null || value.isEmpty ? 'Required' : null,
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
            initialDate: DateTime.now().subtract(Duration(days: 365 * 25)),
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

  Widget _buildDropdown(
      String label, List<String> items, ValueChanged<String?> onChanged,
      [String? currentValue]) {
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
