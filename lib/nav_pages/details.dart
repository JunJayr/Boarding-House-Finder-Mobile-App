import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  const DetailsScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow(Icons.business, 'Name', '${data['Name']}'),
            _buildDetailRow(
                Icons.location_on, 'Location', '${data['Location']}'),
            _buildDetailRow(Icons.attach_money, 'Price', '${data['Price']}'),
            _buildDetailRow(
                Icons.description, 'Description', '${data['Description']}'),
            _buildDetailRow(
                Icons.local_offer, 'Discount', '${data['Discount']}'),
            _buildDetailRow(Icons.star, 'Rating', '${data['Rating']}'),
            _buildDetailRow(
                Icons.contact_phone, 'Contact Info', '${data['ContactInfo']}'),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 8),
          Expanded(child: Text('$title: $value')),
        ],
      ),
    );
  }
}
