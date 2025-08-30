import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LeaveFormPage extends StatefulWidget {
  @override
  _LeaveFormPageState createState() => _LeaveFormPageState();
}

class _LeaveFormPageState extends State<LeaveFormPage> {
  String? selectedLeaveType;
  DateTime? fromDate;
  DateTime? toDate;
  TextEditingController reasonController = TextEditingController();
  String leavePaymentType = "Paid"; // "Paid" or "Unpaid"

  final List<String> leaveTypes = ["Sick Leave", "Casual Leave", "Annual Leave"];

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    DateTime initialDate = isFromDate ? (fromDate ?? DateTime.now()) : (toDate ?? DateTime.now());
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        if (isFromDate) {
          fromDate = picked;
          if (toDate != null && fromDate!.isAfter(toDate!)) {
            toDate = null;
          }
        } else {
          toDate = picked;
        }
      });
    }
  }

  void submitLeaveRequest() {
    if (selectedLeaveType == null || fromDate == null || toDate == null || reasonController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in all fields!")),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Leave Request Submitted Successfully!")),
    );

    setState(() {
      selectedLeaveType = null;
      fromDate = null;
      toDate = null;
      leavePaymentType = "Paid";
      reasonController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
  title: const Text(
    "Apply Leave",
    style: TextStyle(color: Colors.white),
  ),
  leading: IconButton(
    icon: const Icon(Icons.arrow_back, color: Colors.white),
    onPressed: () => Navigator.pop(context),
  ),
),

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Paid / Unpaid Toggle
              Text("Leave Category", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Row(
                children: ["Paid", "Unpaid"].map((type) {
                  final isSelected = leavePaymentType == type;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => leavePaymentType = type),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: isSelected ?  Color.fromRGBO(81, 120, 237, 1) : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          type,
                          style: TextStyle(color: isSelected ? Colors.white : Colors.black87),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              SizedBox(height: 24),

              // Leave Type Dropdown
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Leave Type",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color:  Color.fromRGBO(81, 120, 237, 1)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                value: selectedLeaveType,
                isExpanded: true,
                items: leaveTypes.map((type) {
                  return DropdownMenuItem(value: type, child: Text(type));
                }).toList(),
                onChanged: (val) => setState(() => selectedLeaveType = val),
              ),

              SizedBox(height: 20),

              // From Date
              Text("From Date", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              _dateTile(fromDate, () => _selectDate(context, true)),

              SizedBox(height: 20),

              // To Date
              Text("To Date", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              _dateTile(toDate, () => _selectDate(context, false)),

              SizedBox(height: 20),

              // Reason
              TextFormField(
                controller: reasonController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Reason",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color:  Color.fromRGBO(81, 120, 237, 1)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              SizedBox(height: 30),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: submitLeaveRequest,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  Color.fromRGBO(81, 120, 237, 1),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text("Apply for Leave", style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _dateTile(DateTime? date, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              date == null ? "Select Date" : DateFormat('yyyy-MM-dd').format(date),
              style: TextStyle(fontSize: 15),
            ),
            Icon(Icons.calendar_today, size: 18, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
