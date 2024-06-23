
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../colors.dart';
import '../navigationBar.dart';

class AddressDetailsPage extends StatefulWidget {
  const AddressDetailsPage({Key? key}) : super(key: key);

  @override
  State<AddressDetailsPage> createState() => _AddressDetailsPageState();
}

class _AddressDetailsPageState extends State<AddressDetailsPage> {
  late String email;
  late String mobile;
  late String state;
  late String city;
  late String street;

  @override
  void initState() {
    super.initState();
    _loadAddressDetails();
  }

  Future<void> _loadAddressDetails() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('user_email') ?? 'No data';
      mobile = prefs.getString('mobile') ?? 'No data';
      state = prefs.getString('state') ?? 'No data';
      city = prefs.getString('city') ?? 'No data';
      street = prefs.getString('street') ?? 'No data';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(),
      appBar: AppBar(
        title: const Text('Address Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailLabel('Email'),
            const SizedBox(height: 8),
            _buildDetailValue(email),
            const SizedBox(height: 16),
            _buildDetailLabel('Mobile'),
            const SizedBox(height: 8),
            _buildDetailValue(mobile),
            const SizedBox(height: 16),
            _buildDetailLabel('State'),
            const SizedBox(height: 8),
            _buildDetailValue(state),
            const SizedBox(height: 16),
            _buildDetailLabel('City'),
            const SizedBox(height: 8),
            _buildDetailValue(city),
            const SizedBox(height: 16),
            _buildDetailLabel('Street'),
            const SizedBox(height: 8),
            _buildDetailValue(street),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailLabel(String label) {
    return Text(
      label,
      style: const TextStyle(fontSize: 18, color: AppColors.darkblue),
    );
  }

  Widget _buildDetailValue(String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.darkblue),
          borderRadius: BorderRadius.circular(5.0),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Text(
          value,
          style: const TextStyle(fontSize: 18, color: AppColors.darkblue),
        ),
      ),
    );
  }
}
