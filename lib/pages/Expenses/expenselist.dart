import 'package:flutter/material.dart';

import 'addexpense.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({Key? key}) : super(key: key);

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  String selectedYear = '2025';
  String selectedMonth = 'April';
  String selectedEmployee = 'All';

  final List<String> years = ['2023', '2024', '2025'];
  final List<String> months = ['January', 'February', 'March', 'April'];
  final List<String> employees = ['All'];

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
  title: Text("Expenses", style: TextStyle(color: Colors.white)),
),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: _dropdown(years, selectedYear, (val) => setState(() => selectedYear = val!))),
                    SizedBox(width: 8),
                    Expanded(child: _dropdown(months, selectedMonth, (val) => setState(() => selectedMonth = val!))),
                  ],
                ),
                SizedBox(height: 8),
                _dropdown(employees, selectedEmployee, (val) => setState(() => selectedEmployee = val!)),
              ],
            ),
          ),
          _tableHeader(),
          Expanded(child: _expenseList()),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 10,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('0.0\nClaimed Amount', style: TextStyle(color: Colors.red, fontSize: 14)),
              FloatingActionButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AddExpensePage()),
                  );

                  if (result != null) {
                    // TODO: Add logic to add this to the list (or send to backend)
                    print("Added Expense: $result");
                  }
                },
                backgroundColor:  Color.fromRGBO(81, 120, 237, 1),
                child: Icon(Icons.add,color: Colors.white,),
                mini: true,
              ),

              Text('0.0\nApproved Amount', style: TextStyle(color:  Color.fromRGBO(81, 120, 237, 1), fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dropdown(List<String> items, String value, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      isDense: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color:  Color.fromRGBO(81, 120, 237, 1)),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      icon: Icon(Icons.arrow_drop_down),
      onChanged: onChanged,
      items: items.map((val) => DropdownMenuItem<String>(value: val, child: Text(val))).toList(),
    );
  }

  Widget _tableHeader() {
    return Container(
      color: Colors.grey[100],
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: const [
          Expanded(flex: 2, child: Text("Head", style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 3, child: Text("Date", style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 2, child: Text("₹Claimed", style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 2, child: Text("₹Amount", style: TextStyle(fontWeight: FontWeight.bold))),
          SizedBox(width: 24), // For the menu icon
        ],
      ),
    );
  }

  Widget _expenseList() {
    final sampleData = [
      {"head": "DA", "date": "23-04-2025", "claimed": "0", "amount": "0"},
      {"head": "TA", "date": "22-04-2025", "claimed": "0", "amount": "0"},
      {"head": "DA", "date": "21-04-2025", "claimed": "0", "amount": "0"},
    ];

    return ListView.builder(
      itemCount: sampleData.length,
      itemBuilder: (context, index) {
        final item = sampleData[index];
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
          ),
          child: Row(
            children: [
              Expanded(flex: 2, child: Text(item['head']!)),
              Expanded(flex: 3, child: Text(item['date']!)),
              Expanded(flex: 2, child: Text(item['claimed']!)),
              Expanded(
                flex: 2,
                child: Text(item['amount']!, style: TextStyle(color: Colors.red)),
              ),
              GestureDetector(
                onTap: () => showExpenseDetailsDialog(context, item),
                child: Icon(Icons.more_vert, size: 18),
              ),

            ],
          ),
        );
      },
    );
  }
}
void showExpenseDetailsDialog(BuildContext context, Map<String, String> item) {
  showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text("Expense Details", style: TextStyle(color:  Color.fromRGBO(81, 120, 237, 1), fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _infoRow("Head", item['head'] ?? ''),
            _infoRow("Status", "Unapproved", color: Colors.red),
            _infoRow("Date", item['date'] ?? ''),
            _infoRow("Amount", "₹${item['amount'] ?? '0'}"),
            _infoRow("Admin Remark", "No remark"),
            _infoRow("Claim Reason", "General Claim"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("Close", style: TextStyle(color: Colors.grey[700])),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:  Color.fromRGBO(81, 120, 237, 1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              // Optional: Trigger edit functionality here
              print("Edit button tapped");
            },
            child: Text("Edit"),
          ),
        ],
      );
    },
  );
}


Widget _infoRow(String label, String value, {Color? color}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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
