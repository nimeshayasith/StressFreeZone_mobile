import 'package:flutter/material.dart';
import 'package:flutter_application/main.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({super.key});

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  String _gender = "Male";
  File? _profileImage;

  Future<void> _pickProfileImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
        //backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.teal,
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : null,
                      child: _profileImage == null
                          ? const Icon(Icons.person,
                              size: 60, color: Colors.white)
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _pickProfileImage,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.grey.shade800,
                          child: const Icon(
                            Icons.edit,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              _buildTextField(
                label: 'Full name',
                hint: 'Nimesha Sarangaya',
              ),
              _buildTextField(
                label: 'Email',
                hint: 'nimesha.sarangaya@gmail.com',
              ),
              _buildTextField(
                label: 'Birthday',
                hint: '01 April 1999',
              ),
              const SizedBox(
                height: 16,
              ),
              const Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Height (cm)',
                        hintText: '170',
                        hintStyle: TextStyle(color: Colors.black38),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Weight (kg)',
                        hintText: '60',
                        hintStyle: TextStyle(color: Colors.black38),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              const Text('Gender'),
              Row(
                children: [
                  ChoiceChip(
                    label: const Text('Male'),
                    selected: _gender == "Male",
                    onSelected: (selected) {
                      setState(() {
                        _gender = "Male";
                      });
                    },
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ChoiceChip(
                    label: const Text('Female'),
                    selected: _gender == "Female",
                    onSelected: (selected) {
                      setState(() {
                        _gender = "Female";
                      });
                    },
                  ),
                ],
              ),
              const Divider(),
              const Text('App settings'),
              SwitchListTile(
                title: const Text('Dark mode'),
                value: themeProvider.isDarkMode,
                onChanged: (value) {
                  themeProvider.toggleTheme();
                  //themeProvider.setDarkMode(value);
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Save Account changes................................................................................................
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 12),
                  ),
                  child: const Text('Save Changes'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, required String hint}) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        hintStyle: const TextStyle(
          color: Colors.black38,
        ),
      ),
    );
  }
}
