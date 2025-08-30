import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendanceReport extends StatefulWidget {
  const AttendanceReport({Key? key}) : super(key: key);

  @override
  _AttendanceReportState createState() => _AttendanceReportState();
}

class _AttendanceReportState extends State<AttendanceReport> {
  String selectedYear = '2024';
  String selectedMonth = 'April';

  final List<String> years = ['2020', '2021', '2022', '2023', '2024', '2025'];
  final List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  final Color primaryGreen =  Color.fromRGBO(81, 120, 237, 1);

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  Map<DateTime, String> attendanceData = {}; // Holds attendance per date

  @override
  void initState() {
    super.initState();
    generateSampleAttendance(int.parse(selectedYear), months.indexOf(selectedMonth) + 1);
  }

  void generateSampleAttendance(int year, int month) {
    final start = DateTime(year, month, 1);
    final end = DateTime(year, month + 1, 0); // Last day of the month

    attendanceData.clear(); // Clear previous data

    for (int i = 1; i <= end.day; i++) {
      DateTime date = DateTime(year, month, i);

      if (date.isAfter(DateTime.now())) {
        attendanceData[date] = '-';
      } else if (date.weekday == DateTime.sunday) {
        attendanceData[date] = 'WeekOff';
      } else if (i % 10 == 0) {
        attendanceData[date] = 'Holiday';
      } else if (i % 6 == 0) {
        attendanceData[date] = 'Leave';
      } else if (i % 4 == 0) {
        attendanceData[date] = 'Absent';
      } else {
        attendanceData[date] = 'Present';
      }
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Present':
        return  Color.fromRGBO(81, 120, 237, 1);
      case 'Absent':
        return Colors.red;
      case 'Leave':
        return Colors.yellow;
      case 'WeekOff':
        return Colors.black;
      case 'Holiday':
        return Colors.purple;
      default:
        return Colors.grey; // Future dates / unknown status
    }
  }

  void _showAttendanceDialog(DateTime date) {
    final today = DateTime.now();
    String status;

    if (date.isAfter(today)) {
      status = '-';
    } else {
      status = attendanceData[DateTime(date.year, date.month, date.day)] ?? '-';
    }

    String loginTime = status == 'Present' ? '09:00 AM' : '-';
    String logoutTime = status == 'Present' ? '06:00 PM' : '-';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: const Text('Attendance Detail', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Status: $status', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              Text('Logged In: $loginTime', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              Text('Logged Out: $logoutTime', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 16),
              const Divider(),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK', style: TextStyle(color: primaryGreen)),
            ),
          ],
        );
      },
    );
  }

  Widget buildColorLegend(String label, Color color) {
    return Row(
      children: [
        Container(width: 14, height: 14, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  title: const Text(
    'Attendance Report',
    style: TextStyle(color: Colors.white, fontSize: 20),
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  leading: IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () => Navigator.pop(context),
  ),
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
),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Year Dropdown
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: primaryGreen),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButton<String>(
                  value: selectedYear,
                  isExpanded: true,
                  underline: const SizedBox(),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                  items: years.map((year) {
                    return DropdownMenuItem<String>(
                      value: year,
                      child: Text(year),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedYear = value!;
                      generateSampleAttendance(int.parse(selectedYear), months.indexOf(selectedMonth) + 1);
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              // Month Dropdown
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: primaryGreen),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButton<String>(
                  value: selectedMonth,
                  isExpanded: true,
                  underline: const SizedBox(),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                  items: months.map((month) {
                    return DropdownMenuItem<String>(
                      value: month,
                      child: Text(month),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedMonth = value!;
                      int monthIndex = months.indexOf(selectedMonth) + 1;
                      _focusedDay = DateTime(int.parse(selectedYear), monthIndex, 1);
                      generateSampleAttendance(int.parse(selectedYear), monthIndex);
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              // Table Calendar
              TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2100, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                calendarFormat: _calendarFormat,
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                  _showAttendanceDialog(selectedDay);
                },
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, day, events) {
                    final normalizedDay = DateTime(day.year, day.month, day.day);
                    final today = DateTime.now();
                    String? status;

                    if (day.isAfter(today)) {
                      status = '-';
                    } else {
                      status = attendanceData[normalizedDay];
                    }

                    if (status != null) {
                      return Positioned(
                        bottom: 1,
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: getStatusColor(status),
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryGreen.withOpacity(0.2),
                  ),
                  selectedDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: primaryGreen, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Color Codes:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              buildColorLegend('Present',  Color.fromRGBO(81, 120, 237, 1)),
              buildColorLegend('Absent', Colors.red),
              buildColorLegend('Leave', Colors.yellow),
              buildColorLegend('Week Off', Colors.black),
              buildColorLegend('Holiday', Colors.purple),
              buildColorLegend('Future Dates', Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
