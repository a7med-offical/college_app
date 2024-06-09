import 'package:college_app/components/button_componet.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ActivityView extends StatefulWidget {
  const ActivityView({super.key});

  @override
  _ActivityViewState createState() => _ActivityViewState();
}

class _ActivityViewState extends State<ActivityView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  String? _selectedActivityType;
  final List<String> _activityTypes = [
    'Sports Activity',
    'Activity 2',
    'Activity 3'
  ];

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final String name = _nameController.text;
      final String typeActivity = _selectedActivityType!;
      final DateTime date = DateTime.now();

      final response = await http.post(
        Uri.parse('http://localhost:3000/api/activities'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'name': name,
          'typeactivity': typeActivity,
          'date': date.toIso8601String(),
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Activity saved successfully')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to save activity')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity '),
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
              Image.asset('Assets/images/activaty.png'),
              const SizedBox(
                height: 80,
              ),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Student Name',
                ),
              ),
              const SizedBox(height: 40),
              DropdownButtonFormField<String>(
                borderRadius: BorderRadius.circular(5),
                value: _selectedActivityType,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedActivityType = newValue!;
                  });
                },
                items: _activityTypes
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                hint: const Text('Select Activity Type'),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                validator: (value) =>
                    value == null ? 'Please select an activity type' : null,
              ),
              const SizedBox(height: 80),
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
