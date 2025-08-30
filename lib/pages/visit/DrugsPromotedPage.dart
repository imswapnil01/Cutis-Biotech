import 'package:flutter/material.dart';

class DrugsPromotedPage extends StatelessWidget {
  final List<String> drugList = [
    'AZISKIN 500 MG',
    'BASECORT',
    'BENZOSKIN CRM',
    'CLINTIS GEL',
    'CUTICLOP CRM.',
    'CUTIFLUC–200MG',
    'CUTILIV 10MG',
    'CUTILIV 5MG',
    'DANWASH',
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
          Color.fromRGBO(88, 125, 237, 1),  // #587DED
          Color.fromRGBO(81, 120, 237, 1),  // #5178ED
          Color.fromRGBO(114, 142, 242, 1), // #728EF2
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    ),
  ),
  foregroundColor: Colors.white,
  title: const Text('Drugs Promoted during this call'),
),

      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: drugList.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  return DrugRow(drugName: drugList[index]);
                },
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Do form validation or data saving here

                      // After successful submission, navigate and clear all previous screens
                      Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => false);


                    },
                    child: const Text("SUBMIT", style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  Color.fromRGBO(81, 120, 237, 1), // use your constant green color
                    ),
                  )
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () {
                    // Edit or additional action
                  },
                  icon: const Icon(Icons.edit, color: Colors.black),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DrugRow extends StatefulWidget {
  final String drugName;

  const DrugRow({required this.drugName, super.key});

  @override
  State<DrugRow> createState() => _DrugRowState();
}

class _DrugRowState extends State<DrugRow> {
  bool isPromoted = false;
  final TextEditingController qtyController = TextEditingController();

  @override
  void dispose() {
    qtyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(widget.drugName,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        ),
        Expanded(
          flex: 2,
          child: Checkbox(
            value: isPromoted,
            onChanged: (val) {
              setState(() {
                isPromoted = val!;
              });
            },
            activeColor:  Color.fromRGBO(81, 120, 237, 1), // ✅ green checkbox on select
          ),
        ),
        Expanded(
          flex: 3,
          child: TextField(
            controller: qtyController,
            decoration: const InputDecoration(
              hintText: 'Sample QTY',
              isDense: true,
              border: UnderlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }
}
