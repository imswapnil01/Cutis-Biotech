import 'package:flutter/material.dart';

class HolidaysPage extends StatelessWidget {
  final Map<String, List<Map<String, String>>> holidaysByMonth = {
    "January": [
      {"date": "01 Jan", "occasion": "New Year"},
      {"date": "14 Jan", "occasion": "Makar Sankranti"},
    ],
    "March": [
      {"date": "08 Mar", "occasion": "Holi"},
    ],
    "April": [
      {"date": "14 Apr", "occasion": "Ambedkar Jayanti"},
    ],
    "August": [
      {"date": "15 Aug", "occasion": "Independence Day"},
    ],
    "October": [
      {"date": "02 Oct", "occasion": "Gandhi Jayanti"},
    ],
    "December": [
      {"date": "25 Dec", "occasion": "Christmas"},
    ],
  };

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
    "Holidays",
    style: TextStyle(color: Colors.white),
  ),
  leading: IconButton(
    icon: const Icon(Icons.arrow_back, color: Colors.white),
    onPressed: () => Navigator.pop(context),
  ),
),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: holidaysByMonth.entries.map((entry) {
            final month = entry.key;
            final holidays = entry.value;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Month Heading
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    month,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ),

                // Holiday Cards under the Month
                ...holidays.map((holiday) => Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  margin: EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    leading: Icon(Icons.calendar_today, color:  Color.fromRGBO(81, 120, 237, 1)),
                    title: Text(
                      holiday["occasion"]!,
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    subtitle: Text(
                      holiday["date"]!,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                )),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
