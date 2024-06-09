import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DisplayStudentCard extends StatefulWidget {
  @override
  _DisplayStudentCardState createState() => _DisplayStudentCardState();
}

class _DisplayStudentCardState extends State<DisplayStudentCard> {
  List<dynamic> activities = [];

  @override
  void initState() {
    super.initState();
    fetchStudentCard();
  }

  Future<void> fetchStudentCard() async {
    final response = await http.get(Uri.parse('http://localhost:3000/api/StudentCard'));

    if (response.statusCode == 200) {
      setState(() {
        activities = json.decode(response.body);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load Student card'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students Card'),
      ),
      body: activities.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: activities.length,
              itemBuilder: (context, index) {
                final activity = activities[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: activity['avatar'] != null && activity['avatar'].isNotEmpty
                          ? MemoryImage(base64Decode(activity['avatar']))
                          : const CircleAvatar(
                          radius: 80,
                          child:  Icon(Icons.person, size: 100),
                        )as ImageProvider,
                    ),
                    title: Text(activity['name']),
                    subtitle: Text('Level: ${activity['level']}'),
                    trailing: Text('ID: ${activity['studentId']}'),
                  ),
                );
              },
            ),
    );
  }
}
