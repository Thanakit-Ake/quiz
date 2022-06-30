import 'package:flutter/material.dart';
import 'package:let_make_quiz_thanakit/page/garph.dart';
import 'package:shared_preferences/shared_preferences.dart';

class point_gard extends StatefulWidget {
  const point_gard(
      {Key? key,
      required this.point,
      required this.lengthquiz,
      required this.timer})
      : super(key: key);
  final int point, lengthquiz;
  final String timer;
  @override
  State<point_gard> createState() => _point_gardState();
}

class _point_gardState extends State<point_gard> {
  String your_gard = "";
  double gard = 0;
  String datetime = "";
  void cal_gard() {
    gard = (widget.point * 100) / widget.lengthquiz;
    if (gard >= 80) {
      your_gard = "A";
      print("A");
    } else if (gard >= 75) {
      your_gard = "B+";
      print("B+");
    } else if (gard >= 70) {
      your_gard = "B";
      print("B");
    } else if (gard >= 65) {
      your_gard = "C+";
      print("C+");
    } else if (gard >= 60) {
      your_gard = "C";
      print("C");
    } else if (gard >= 55) {
      your_gard = "D+";
      print("D+");
    } else if (gard >= 50) {
      your_gard = "D";
      print("D");
    } else {
      your_gard = "F";
      print("F");
    }
    date_time();
  }

  void date_time() {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    DateTime tsdate = DateTime.fromMillisecondsSinceEpoch(timestamp);
    datetime = tsdate.hour.toString() +
        ":" +
        tsdate.minute.toString() +
        " " +
        tsdate.day.toString() +
        "/" +
        tsdate.month.toString() +
        "/" +
        tsdate.year.toString();
    print(datetime);
  }

  void pref_garph() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt("point", widget.point);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cal_gard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("รายงานผลรวม"), automaticallyImplyLeading: false),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                width: 370,
                height: 270,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "${widget.point}/${widget.lengthquiz}",
                        style: const TextStyle(
                            fontSize: 40,
                            fontFamily: "duck",
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            color: Colors.white),
                      ),
                      Text(
                        "คุณทำได้ ${gard.toStringAsFixed(2)} %",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: "duck",
                        ),
                      ),
                      Text("คุณได้เกรด $your_gard",
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: "duck",
                          )),
                      Text(
                        "$datetime",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: "duck",
                        ),
                      ),
                      Text(
                        "คุณใช้เวลาในการทำ: ${widget.timer}",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: "duck",
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border.all(width: 3),
                  borderRadius: BorderRadius.all(
                    Radius.circular(200),
                  ),
                  color: Color.fromARGB(255, 210, 31, 28),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Garph(
                                checklocation: true,
                                date: datetime,
                                point: widget.point,
                              )),
                    );
                  },
                  child: const Text("ดูสถิติ")),
            ),
          ]),
    );
  }

  void test() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('point', widget.point);
    await prefs.setStringList('items', <String>['15', '20', '30']);

    print("ค่าpoint ${prefs.getInt("point")}");
  }
}


