import 'package:flutter/material.dart';

class ManagerPage extends StatefulWidget {
  const ManagerPage({super.key});

  @override
  _ManagerPageState createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage> {
  List<Map<String, dynamic>> mrRequests = [
    {"mrName": "ABC", "request": "Leave Request", "status": "Pending"},
    {"mrName": "XYZ", "request": "Order Approval", "status": "Pending"},
    {"mrName": "PQR", "request": "Meeting Request", "status": "Pending"},
  ];

  final List<String> mrList = ["ABC", "XYZ", "PQR", "LMN", "DEF"];
  String? selectedMR;
  String? assignedWork;

  void approveRequest(int index) {
    setState(() {
      mrRequests[index]["status"] = "Approved";
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${mrRequests[index]["mrName"]}'s request approved!")),
    );
  }

  void rejectRequest(int index) {
    setState(() {
      mrRequests[index]["status"] = "Rejected";
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${mrRequests[index]["mrName"]}'s request rejected!")),
    );
  }

  void assignWork() {
    if (selectedMR == null || assignedWork == null || assignedWork!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select an MR and enter the work!")),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Work assigned to $selectedMR successfully!")),
    );

    setState(() {
      selectedMR = null;
      assignedWork = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manager Panel", style: TextStyle(color: Colors.white)),
        backgroundColor:  Color.fromRGBO(81, 120, 237, 1),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // White back arrow
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SECTION 1: MR REQUESTS
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("MR Requests", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    mrRequests.isEmpty
                        ? Center(child: Text("No requests available"))
                        : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: mrRequests.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("MR: ${mrRequests[index]["mrName"]}",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                Text("Request: ${mrRequests[index]["request"]}"),
                                Text("Status: ${mrRequests[index]["status"]}",
                                    style: TextStyle(
                                      color: mrRequests[index]["status"] == "Pending"
                                          ? Colors.orange
                                          : (mrRequests[index]["status"] == "Approved"
                                          ?  Color.fromRGBO(81, 120, 237, 1)
                                          : Colors.red),
                                      fontWeight: FontWeight.bold,
                                    )),
                                SizedBox(height: 10),
                                if (mrRequests[index]["status"] == "Pending") ...[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () => approveRequest(index),
                                        style: ElevatedButton.styleFrom(backgroundColor:  Color.fromRGBO(81, 120, 237, 1)),
                                        child: Text("Approve", style: TextStyle(color: Colors.white)),
                                      ),
                                      ElevatedButton(
                                        onPressed: () => rejectRequest(index),
                                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                        child: Text("Reject", style: TextStyle(color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // SECTION 2: ASSIGN WORK
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Assign Work", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: selectedMR,
                      items: mrList.map((mr) {
                        return DropdownMenuItem(value: mr, child: Text(mr));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedMR = value;
                        });
                      },
                      decoration: InputDecoration(border: UnderlineInputBorder(), hintText: "Select MR"),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      onChanged: (value) {
                        assignedWork = value;
                      },
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: "Enter work details",
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: ElevatedButton(
                        onPressed: assignWork,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:  Color.fromRGBO(81, 120, 237, 1),
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        ),
                        child: Text("Assign Work", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
