import 'package:flutter/material.dart';
import 'package:let_make_quiz_thanakit/model/question_model.dart';
import 'package:let_make_quiz_thanakit/page/cal_point_gard.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class Quiz extends StatefulWidget {
  const Quiz({Key? key, required this.indexjson}) : super(key: key);
  final int indexjson;
  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> with TickerProviderStateMixin {
  // late int selChoice = 0; // ใช้ในกรณีเลือก Radio 0,1,2,3,4
  late List<QusetionModel> myquiz = []; //json.title
  List<int> selChoice = []; //เลือกให้ choice เป็นค้าเริ่มต้นที่ 0 groupValue
  int point = 0; //คะแนน point
  List<int> anser = [];
  List<String> jsonfile = [
    "question1.json",
    "question2.json",
    "question3.json"
  ];
  //แปลงไฟล์ json เป็น json dart
  void readjson() async {
    //method load json
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString("json/" + jsonfile[widget.indexjson]);
    setState(() {
      myquiz = qusetionModelFromJson(jsonString);
      print(myquiz.length);
    });
    random_choice(); //random choice and title
  }

  void random_choice() {
    // เดี๋ยวมาเปลี่ยนค่า random เป็น 15
    //method random choice and title
    for (int i = 0; i < 15; i++) {
      //myquiz.length มาเปลี่ยนเป็น 15 หลังจากสร้างคำถามครบแล้ว 20 ข้อ
      // myquiz.legth ตามจำนวนค่าใน json
      myquiz.shuffle(); //random title
      //myquiz[i].choices.shuffle(); //random choice
      selChoice.add(0);
      anser.add(0); // กำหนดค่า GroupValue ของ Radio
    }
  }

  @override
  void initState() {
    // เมื่อโปรแกรมทำงานให้ run funtion พวกนี้ก่อน
    super.initState();
    readjson();
    //-----------timer-----------------//
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 900),
    );

    controller.addListener(() {
      notify();
      if (controller.isAnimating) {
        setState(() {
          progress = controller.value;
        });
      } else {
        setState(() {
          progress = 1.0;
          isPlaying = false;
        });
      }
    });
    start_time();
  }

  //function คำนวณคำตอบที่ตอบถูก
  //หลักการทำงาน จะประกาศตัวแปรร point ไว้เก็บคะแนนที่ถูก
  //ใน radio จะมีตัวแปรร  anser เก็บคำตอบที่ตอบมาเก็บไว้
  //ถ้าเงื่อนไขเป็นจริงจะให้ค่า point ++ โดยมาตรวจสอบ myquiz ก็คือค่า json ในไฟล์ json anserId
  void answer() {
    point = 0;
    for (int i = 0; i < anser.length; i++) {
      if (anser[i] == myquiz[i].anserId) {
        point++;
      }
    }
    setState(() {
      point = point;
    });
  }

  //----------------------------------- Function Timer ---------------------------//
  late AnimationController controller;
  int counttime = 0;
  bool isPlaying = true;
  String get countText {
    Duration count = controller.duration! * controller.value;
    return controller.isDismissed
        ? '${0}:${(15 % 60).toString().padLeft(2, '0')}:${(00 % 60).toString().padLeft(2, '0')}'
        : '${count.inHours}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  double progress = 1.0;
  void notify() {
    if (countText == '0:00:00') {
      FlutterRingtonePlayer.playNotification();
      print("หมดเวลา");
      counttime++;
      print("$counttime");
      String timeout = "15 นาที 00 วินาที";
      if (counttime == 3) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => point_gard(
                    lengthquiz: 15,
                    point: point,
                    timer: timeout,
                  )),
        );
      }
    }
  }

  void start_time() {
    controller.reverse(from: controller.value == 0 ? 1.0 : controller.value);
    setState(() {
      isPlaying = true;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget draw_time() {
    // นาฬิกา
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: double.infinity, //ขนาดวงกลม
                height: 50, //ขนาดวงกลม
                child: LinearProgressIndicator(
                  backgroundColor: Colors.green,
                  value: progress,
                ),
              ),
              GestureDetector(
                child: AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) => Text(
                    countText,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String changetime = ""; //เช็คเวลาในการทำ
  void change_timer() {
    //function เช็คเวลาในการทำ
    int min = 14 - int.parse(countText.substring(2, 4).trim());
    int sec = 60 - int.parse(countText.substring(5).trim());

    String smin = min.toString();
    String ssec = sec.toString();
    if (smin.length < 2) {
      smin = "0" + smin;
    }
    if (ssec.length < 2) {
      ssec = "0" + ssec;
    }
    changetime = "$smin นาที $ssec วินาที";
    // print(changetime);
    // print(smin);
    // print(ssec);
  }
//---------------------------End Timer--------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Choiec"),
        ),
        body: Column(
          children: [
            draw_time(),
            Expanded(
              child: ListView.builder(
                  itemCount: 15,
                  itemBuilder: (BuildContext context, int index) {
                    //     print("VALUE: $index");
                    return datachoices(index);
                  }),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  // Url ไป page point_gard ไปสู่ฟังก์ชั่นตัดเกรด
                  onPressed: () {
                    isPlaying = false;
                    answer();
                    change_timer();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => point_gard(
                                point: point,
                                lengthquiz: 15,
                                timer: changetime,
                              )),
                    );
                  },
                  child: Text("ส่ง")),
            )
          ],
        ));
  }

  //เป็นฟังก์ชั่นที่เอา text และ choice ออกมาเป็น widget
  Widget datachoices(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 0, 5),
          child: Text(
            // Title
            "${index + 1}. ${myquiz[index].title}",
            style: const TextStyle(
                fontSize: 30,
                backgroundColor: Color.fromARGB(255, 110, 58, 162),
                fontFamily: "duck"),
          ),
        ),
       
        Center(
          child: Image.network(
            '${myquiz[index].img}',
          ),
        ),
        ListTile(
          //choice
          title: Text(
            myquiz[index].choices[0].title,
            style: TextStyle(fontFamily: "duck"),
          ),
          leading: Radio(
            toggleable: true,
            value: myquiz[index].choices[0].id,
            groupValue: selChoice[index],
            onChanged: (int? value) {
              setState(() {
                selChoice[index] = value!;
                anser[index] = value;
                print(selChoice[index]);
              });
            },
          ),
        ),
        ListTile(
          //choice2
          title: Text(
            myquiz[index].choices[1].title,
            style: TextStyle(fontFamily: "duck"),
          ),
          leading: Radio(
            toggleable: true,
            value: myquiz[index].choices[1].id,
            groupValue: selChoice[index],
            onChanged: (int? value) {
              setState(() {
                selChoice[index] = value!;
                print(selChoice[index]);
                anser[index] = value;
              });
            },
          ),
        ),
        ListTile(
          //choice3
          title: Text(
            myquiz[index].choices[2].title,
            style: TextStyle(fontFamily: "duck"),
          ),
          leading: Radio(
            toggleable: true,
            value: myquiz[index].choices[2].id,
            groupValue: selChoice[index],
            onChanged: (int? value) {
              setState(() {
                selChoice[index] = value!;
                print(selChoice[index]);
                anser[index] = value;
              });
            },
          ),
        ),
        ListTile(
          //choice4
          title: Text(
            myquiz[index].choices[3].title,
            style: TextStyle(fontFamily: "duck"),
          ),
          leading: Radio(
            toggleable: true,
            value: myquiz[index].choices[3].id,
            groupValue: selChoice[index],
            onChanged: (int? value) {
              setState(() {
                selChoice[index] = value!;
                print(selChoice[index]);
                anser[index] = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
