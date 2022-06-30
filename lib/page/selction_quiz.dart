import 'package:flutter/material.dart';
import 'package:let_make_quiz_thanakit/model/sel.model.dart';
import 'package:let_make_quiz_thanakit/page/quiz.dart';

class Select_Quiz extends StatefulWidget {
  const Select_Quiz({Key? key}) : super(key: key);

  @override
  State<Select_Quiz> createState() => _Select_QuizState();
}

class _Select_QuizState extends State<Select_Quiz> {
  late List<SelectModel> myselection=[];
  void readjson() async {
    String jsonString =
        await DefaultAssetBundle.of(context).loadString("json/imag_ques.json");
    setState(() {
      myselection = selectModelFromJson(jsonString);
      print(myselection.length);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readjson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Select quiz"), automaticallyImplyLeading: false),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/sel_dota.gif"),
                fit: BoxFit.cover,
              ),
            ),
            padding: const EdgeInsets.all(5),
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return MyBox(index);
              },
              itemCount: myselection.length,
            )));
  }

  Widget MyBox(int index) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.all(10),
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage("${myselection[index].img}"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.20), BlendMode.darken)),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Text(
            "${myselection[index].title}",
            style: const TextStyle(
                fontSize: 40,
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontFamily: "duck",
                backgroundColor: Color.fromARGB(255, 110, 58, 162)),
          ),
          SizedBox(height: 2),
          Text("${myselection[index].subtitle}",
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "duck",
                  backgroundColor: Color.fromARGB(255, 208, 224, 42))),
          IconButton(
            onPressed: () {
              print("Next page");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Quiz(
                            indexjson: index,
                          )));
            },
            icon: const Icon(Icons.edit_note_rounded),
            color: Colors.red,
          ),
         const Text(
            "ทำแบบทดสอบ",
            style: TextStyle(
              fontSize: 16,
              fontFamily: "duck",
                color: Colors.white,
                backgroundColor: Color.fromARGB(255, 209, 46, 46)),
          )
        ],
      ),
    );
  }
}
