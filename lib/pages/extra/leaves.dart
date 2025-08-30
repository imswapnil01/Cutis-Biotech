import 'package:flutter/material.dart';

import '../leave_form.dart';

class LeavesPage extends StatelessWidget {
  const LeavesPage({super.key});

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
  leading: IconButton(
    icon: Icon(Icons.arrow_back, color: Colors.white),
    onPressed: () => Navigator.pop(context),
  ),
  title: Text(
    'Leaves',
    style: TextStyle(color: Colors.white),
  ),
),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _leaveCounter('Paid Leave', '15/15'),
            SizedBox(height: 12),
            _leaveCounter('Unpaid Leave', '365/365'),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:  Color.fromRGBO(81, 120, 237, 1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  // Navigate to apply leave form here
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LeaveFormPage()),);

                },
                child: Text("Apply Leave", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
            SizedBox(height: 24),
            Text("Leave History", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Expanded(child: _leaveHistoryList(context)),
          ],
        ),
      ),
    );
  }

  Widget _leaveCounter(String label, String count) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            Text(count, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color:  Color.fromRGBO(81, 120, 237, 1))),
          ],
        ),
      ),
    );
  }

  Widget _leaveHistoryList(BuildContext context) {
    final sampleData = [
      {
        "type": "Paid Leave",
        "from": "10-04-2025",
        "to": "12-04-2025",
        "status": "Pending",
        "reason": "Family trip"
      },
      {
        "type": "Unpaid Leave",
        "from": "01-03-2025",
        "to": "03-03-2025",
        "status": "Approved",
        "reason": "Medical"
      },
    ];

    return ListView.builder(
      itemCount: sampleData.length,
      itemBuilder: (context, index) {
        final item = sampleData[index];
        return GestureDetector(
          onTap: () => _showLeaveDetailDialog(context, item),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: EdgeInsets.only(bottom: 12),
            elevation: 3,
            child: ListTile(
              title: Text(item['type'] ?? ''),
              subtitle: Text("${item['from']} to ${item['to']}"),
              trailing: Text(
                item['status']!,
                style: TextStyle(
                  color: item['status'] == 'Approved' ?  Color.fromRGBO(81, 120, 237, 1) : Colors.orange,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showLeaveDetailDialog(BuildContext context, Map<String, String> item) {
    final isPending = item['status'] == 'Pending';
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text("Leave Details", style: TextStyle(fontWeight: FontWeight.bold, color:  Color.fromRGBO(81, 120, 237, 1))),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _detailRow("Type", item['type']!),
            _detailRow("From", item['from']!),
            _detailRow("To", item['to']!),
            _detailRow("Status", item['status']!, color: isPending ? Colors.orange :  Color.fromRGBO(81, 120, 237, 1)),
            _detailRow("Reason", item['reason']!),
          ],
        ),
        actions: [
          if (isPending)
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Cancel functionality here
              },
              child: Text("Cancel Leave", style: TextStyle(color: Colors.red)),
            ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close", style: TextStyle(color: Colors.grey[700])),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text("$label: ", style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: color ?? Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
