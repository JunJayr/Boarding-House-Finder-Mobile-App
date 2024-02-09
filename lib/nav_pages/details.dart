import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailsScreen extends StatefulWidget {
  final Map<String, dynamic> data;

  const DetailsScreen({Key? key, required this.data}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late TextEditingController _nameController;
  late TextEditingController _locationController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;
  late TextEditingController _discountController;
  late TextEditingController _ratingController;
  late TextEditingController _contactInfoController;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.data['Name']);
    _locationController = TextEditingController(text: widget.data['Location']);
    _priceController = TextEditingController(text: widget.data['Price']);
    _descriptionController =
        TextEditingController(text: widget.data['Description']);
    _discountController = TextEditingController(text: widget.data['Discount']);
    _ratingController = TextEditingController(text: widget.data['Rating']);
    _contactInfoController =
        TextEditingController(text: widget.data['ContactInfo']);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _discountController.dispose();
    _ratingController.dispose();
    _contactInfoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _updateData();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Data saved successfully')),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEditableDetailRow(Icons.business, 'Name', _nameController),
            _buildEditableDetailRow(
                Icons.location_on, 'Location', _locationController),
            _buildEditableDetailRow(
                Icons.attach_money, 'Price', _priceController),
            _buildEditableDetailRow(
                Icons.description, 'Description', _descriptionController),
            _buildEditableDetailRow(
                Icons.local_offer, 'Discount', _discountController),
            _buildEditableDetailRow(Icons.star, 'Rating', _ratingController),
            _buildEditableDetailRow(
                Icons.contact_phone, 'Contact Info', _contactInfoController),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableDetailRow(
      IconData icon, String title, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 8),
          Expanded(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(labelText: title),
            ),
          ),
        ],
      ),
    );
  }

  void _updateData() async {
    // Update the data in Firebase
    await FirebaseFirestore.instance
        .collection('Records')
        .doc('YXfNihPZCtY8MMyuuCID')
        .update({
      'Name': _nameController.text,
      'Location': _locationController.text,
      'Price': _priceController.text,
      'Description': _descriptionController.text,
      'Discount': _discountController.text,
      'Rating': _ratingController.text,
      'ContactInfo': _contactInfoController.text,
    });
  }
}
