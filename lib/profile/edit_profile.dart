
import 'package:flutter/material.dart';

import '../core/cache_manager.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  ProfilePageEditState createState() => ProfilePageEditState();
}

class ProfilePageEditState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  @override
  void initState() {
    _nameController.text = CacheHelper.getFromShared('name');
    _ageController.text = "21";
    _weightController.text = "85";

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final EditScreenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white24,
        centerTitle: true,
        title: const Text('Edit Profile', style: TextStyle(color: Colors.black)),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Hero(
                    tag: 'profile_picture',
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage: AssetImage("assets/user.jpg"),
                          radius: 45,
                          backgroundColor: Colors.grey,
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          icon: const Icon(Icons.camera_alt),
                          color: Colors.grey,
                          onPressed: () {},
                        ),
                        const SizedBox(width: 10),
                        const Text('upload new photo '),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      label: Text('Name'),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _ageController,
                    decoration: const InputDecoration(
                      labelText: 'EMAIL',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your age';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _weightController,
                    decoration: const InputDecoration(
                      labelText: 'LOCATION',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your weight';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          // Process the data
                          // For now, just print the values
                          debugPrint('Name: ${_nameController.text}');
                          debugPrint('Age: ${_ageController.text}');
                          debugPrint('Weight: ${_weightController.text}');
                        }
                      },
                      child: Container(
                        height: 55,
                        width: 300,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 48, 43, 89),
                        ),
                        child: const Text(
                          "SAVE CHANGES",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
