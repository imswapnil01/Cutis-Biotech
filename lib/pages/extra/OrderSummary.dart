import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class MonthlySummaryPage extends StatefulWidget {
  @override
  _MonthlySummaryPageState createState() => _MonthlySummaryPageState();
}

class _MonthlySummaryPageState extends State<MonthlySummaryPage> {
  // Dropdown selections
  String selectedView = 'Monthly';
  String selectedYear = '2025';
  String selectedEmployee = 'All';

  // Dropdown options
  final List<String> views = ['Monthly', 'Yearly'];
  final List<String> years = ['2023', '2024', '2025'];
  final List<String> employees = ['All'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilters(),
            SizedBox(height: 24),
            _sectionTitle('Visit Details'),
            _visitCards(),
            SizedBox(height: 24),
            _sectionTitle('Call Average'),
            _callAverageCharts(),
            SizedBox(height: 24),
            _sectionTitle('POB'),
            _pobSection(),
            SizedBox(height: 24),
            _sectionTitle('Tour Program Status'),
            Text("Pending / Submitted", style: TextStyle(fontSize: 16, color: Colors.black54)),
          ],
        ),
      ),
    );
  }

  /// App bar with back button and title
 AppBar _buildAppBar() {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    flexibleSpace:  Container(
      decoration: BoxDecoration(
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
      icon: const Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () => Navigator.pop(context),
    ),
    title: const Text(
      "Monthly Summary",
      style: TextStyle(color: Colors.white),
    ),
  );
}


  /// Top filter dropdowns: View, Year, Employee
  Widget _buildFilters() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _dropdown(views, selectedView, 'View', (val) => setState(() => selectedView = val!))),
            SizedBox(width: 8),
            Expanded(child: _dropdown(years, selectedYear, 'Year', (val) => setState(() => selectedYear = val!))),
          ],
        ),
        SizedBox(height: 12),
        _dropdown(employees, selectedEmployee, 'Employee', (val) => setState(() => selectedEmployee = val!)),
      ],
    );
  }

  /// Section title
  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  /// Reusable dropdown widget
  Widget _dropdown(List<String> items, String value, String label, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      isDense: true,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
      icon: Icon(Icons.arrow_drop_down),
      onChanged: onChanged,
      items: items.map((val) => DropdownMenuItem(value: val, child: Text(val))).toList(),
    );
  }

  /// Grid of visit info cards
  Widget _visitCards() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _infoCard('0 / 243', 'Visited / Missed\nDoctor'),
        _infoCard('0', 'Total Visited\nDoctor'),
        _infoCard('0 / 1', 'Visited / Missed\n(Chem / Stk)'),
        _infoCard('0', 'Total Visited\nChem / Stk'),
        _infoCard('0', 'Doctor Calls'),
        _infoCard('0', 'Chem / Stk Calls'),
        _infoCard('0 / 0', 'Visited / Missed\nHospital'),
        _infoCard('0', 'Total Visited\nHospital'),
        _infoCard('0', 'Hospital Calls', isFullWidth: true),
      ],
    );
  }

  /// Single card displaying top and bottom text
  Widget _infoCard(String topText, String bottomText, {bool isFullWidth = false}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double cardWidth = isFullWidth ? double.infinity : (constraints.maxWidth / 2) - 12;

        return SizedBox(
          width: cardWidth,
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    topText,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  _highlightVisitedText(bottomText),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Highlights the word "Visited" in green
  Widget _highlightVisitedText(String text) {
    final parts = text.split('Visited');

    if (parts.length < 2) {
      return Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
      );
    }

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(text: parts[0], style: TextStyle(fontSize: 14, color: Colors.grey[700])),
          TextSpan(text: 'Visited', style: TextStyle(fontSize: 14, color: Colors.grey[700])),
          TextSpan(text: parts[1], style: TextStyle(fontSize: 14, color: Colors.grey[700])),
        ],
      ),
    );
  }


  /// Row of pie charts for Call Average
  Widget _callAverageCharts() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _pieChart(title: 'Doctor', percentage: 10),
          SizedBox(width: 12),
          _pieChart(title: 'Chem / Stk', percentage: 20),
          SizedBox(width: 12),
          _pieChart(title: 'Hospitals', percentage: 0),
        ],
      ),
    );
  }

  /// Pie chart widget using pie_chart package
  Widget _pieChart({required String title, required double percentage}) {
    final dataMap = {
      "Completed": percentage,
      "Remaining": 100 - percentage,
    };
    final colorList = [ Color.fromRGBO(81, 120, 237, 1), Colors.grey.shade300];

    return Container(
      width: 130,
      height: 130,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
            dataMap: dataMap,
            chartType: ChartType.ring,
            baseChartColor: Colors.grey[300]!,
            chartValuesOptions: ChartValuesOptions(showChartValues: false),
            totalValue: 100,
            legendOptions: LegendOptions(showLegends: false),
            colorList: colorList,
            ringStrokeWidth: 12,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "$percentage%",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color:  Color.fromRGBO(81, 120, 237, 1)),
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.black87),
              ),
            ],
          ),
        ],
      ),
    );
  }


  /// POB (Product Order Booking) section with total and breakdown
  Widget _pobSection() {
    return Column(
      children: [
        _infoCard('₹0', 'Total POB', isFullWidth: true),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _infoCard('₹0', 'Doctor')),
            SizedBox(width: 8),
            Expanded(child: _infoCard('₹0', 'Chem / STK')),
          ],
        ),
      ],
    );
  }
}
