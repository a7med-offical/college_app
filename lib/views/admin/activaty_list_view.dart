import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ActivityListView extends StatefulWidget {
  const ActivityListView({super.key});

  @override
  _ActivityListViewState createState() => _ActivityListViewState();
}

class _ActivityListViewState extends State<ActivityListView> {
  Future<List<Activity>> fetchActivities() async {
    final response = await http.get(Uri.parse('http://localhost:3000/api/activities'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((activity) => Activity.fromJson(activity)).toList();
    } else {
      throw Exception('Failed to load activities');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Activity '),
      ),
      body: FutureBuilder<List<Activity>>(
        future: fetchActivities(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load activities'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No activities found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Activity activity = snapshot.data![index];
                return ListTile(
                  title: Text(activity.name ??'Yassa kama'),
                  subtitle: Text('${activity.typeActivity ?? 'Sports acivaty'} - ${activity.date ?? '9/6/2024'}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class Activity {
  final String name;
  final String typeActivity;
  final String date;

  Activity({required this.name,required this.typeActivity,required this.date});

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      name: json['name'],
      typeActivity: json['typeActivity'],
      date: json['date'],
    );
  }
}
