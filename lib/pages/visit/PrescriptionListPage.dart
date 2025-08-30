import 'package:flutter/material.dart';

import 'DrugsPromotedPage.dart';

class PrescriptionListPage extends StatefulWidget {
  final String userName;
  const PrescriptionListPage({required this.userName});

  @override
  State<PrescriptionListPage> createState() => _PrescriptionListPageState();
}

class _PrescriptionListPageState extends State<PrescriptionListPage> {
  bool isEditMode = false;

  List<Map<String, dynamic>> prescriptions = [
    {"name": "AZISKIN 500 MG", "prescribing": false, "top5": false},
    {"name": "BASECORT", "prescribing": false, "top5": false},
    {"name": "BENZOSKIN CRM", "prescribing": false, "top5": false},
    {"name": "CLINTIS GEL", "prescribing": false, "top5": false},
    {"name": "CUTICLOP CRM.", "prescribing": false, "top5": false},
    {"name": "CUTIFLUC-200MG", "prescribing": false, "top5": false},
    {"name": "CUTILIV 10MG", "prescribing": false, "top5": false},
    {"name": "CUTILIV 5MG", "prescribing": false, "top5": false},
    {"name": "DANWASH", "prescribing": false, "top5": false},
    {"name": "DEXPOLO TAB", "prescribing": false, "top5": false},
    {"name": "EBERNEXT", "prescribing": false, "top5": false},
  ];

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
  title: Text(
    "Prescription List of ${widget.userName}",
    style: const TextStyle(color: Colors.white),
  ),
  leading: const BackButton(color: Colors.white),
),

      body: Column(
        children: [
          Container(
            color: Colors.grey[100],
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "These are the drugs prescribed by ${widget.userName}. If you wish to make changes to it, please press the 'Edit' Button and make changes.",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Row(
                  children: [
                    Text("EDIT", style: TextStyle(fontWeight: FontWeight.bold)),
                    Switch(
                      value: isEditMode,
                      onChanged: (val) {
                        setState(() => isEditMode = val);
                      },
                      activeColor:  Color.fromRGBO(81, 120, 237, 1),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            color:  Color.fromRGBO(81, 120, 237, 1),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: const [
                Expanded(child: Text("Name", style: TextStyle(fontWeight: FontWeight.bold))),
                Text("Is Prescribing", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: 16),
                Text("Top 5", style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: prescriptions.length,
              itemBuilder: (context, index) {
                var item = prescriptions[index];
                return ListTile(
                  title: Text(item["name"]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Switch(
                        value: item["prescribing"],
                        onChanged: isEditMode
                            ? (val) => setState(() => item["prescribing"] = val)
                            : null,
                        activeColor:  Color.fromRGBO(81, 120, 237, 1),
                      ),
                      Checkbox(
                        value: item["top5"],
                        onChanged: isEditMode
                            ? (val) => setState(() => item["top5"] = val)
                            : null,
                        activeColor:  Color.fromRGBO(81, 120, 237, 1),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(12),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DrugsPromotedPage()),//need user name
                );
              },
              child: Text("NEXT"),
              style: ElevatedButton.styleFrom(
                backgroundColor:  Color.fromRGBO(81, 120, 237, 1),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
