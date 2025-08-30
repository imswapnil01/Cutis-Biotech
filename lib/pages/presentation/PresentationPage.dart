import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PresentationPage extends StatefulWidget {
  @override
  _PresentationPageState createState() => _PresentationPageState();
}

class _PresentationPageState extends State<PresentationPage> {
  List<Map<String, dynamic>> presentations = [
    {
      'doctorName': 'Dr. Suresh',
      'createdDate': DateTime.now(),
      'description': 'Heart Health Awareness Presentation',
    },
    {
      'doctorName': 'Dr. Meera',
      'createdDate': DateTime.now().subtract(Duration(days: 1)),
      'description': 'Diabetes Care Tips for Patients',
    },
  ];

  String searchQuery = "";

  List<Map<String, dynamic>> get filteredPresentations {
    if (searchQuery.isEmpty) {
      return presentations;
    } else {
      return presentations
          .where((item) =>
              item['doctorName']
                  .toString()
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()) ||
              item['description']
                  .toString()
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()))
          .toList();
    }
  }

  void _showOptionsDialog(Map<String, dynamic> presentation) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Wrap(
        children: [
          ListTile(
            leading: Icon(Icons.visibility, color:  Color.fromRGBO(81, 120, 237, 1)),
            title: Text('View Presentation'),
            onTap: () {
              Navigator.pop(context);
              // TODO: Handle view action
            },
          ),
          ListTile(
            leading: Icon(Icons.edit, color:  Color.fromRGBO(81, 120, 237, 1)),
            title: Text('Edit Presentation'),
            onTap: () {
              Navigator.pop(context);
              // TODO: Handle edit action
            },
          ),
          ListTile(
            leading: Icon(Icons.delete, color: Colors.red),
            title: Text('Delete Presentation'),
            onTap: () {
              Navigator.pop(context);
              // apply while dyanamic
              // setState(() {
              //   presentations.remove(presentation);
              // });
            },
          ),
          ListTile(
            leading: Icon(Icons.cancel, color: Colors.grey),
            title: Text('Cancel'),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildPresentationCard(Map<String, dynamic> presentation) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showOptionsDialog(presentation),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                presentation['doctorName'],
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),
              Text(
                "Created: ${DateFormat('dd MMM yyyy').format(presentation['createdDate'])}",
                style: TextStyle(color: Colors.grey.shade600),
              ),
              SizedBox(height: 6),
              Text(
                presentation['description'],
                style: TextStyle(color: Colors.black87),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  Color.fromRGBO(81, 120, 237, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Downloading presentation...')),
                    );
                  },
                  icon: Icon(
                    Icons.download_rounded,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Download",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _openAddPresentationDialog() {
    String doctorName = "";
    String description = "";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add New Presentation"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Doctor Name",
                  border: OutlineInputBorder(),
                ),
                onChanged: (val) {
                  doctorName = val;
                },
              ),
              SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
                onChanged: (val) {
                  description = val;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (doctorName.isNotEmpty && description.isNotEmpty) {
                setState(() {
                  presentations.add({
                    'doctorName': doctorName,
                    'createdDate': DateTime.now(),
                    'description': description,
                  });
                });
                Navigator.pop(context);
              }
            },
            child: Text("Add"),
          ),
        ],
      ),
    );
  }

  void _startSearch() {
    showSearch(
        context: context, delegate: PresentationSearchDelegate(presentations));
  }

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
        title:
            const Text("Presentations", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: _startSearch,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: filteredPresentations.isEmpty
                ? Center(
                    child: Text(
                      "No Presentations Found",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredPresentations.length,
                    itemBuilder: (context, index) {
                      return _buildPresentationCard(
                          filteredPresentations[index]);
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _openAddPresentationDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor:  Color.fromRGBO(81, 120, 237, 1),
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                label: Text("Add Presentation",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PresentationSearchDelegate extends SearchDelegate {
  final List<Map<String, dynamic>> presentations;

  PresentationSearchDelegate(this.presentations);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () => query = '')];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back), onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = presentations
        .where((p) =>
            p['doctorName'].toLowerCase().contains(query.toLowerCase()) ||
            p['description'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final presentation = results[index];
        return ListTile(
          title: Text(presentation['doctorName']),
          subtitle: Text(presentation['description']),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}
