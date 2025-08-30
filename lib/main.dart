import 'package:cutis_biotech/pages/Expenses/expenselist.dart';
import 'package:cutis_biotech/pages/business/DoctorBusinessPlanning.dart';
import 'package:cutis_biotech/pages/business/SalesPlanning.dart';
import 'package:cutis_biotech/pages/business/business_dashboard.dart';
import 'package:cutis_biotech/pages/business/sales.dart';
import 'package:cutis_biotech/pages/business/sub_ordinates.dart';
import 'package:cutis_biotech/pages/calender/TourPlanCalendarPage.dart';
import 'package:cutis_biotech/pages/doctors/doctors_list.dart';
import 'package:cutis_biotech/pages/extra/OrderSummary.dart';
import 'package:cutis_biotech/pages/extra/celebration.dart';
import 'package:cutis_biotech/pages/extra/file.dart';
import 'package:cutis_biotech/pages/extra/holidays.dart';
import 'package:cutis_biotech/pages/extra/leaves.dart';
import 'package:cutis_biotech/pages/firms/firm_page.dart';
import 'package:cutis_biotech/pages/extra/orderdetails.dart';
import 'package:cutis_biotech/pages/presentation/PresentationPage.dart';
import 'package:cutis_biotech/pages/reports/AttendanceCalenderReport.dart';
import 'package:cutis_biotech/pages/reports/CallReport.dart';
import 'package:cutis_biotech/pages/reports/FirmVisitReport.dart';
import 'package:cutis_biotech/pages/reports/myreports.dart';
import 'package:cutis_biotech/pages/reports/reports.dart';
import 'package:cutis_biotech/pages/visit/visit_page.dart';
import 'package:flutter/material.dart';
import 'package:cutis_biotech/login_page.dart';
import 'package:cutis_biotech/dashboard.dart';
import 'Maneger_page.dart';
import 'book_order_page.dart';
import 'package:cutis_biotech/pages/journey_plan.dart';
import 'package:cutis_biotech/pages/leave_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cutis Biotech',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {

        '/': (context) => const LoginPage(),

        '/dashboard': (context) => const Dashboard(),
        '/visit': (context) => const JourneyPlanPage(),
        '/bookOrder': (context) => BookOrderPage(),
        '/leave': (context) => LeavePage(),
        '/manager': (context) => const ManagerPage(),
        '/visits': (context) => VisitPage(),
        '/doctors':(context) => DoctorsPage(),
        '/firms':(context) => FirmsPage(),
        '/tourplancalendar':(context) =>TourPlanCalendarPage(),
        '/salesreport':(context) =>SalesReportPage(),
        '/monthlysummary':(context) =>MonthlySummaryPage(),
        '/files':(context) =>const FilesPage(),
        '/expenses':(context) => ExpensesPage(),
        '/leaves':(context) => const LeavesPage(),
        '/holidays':(context) => HolidaysPage(),
        '/celebrations':(context) => CelebrationPage(),
        '/presentation':(context) => PresentationPage(),
        '/reports':(context) => const Reports(),
        '/business':(context) =>  const BusinessPage(),
        '/sales':(context) =>  const SalesPage(),
        '/doctorsbusinessplanning':(context) =>  const DoctorBusinessPlanningPage(),
        '/salesplanning':(contex) => const SalesPlanning(),
        '/businesssalesplanningpage':(contex) => const BusinessSalesPlanningPage(),
        '/myreports':(contex) => const MyReportsPage(),
        '/callreports':(contex) => const CallRecordPage(),
        '/firmvisitreport':(contex) => const Firmvisitreport(),
        '/attendancereport':(contex) => const AttendanceReport(),

      },
    );
  }
}
