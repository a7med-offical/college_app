import 'package:college_app/views/Notification_admin_view.dart';
import 'package:flutter/material.dart';

class adminHomeView extends StatelessWidget {
  const adminHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>const NotificationAdminView(),));
              },
              icon: const Icon(Icons.notifications))
        ],
      ),
      body: const Center(
        child: const Text('Admin Services'),
      ),
    );
  }
}
