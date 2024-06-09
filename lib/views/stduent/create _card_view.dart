import 'package:college_app/components/button_componet.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class CreateCardStudent extends StatefulWidget {
  @override
  _CreateCardStudentState createState() => _CreateCardStudentState();
}

class _CreateCardStudentState extends State<CreateCardStudent> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _studentIdController = TextEditingController();
  String ? _selectedLevel ;
  File? _image;
  final List<String> _levels = ['1', '2', '3', '4'];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        ScaffoldMessenger.of(context as BuildContext)
            .showSnackBar(const SnackBar(content: Text('No image selected')));
      }
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate() &&
        _image != null &&
        _selectedLevel != null) {
      final String name = _nameController.text;
      final String studentId = _studentIdController.text;
      final String avatar = base64Encode(_image!.readAsBytesSync());

      final response = await http.post(
        Uri.parse('http://localhost:3000/api/StudentCard'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'name': name,
          'level': _selectedLevel,
          'avatar': avatar,
          'studentId': studentId,
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
            const SnackBar(content: Text('Activity saved successfully')));
      } else {
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
            const SnackBar(content: Text('Failed to save student card')));
      }
    } else {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          const SnackBar(content: Text('Please complete all fields')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Card Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Column(
                children: <Widget>[
                  _image == null
                      ? const CircleAvatar(
                          radius: 80,
                          child: const Icon(Icons.person, size: 100),
                        )
                      : Image.file(_image!, width: 100, height: 100),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: const Text('Upload Image'),
                  ),
                ],
              ),
            const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the name ';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _studentIdController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Student ID',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the student ID';
                  }
                  return null;
                },
              ),
                 const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedLevel,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedLevel = newValue!;
                  });
                },
                items: _levels.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                hint: const Text('Select Level'),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                validator: (value) =>
                    value == null ? 'Please select a level' : null,
              ),
            
              const SizedBox(height: 20),
              MyButton(
                onPressed: _submitForm,
                textButton: 'Submit',
              )
            ],
          ),
        ),
      ),
    );
  }
}
