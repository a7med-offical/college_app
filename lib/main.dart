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
      home:RegisterView()
    );
  }
}