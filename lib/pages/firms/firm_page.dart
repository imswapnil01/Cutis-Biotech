import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'add_firm.dart';

class FirmsPage extends StatefulWidget {
  @override
  _FirmsPageState createState() => _FirmsPageState();
}

class _FirmsPageState extends State<FirmsPage> {
  final Color primaryBlue = const Color.fromARGB(81, 120, 237, 1);
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> firms = [
    {
      'name': 'Sun Pharma',
      'location': 'Mumbai, Maharashtra',
      'type': 'Retailer',
    },
    {
      'name': 'Wellness Distributors',
      'location': 'Pune, Maharashtra',
      'type': 'Distributor',
    },
    {
      'name': 'Apex Stockist',
      'location': 'Nagpur, Maharashtra',
      'type': 'Stockist',
    },
    // Add more firms here
  ];

  List<Map<String, String>> filteredFirms = [];
  String selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    filteredFirms = List.from(firms);
    _searchController.addListener(_filterFirms);
  }

  void _filterFirms() {
    String query = _searchController.text.toLowerCase();

    setState(() {
      filteredFirms = firms.where((firm) {
        final name = firm['name']!.toLowerCase();
        final location = firm['location']!.toLowerCase();
        final type = firm['type']!.toLowerCase();

        final matchesQuery = name.contains(query) || location.contains(query);
        final matchesFilter = selectedFilter == 'All' || type == selectedFilter.toLowerCase();

        return matchesQuery && matchesFilter;
      }).toList();
    });
  }

  void _updateFilter(String filter) {
    setState(() {
      selectedFilter = filter;
      _filterFirms();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String getCurrentDateTime() {
    return DateFormat('dd MMM yyyy • hh:mm a').format(DateTime.now());
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
          Color.fromRGBO(88, 125, 237, 1),  // rgba(88, 125, 237, 1)
          Color.fromRGBO(81, 120, 237, 1),  // rgba(81, 120, 237, 1)
          Color.fromRGBO(114, 142, 242, 1), // rgba(114, 142, 242, 1)
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    ),
  ),
  title: const Text("Firms", style: TextStyle(color: Colors.white)),
  leading: IconButton(
    icon: const Icon(Icons.arrow_back, color: Colors.white),
    onPressed: () {
      Navigator.pop(context);
    },
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  actions: [
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      // Uncomment and customize this if needed
      // child: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Text("John Doe", style: TextStyle(fontSize: 12, color: Colors.white)),
      //     Text(getCurrentDateTime(), style: TextStyle(fontSize: 10, color: Colors.white70)),
      //   ],
      // ),
    ),
  ],
),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search by Name or Location",
                      prefixIcon: const Icon(Icons.search),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: const Color.fromARGB(81, 120, 237, 1), width: 2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child:Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Filter by Type:", style: TextStyle(fontWeight: FontWeight.w500)),
                  DropdownButton<String>(
                    value: selectedFilter,
                    items: ['All', 'Retailer', 'Distributor', 'Stockist']
                        .map((filter) => DropdownMenuItem(
                      value: filter,
                      child: Text(filter),
                    ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) _updateFilter(value);
                    },
                    borderRadius: BorderRadius.circular(10),
                    style: TextStyle(color: Colors.black, fontSize: 14),
                    icon: Icon(Icons.filter_list, color: Color.fromARGB(255, 80, 113, 223)),
                    underline: Container(), // Removes the default underline
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: filteredFirms.length,
              itemBuilder: (context, index) {
                final firm = filteredFirms[index];
                return GestureDetector(
                  onTap: () => _showFirmOptions(context),
                  child: _buildFirmCard(firm),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddFirmPage()));
        },
        backgroundColor: const Color.fromARGB(255, 80, 113, 223),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildFirmCard(Map<String, String> firm) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor:  Color.fromRGBO(81, 120, 237, 1),
            child: Text(
              firm['name']![0],
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(firm['name']!, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(firm['type']!, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(firm['location']!, style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showFirmOptions(BuildContext context) {
    String? selectedOption;
    showModalBottomSheet(
      isScrollControlled: true, // Optional but helpful for taller sheets
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RadioListTile(
                      title: Text("Add Visit"),
                      value: "Add Visit",
                      groupValue: selectedOption,
                      onChanged: (value) => setState(() => selectedOption = value as String),
                    ),
                    RadioListTile(
                      title: Text("View/Add Order"),
                      value: "View/Add Order",
                      groupValue: selectedOption,
                      onChanged: (value) => setState(() => selectedOption = value as String),
                    ),
                    RadioListTile(
                      title: Text("View/Add Stock Tally"),
                      value: "View/Add Stock",
                      groupValue: selectedOption,
                      onChanged: (value) => setState(() => selectedOption = value as String),
                    ),
                    RadioListTile(
                      title: Text("Update Firm"),
                      value: "Update",
                      groupValue: selectedOption,
                      onChanged: (value) => setState(() => selectedOption = value as String),
                    ),
                    RadioListTile(
                      title: Text("Delete Firm"),
                      value: "Delete",
                      groupValue: selectedOption,
                      onChanged: (value) => setState(() => selectedOption = value as String),
                    ),
                    RadioListTile(
                      title: Text("Payment"),
                      value: "Payment",
                      groupValue: selectedOption,
                      onChanged: (value) => setState(() => selectedOption = value as String),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("CANCEL", style: TextStyle(color:  Color.fromRGBO(81, 120, 237, 1))),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("SUBMIT", style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(backgroundColor:  Color.fromRGBO(81, 120, 237, 1)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}
