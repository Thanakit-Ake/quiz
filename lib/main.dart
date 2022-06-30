import 'package:flutter/material.dart';
import 'package:let_make_quiz_thanakit/page/about_me.dart';
import 'package:let_make_quiz_thanakit/page/garph.dart';

import 'package:let_make_quiz_thanakit/page/selction_quiz.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        debugShowCheckedModeBanner: false,
        home: MainPage());
  }
}

class MainPage extends StatefulWidget {
//  const MainPage({ Key? key }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final tabs = [
    Select_Quiz(),
    Garph(checklocation: false, date: "", point: 0),
    AboutMe()
  ]; //เก็บค่าได้หลายค่า list

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  appBar: AppBar(title: Text("Choice")),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          backgroundColor: Colors.redAccent,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.quiz_rounded),
              label: "Quiz",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.auto_graph_sharp), label: "Statistics"),
            BottomNavigationBarItem(
                icon: Icon(Icons.contact_mail), label: "About Me"),
          ],
          onTap: (index) {
            setState(() {
              print(index);
              _currentIndex = index;
            });
          }),
    );
  }
}
