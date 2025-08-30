import 'package:flutter/material.dart';

import 'PrescriptionListPage.dart';

class SelectWorkingWithPage extends StatefulWidget {
  @override
  _SelectWorkingWithPageState createState() => _SelectWorkingWithPageState();
}

class _SelectWorkingWithPageState extends State<SelectWorkingWithPage> {
  List<String> teamMembers = [
    'PRIYA SHARMA',
    'RAHUL KUMAR'
  ];
  Set<String> selected = {};

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
  title: const Text(
    "Select Working With",
    style: TextStyle(color: Colors.white),
  ),
  leading: const BackButton(color: Colors.white),
  actions: const [
    Icon(Icons.search, color: Colors.white),
    SizedBox(width: 16),
  ],
),

      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: teamMembers.length,
              separatorBuilder: (_, __) => Divider(height: 0),
              itemBuilder: (context, index) {
                final name = teamMembers[index];
                return CheckboxListTile(
                  title: Text(name,),
                  value: selected.contains(name),
                  activeColor:  Color.fromRGBO(81, 120, 237, 1),
                  onChanged: (val) {
                    setState(() {
                      val == true ? selected.add(name) : selected.remove(name);
                    });
                  },
                  controlAffinity: ListTileControlAffinity.trailing,
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PrescriptionListPage(userName: "User",)),//need user name
                      );

                    },
                    child: Text("SKIP THIS STEP", style: TextStyle(color: Colors.black)),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.black),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      print("Selected Members: $selected");
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PrescriptionListPage(userName: "User",)),//need user name
                      );// Or route to next screen
                    },
                    child: Text("SUBMIT", style: TextStyle(fontWeight: FontWeight.normal)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  Color.fromRGBO(81, 120, 237, 1),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
