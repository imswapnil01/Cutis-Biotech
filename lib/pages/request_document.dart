import 'package:cutis_biotech/pages/request_document_form.dart';
import 'package:flutter/material.dart';

class RequestDocumentPage extends StatefulWidget {
  @override
  _RequestDocumentPageState createState() => _RequestDocumentPageState();
}

class _RequestDocumentPageState extends State<RequestDocumentPage> {
  List<Map<String, dynamic>> documentRequests = [
    {
      'title': 'Salary Slip - March 2024',
      'date': '2024-03-25',
      'status': 'Pending',
    },
    {
      'title': 'Experience Letter',
      'date': '2024-02-10',
      'status': 'Approved',
    },
    {
      'title': 'Offer Letter',
      'date': '2023-12-15',
      'status': 'Rejected',
    },
  ]; // Dummy data for history

  void _requestNewDocument() {
    // Placeholder for future request form functionality
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RequestDocumentFormPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: const Text(
    "Request Documents",
    style: TextStyle(color: Colors.white),
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  backgroundColor: Colors.transparent,
  elevation: 0,
  flexibleSpace: Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color.fromRGBO(88, 125, 237, 1),  // rgba(88, 125, 237, 1)
          Color.fromRGBO(81, 120, 237, 1),  // rgba(81, 120, 237, 1)
          Color.fromRGBO(114, 142, 242, 1), // rgba(114, 142, 242, 1)
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    ),
  ),
),

      body: Padding(
        padding: EdgeInsets.all(10),
        child: documentRequests.isEmpty
            ? Center(child: Text("No Document Requests Found"))
            : ListView.builder(
          itemCount: documentRequests.length,
          itemBuilder: (context, index) {
            return DocumentRequestCard(request: documentRequests[index]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _requestNewDocument,
        backgroundColor:  Color.fromRGBO(81, 120, 237, 1),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class DocumentRequestCard extends StatelessWidget {
  final Map<String, dynamic> request;

  DocumentRequestCard({required this.request});

  Color _getStatusColor() {
    switch (request['status']) {
      case 'Approved':
        return  Color.fromRGBO(81, 120, 237, 1);
      case 'Rejected':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(request['title'],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 5),
            Text("Date Requested: ${request['date']}"),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getStatusColor().withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    request['status'],
                    style: TextStyle(color: _getStatusColor(), fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
