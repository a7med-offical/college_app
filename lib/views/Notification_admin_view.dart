import 'package:flutter/material.dart';

class NotificationAdminView extends StatelessWidget {
  const NotificationAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Notfications'),
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) =>NotificationCard() ,),
    );
  }
  // ignore: non_constant_identifier_names
  Widget NotificationCard(){
    return const ListTile(
           leading: Icon(Icons.reply),
           title: Text('Yassa20000@student.edu.eg'),
           subtitle: Text('I have a problem with Quiz 2 \n please review my grade'),
           trailing: IconButton(onPressed: null, icon:  Icon(Icons.remove_circle_sharp)),
    );
  }
}

