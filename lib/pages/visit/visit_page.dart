import 'package:cutis_biotech/pages/visit/visit_form.dart';
import 'package:flutter/material.dart';

class VisitPage extends StatefulWidget {
  const VisitPage({super.key});

  @override
  State<VisitPage> createState() => _VisitPageState();
}

class _VisitPageState extends State<VisitPage> with SingleTickerProviderStateMixin {
  int selectedType = 0; // 0 = Doctors, 1 = Firms
  late TabController _tabController;

  Color visitBlue = const Color.fromRGBO(88, 125, 237, 1);
  Color visitBlueDark = const Color.fromRGBO(81, 120, 237, 1);
  Color visitBlueLight = const Color.fromRGBO(114, 142, 242, 1);
  Color visitRed = Colors.red;
  final primaryBlue = const Color(0xFF587DED);

  // Dummy data
  final doctorVisits = [
    {'name': 'HARSHAL PATIL', 'location': 'Amravati', 'status': 'Open'},
    {'name': 'SANDEEP RATHOD', 'location': 'Wardha', 'status': 'Open'},
    {'name': 'SHANTANU BAVASKAR', 'location': 'Nagpur', 'status': 'Closed'},
  ];

  final firmVisits = [
    {'company_name': 'Alpha Medics', 'address': 'Mumbai', 'is_visit_complete_firm': '0'},
    {'company_name': 'Beta Pharma', 'address': 'Pune', 'is_visit_complete_firm': '1'},
    {'company_name': 'Gamma Labs', 'address': 'Nagpur', 'is_visit_complete_firm': '0'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Visits", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [visitBlue, visitBlueDark, visitBlueLight],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                _buildToggle("DOCTORS", 0),
                _buildToggle("FIRMS", 1),
              ],
            ),
          ),

          // Unified TabBar for both types
          TabBar(
            controller: _tabController,
            labelColor: primaryBlue,
            unselectedLabelColor: Colors.grey,
            indicatorColor: primaryBlue,
            tabs: const [Tab(text: 'TODAY'), Tab(text: 'ALL')],
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                selectedType == 0
                    ? _buildDoctorVisitList(today: true)
                    : _buildFirmVisitList(today: true),
                selectedType == 0
                    ? _buildDoctorVisitList(today: false)
                    : _buildFirmVisitList(today: false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggle(String title, int index) {
    bool selected = selectedType == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedType = index),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected ? primaryBlue : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: selected ? Colors.white : primaryBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorVisitList({required bool today}) {
    final filtered = today
        ? doctorVisits.where((e) => e['status'] == 'Open').toList()
        : doctorVisits;
    if (filtered.isEmpty) return const Center(child: Text("No doctor visit data."));

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final visit = filtered[index];
        final name = visit['name']!;
        final location = visit['location']!;
        final isCompleted = visit['status'] == 'Closed';
        final initial = name[0].toUpperCase();

        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: visitBlueLight,
              child: Text(initial, style: const TextStyle(color: Colors.white)),
            ),
            title: Text(name, overflow: TextOverflow.ellipsis),
            subtitle: Row(
              children: [
                const Icon(Icons.location_on, size: 14, color: Colors.grey),
                Flexible(child: Text(" $location", overflow: TextOverflow.ellipsis)),
              ],
            ),
            trailing: Text(
              isCompleted ? 'Completed' : 'Pending',
              style: TextStyle(
                color: isCompleted ? visitBlue : visitRed,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              if (isCompleted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("This doctor visit is already completed.")),
                );
              } else {
                showVisitPopup(context, name);
              }
            },
          ),
        );
      },
    );
  }


  Widget _buildFirmVisitList({required bool today}) {
    final filtered = today
        ? firmVisits.where((f) => f['is_visit_complete_firm'] == '0').toList()
        : firmVisits;
    if (filtered.isEmpty) return const Center(child: Text("No firm visit data."));

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final firm = filtered[index];
        final name = firm['company_name']!;
        final location = firm['address']!;
        final isCompleted = firm['is_visit_complete_firm'] == '1';
        final initial = name[0];

        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: visitBlueLight,
              child: Text(initial, style: const TextStyle(color: Colors.white)),
            ),
            title: Text(name, overflow: TextOverflow.ellipsis),
            subtitle: Row(
              children: [
                const Icon(Icons.location_on, size: 14, color: Colors.grey),
                Text(" $location"),
              ],
            ),
            trailing: Text(
              isCompleted ? 'Completed' : 'Pending',
              style: TextStyle(
                color: isCompleted ? visitBlue : visitRed,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              if (isCompleted) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("This firm visit is already completed.")));
              } else {
                showVisitPopup(context, name);
              }
            },
          ),
        );
      },
    );
  }
  void showVisitPopup(BuildContext context, String doctorName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF587DED)),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => VisitFormPage()));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Going to visit $doctorName")),
                    );
                  },
                  child: const Text("Go to Visit", style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Skipped visit for $doctorName")),
                    );
                  },
                  child: const Text("Skip Visit", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

