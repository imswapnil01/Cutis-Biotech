import 'package:cutis_biotech/pages/reports/FirmPOB.dart';
import 'package:flutter/material.dart';
import 'ActivityReport.dart';
import 'CallAverageReport.dart';
import 'CallObjectiveReport.dart';
import 'ClientROI.dart';
import 'CombineSummaryReport.dart';
import 'CoverageReport.dart';
import 'DailyWorkReport.dart';
import 'DoctorBusinessReport.dart';
import 'DoctorPreferredDayReport.dart';
import 'DoctosPOB.dart';
import 'EmployeeExpenceReport.dart';
import 'ExpenceReport.dart';
import 'FirmCoverageReport.dart';
import 'FirmDailyCallReport.dart';
import 'HQWiseTargetReport.dart';
import 'HospitalCallReport.dart';
import 'InchargePOB.dart';
import 'MissedCallReport.dart';
import 'MonthlySecondarySalesReport.dart';
import 'POBAchievement.dart';
import 'PaymentCollectionReport.dart';
import 'PrimarySalesReport.dart';
import 'ProductWiseTargetReport.dart';
import 'RCPAReport.dart';
import 'SalarySlip.dart';
import 'SalesAchievement.dart';
import 'TargetReport.dart';
import 'TeamWorkSummaryReport.dart';
import 'YearlySalesTarget.dart';

class Reports extends StatefulWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  int selectedCardIndex = -1;
  final Color primaryGreen = Color.fromRGBO(81, 120, 237, 1); //green

  final List<DashboardItem> reportItems = [
    DashboardItem("My Reports", Icons.assignment, Colors.indigo),
    DashboardItem("Call Reports", Icons.call, Colors.green),
    DashboardItem("Firms Visit Report", Icons.business, Colors.orange),
    DashboardItem("Attendance Report", Icons.access_time, Colors.red),
    DashboardItem("Firms Coverage Report", Icons.map, Colors.purple),
    DashboardItem("Coverage Report", Icons.insights, Colors.teal),
    DashboardItem(
        "Call Objective Report", Icons.track_changes, Colors.cyan),
    DashboardItem(
        "Missed Call Report", Icons.phone_missed, Colors.blueGrey),
    DashboardItem(
        "Doctor POB Reports", Icons.local_hospital, Colors.pink),
    DashboardItem("Firm POB Report", Icons.apartment, Colors.amber),
    DashboardItem(
        "POB Achievement", Icons.emoji_events, Colors.deepPurple),
    DashboardItem("Sales Achievement", Icons.show_chart, Colors.lime),
    DashboardItem(
        "Daily Work Report", Icons.work_history, Colors.brown),
    DashboardItem(
        "Incharge POB Report", Icons.manage_accounts, Colors.blue),
    DashboardItem(
        "Payment Collection Report", Icons.payment, Colors.deepOrange),
    DashboardItem("Yearly Sales Report", Icons.calendar_today,
        Colors.indigoAccent),
    DashboardItem("Doctors Business Report", Icons.business_center,
        Colors.greenAccent),
    DashboardItem("Employee Expense", Icons.wallet, Colors.teal),
    DashboardItem("Client ROI Report", Icons.pie_chart_outline,
        Colors.deepPurpleAccent),
    DashboardItem(
        "Expense Report", Icons.receipt_long, Colors.orangeAccent),
    DashboardItem("Target Report", Icons.flag, Colors.cyan),
    DashboardItem("Salary Slip", Icons.request_page, Colors.blueGrey),
    DashboardItem(
        "Call Average Report", Icons.bar_chart, Colors.lightGreen),
    DashboardItem("RCPA Report", Icons.fact_check, Colors.redAccent),
    DashboardItem(
        "Combine Summary Report", Icons.summarize, Colors.lightBlue),
    DashboardItem("Monthly Secondary Sales Report", Icons.attach_money,
        Colors.deepOrangeAccent),
    DashboardItem("Primary Sales Report", Icons.shopping_cart,
        Colors.purpleAccent),
    DashboardItem(
        "Team Work Summary Report", Icons.group, Colors.indigo),
    DashboardItem(
        "Firm Daily Call Report", Icons.phone_in_talk, Colors.green),
    DashboardItem(
        "Activity Report", Icons.assignment_turned_in, Colors.pink),
    DashboardItem("Hospital Call Report", Icons.local_hospital,
        Colors.cyanAccent),
    DashboardItem("Product Wise Target Report",
        Icons.production_quantity_limits, Colors.tealAccent),
    DashboardItem("Doctor Preferred Day Report", Icons.event_available,
        Colors.orange),
    DashboardItem(
        "HQ Wise Target Report", Icons.location_city, Colors.blue),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reports',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: primaryGreen,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 0.9,
            children: List.generate(reportItems.length, (index) {
              final item = reportItems[index];
              final bool isSelected = selectedCardIndex == index;

              return AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () {
                    setState(() {
                      selectedCardIndex = index;
                    });
                    Future.delayed(Duration(milliseconds: 1000), () {
                      setState(() {
                        selectedCardIndex = -1;
                      });
                    });
                    if (item.title == "My Reports") {
                      Navigator.pushNamed(
                          context, '/myreports'); // Navigate using route name
                    } else if (item.title == "Call Reports") {
                      Navigator.pushNamed(
                          context, '/callreports'); // Navigate using route name
                    } else if (item.title == "Firms Visit Report") {
                      Navigator.pushNamed(context,
                          '/firmvisitreport'); // Navigate using route name
                    } else if (item.title == "Attendance Report") {
                      Navigator.pushNamed(context,
                          '/attendancereport'); // Navigate using route name
                    } else if (item.title == "Firms Coverage Report") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const FirmCoverageReportPage())); // Navigate using route name
                    } else if (item.title == "Coverage Report") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const CoveragereportPage())); // Navigate using route name
                    } else if (item.title == "Call Objective Report") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const CallObjectiveRecordPage())); // Navigate using route name
                    } else if (item.title == "Missed Call Report") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const MissedCallReportPage())); // Navigate using route name
                    } else if (item.title == "Doctor POB Reports") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const DoctorsPOBPage())); // Navigate using route name
                    } else if (item.title == "Firm POB Report") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const FirmsPOBPage())); // Navigate using route name
                    } else if (item.title == "POB Achievement") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const POBAchievementPage())); // Navigate using route name
                    } else if (item.title == "Sales Achievement") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const AchievementReportPage())); // Navigate using route name
                    } else if (item.title == "Incharge POB Report") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const InchargePOB())); // Navigate using route name
                    } else if (item.title == "Daily Work Report") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const DailyWorkRecordPage())); // Navigate using route name
                    } else if (item.title == "Payment Collection Report") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const PaymentCollectionReportPage())); // Navigate using route name
                    } else if (item.title == "Doctors Business Report") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const DoctorBusinessReportPage())); // Navigate using route name
                    } else if (item.title == "Employee Expense") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const EmployeeExpenceReportPage())); // Navigate using route name
                    } else if (item.title == "Client ROI Report") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ClientROIReportPage())); // Navigate using route name
                    } else if (item.title == "Call Average Report") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const CallAverageReportPage())); // Navigate using route name
                    } else if (item.title == "Expense Report") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ExpenceReportPage())); // Navigate using route name
                    } else if (item.title == "Salary Slip") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const SalaryslipPage())); // Navigate using route name
                    } else if (item.title == "Target Report") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const TargetReportPage())); // Navigate using route name
                    } else if (item.title == "RCPA Report") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const RCPAReportPage())); // Navigate using route name
                    } else if (item.title == "Combine Summary Report") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const CombineSummaryReportPage())); // Navigate using route name
                    } else if (item.title == "Monthly Secondary Sales Report") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const MonthlySecondarySalesReportPage())); // Navigate using route name
                    } else if (item.title == "Primary Sales Report") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const PrimarySalesReportPage())); // Navigate using route name
                    } else if (item.title == "Firm Daily Call Report") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const FirmDailyCallReportPage()));
                    } // Navigate using route name
                    else if (item.title == "Team Work Summary Report") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const TeamWorkSummaryReportPage())); // Navigate using route name
                    } else if (item.title == "Activity Report") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ActivityReportPage())); // Navigate using route name
                    } else if (item.title == "Hospital Call Report") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const HospitalCallReportPage())); // Navigate using route name
                    } else if (item.title == "Product Wise Target Report") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ProductWiseTargetReportPage())); // Navigate using route name
                    } else if (item.title == "Doctor Preferred Day Report") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const DoctorPreferredDayReportPage())); // Navigate using route name
                    } else if (item.title == "HQ Wise Target Report") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const HQWiseTargetReportPage())); // Navigate using route name
                    } else if (item.title == "Yearly Sales Report") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const YearlySalesTargetPage())); // Navigate using route name
                    }
                    print("Tapped on ${item.title}");
                    // You can add navigation logic here if you want
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          item.icon,
                          size: 26,
                          color: item.color, // <-- Force color here
                        ),
                        SizedBox(height: 10),
                        Text(
                          item.title,
                          style: TextStyle(
                            color: Colors.black, // <-- ✅ Force black text
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class DashboardItem {
  final String title;
  final IconData icon;
  final Color color;

  DashboardItem(this.title, this.icon, this.color);
}
