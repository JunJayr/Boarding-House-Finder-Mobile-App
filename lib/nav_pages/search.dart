import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tanle/nav_pages/details.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _FetchDataScreenState createState() => _FetchDataScreenState();
}

class _FetchDataScreenState extends State<Search> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Boarding Houses',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search location',
                suffixStyle: TextStyle(fontSize: 15),
                prefixIcon: Icon(Icons.search, size: 26),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {});
                  },
                ),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: _buildSearchResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return StreamBuilder<QuerySnapshot>(
      stream: _searchController.text.isEmpty
          ? FirebaseFirestore.instance.collection('Records').snapshots()
          : FirebaseFirestore.instance
              .collection('Records')
              .where('Name', isGreaterThanOrEqualTo: _searchController.text)
              .where('Name', isLessThan: _searchController.text + 'z')
              .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Text('No data available');
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var data =
                snapshot.data!.docs[index].data() as Map<String, dynamic>;
            return ListTile(
              title: Text('Name: ${data['Name']}'),
              subtitle: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.price_change),
                  SizedBox(
                    width: 100,
                    child: Text('Price: ${data['Price']}'),
                  ),
                  const Icon(Icons.location_city),
                  SizedBox(
                    width: 200,
                    child: Text('Location: ${data['Location']}'),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(data: data),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

Widget _buildDetailRow(IconData icon, String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Icon(icon),
        Text('$title: $value'),
      ],
    ),
  );
}
