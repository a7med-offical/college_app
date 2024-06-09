import 'package:college_app/views/admin/student_card_listview.dart';
import 'package:college_app/views/stduent/activaty_view.dart';
import 'package:college_app/views/stduent/create%20_card_view.dart';
import 'package:flutter/material.dart';
import 'views/register_view.dart';

void main() {
  runApp(const CollegeApp());
}

class CollegeApp extends StatelessWidget {
  const CollegeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(

      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home:DisplayStudentCard()
    );
  }
}