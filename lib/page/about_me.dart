import 'dart:ui';

import 'package:flutter/material.dart';

class AboutMe extends StatefulWidget {
  const AboutMe({Key? key}) : super(key: key);

  @override
  State<AboutMe> createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: Text("AboutMe"), automaticallyImplyLeading: false),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: const [
              CircleAvatar(
                backgroundImage: AssetImage("images/ake.jpg"),
                radius: 150,
              ),
              SizedBox(height: 15),
              Center(
                child: Text(
                  "ประวัติผู้จัดทำ",
                  style: TextStyle(
                      fontSize: 30, decoration: TextDecoration.underline),
                ),
              ),
              SizedBox(height: 15),
              Card(
                child: ListTile(
                  leading: Icon(Icons.people),
                  title: Text(
                    'นายธนกิต ทรัพย์ประกอบ',
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.school),
                  title: Text(
                    'มหาวิทยาลัยเทคโนโลยีพระจอมเกล้าพระนครเหนือ',
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.facebook),
                  title: Text(
                    'Thanakit Ake',
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  leading: ImageIcon(
                    NetworkImage(
                        "https://upload.wikimedia.org/wikipedia/commons/thumb/9/91/Octicons-mark-github.svg/2048px-Octicons-mark-github.svg.png"),
                  ),
                  title: Text(
                    'Thanakit-Ake',
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
