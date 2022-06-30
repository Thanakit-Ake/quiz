import 'package:flutter/material.dart';
import 'package:let_make_quiz_thanakit/main.dart';
import 'package:let_make_quiz_thanakit/model/statistics_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Garph extends StatefulWidget {
  const Garph(
      {Key? key,
      required this.point,
      required this.checklocation,
      required this.date})
      : super(key: key);
  final int point;
  final bool checklocation;
  final String date;
  @override
  State<Garph> createState() => _GarphState();
}

class _GarphState extends State<Garph> {
  //------------Data Pref---------------------//
  List<Data_pref_chart_garph> data_pref = [];

  List<String>? value_point = [];
  List<String>? value_date = [];
  void set_value() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (widget.checklocation) {
      await swap_location("items_point", widget.point.toString());
      await swap_location("items_date_time", widget.date);
    }

    setState(() {
      value_point =
          pref.getStringList("items_point") ?? <String>["", "", "", "", ""];
      value_date =
          pref.getStringList("items_date_time") ?? <String>["", "", "", "", ""];
      print("1: $value_point");
      print("2: $value_date");
      data_pref = [
        Data_pref_chart_garph(value_date![0], value_point![0].trim()),
        Data_pref_chart_garph(value_date![1], value_point![1].trim()),
        Data_pref_chart_garph(value_date![2], value_point![2].trim()),
        Data_pref_chart_garph(value_date![3], value_point![3].trim()),
        Data_pref_chart_garph(value_date![4], value_point![4].trim())
      ];
    });
  }

  swap_location(String text, String vale_garph) async {
    String num0 = ""; //ค่าตำแหน่งแรก
    String num1 = ""; //ย้ายตำแหน่งที่ 0 ไปตำแหน่งที่ 1
    String num2 = ""; //ย้ายตำแหน่งที่ 1 ไปตำแหน่งที่ 2
    String num3 = ""; //ย้ายตำแหน่งที่ 1 ไปตำแหน่งที่ 2
    String num4 = ""; //ย้ายตำแหน่งที่ 1 ไปตำแหน่งที่ 2
    List<String>? item_value; // List items
    SharedPreferences pref = await SharedPreferences.getInstance();
    item_value = pref.getStringList(text) ??
        <String>[
          "",
          "",
          "",
          "",
          ""
        ]; // เอาค่าตััวแปรร text มาเช็คถ้าไม่ใช่ก็ให้มันมีค่าหลัง
    num0 = vale_garph; //ค่าตำแหน่งแรก
    num1 = item_value[0]; //ย้ายตำแหน่งที่ 0 ไปตำแหน่งที่ 1
    num2 = item_value[1]; //ย้ายตำแหน่งที่ 1 ไปตำแหน่งที่ 2
    num3 = item_value[2]; //ย้ายตำแหน่งที่ 2 ไปตำแหน่งที่ 3
    num4 = item_value[3]; //ย้ายตำแหน่งที่ 3 ไปตำแหน่งที่ 4
    await pref.setStringList(text, <String>[
      "$num0",
      "$num1",
      "$num2",
      "$num3",
      "$num4"
    ]); //เอาค่าที่สลับตำแหน่งแล้วมาเรียงใหม่

    item_value = pref.getStringList(text) ?? <String>["", "", "", "", ""];
    print("ล่างสุด$item_value");
  }

  //------------End Data Pref---------------------//

  late TooltipBehavior _tooltipBehavior;
  late List<Statistics> data = [];

  void read_json() async {
    String jsonString =
        await DefaultAssetBundle.of(context).loadString("json/statistics.json");
    setState(() {
      data = statisticsFromJson(jsonString);
    });
  }

  void initState() {
    super.initState();
    set_value();
    read_json();
    _tooltipBehavior = TooltipBehavior(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('สถิติการสอบ'), automaticallyImplyLeading: false),
        body: ListView(
          children: [
            SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                // Chart title
                title: ChartTitle(text: 'คะแนน'),
                // Enable legend
                legend: Legend(isVisible: true),
                // Enable tooltip
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries<Data_pref_chart_garph, String>>[
                  LineSeries<Data_pref_chart_garph, String>(
                      dataSource: data_pref,
                      xValueMapper: (Data_pref_chart_garph data_pref, _) =>
                          data_pref.date,
                      yValueMapper: (Data_pref_chart_garph data_pref, _) =>
                          int.tryParse(data_pref.point),
                      name: 'คะแนน',
                      // Enable data label
                      dataLabelSettings: DataLabelSettings(isVisible: true))
                ]),
            SfCircularChart(
                // Chart title text
                title: ChartTitle(text: 'เกรด'),
                legend: Legend(isVisible: true),
                tooltipBehavior: _tooltipBehavior,
                series: <CircularSeries>[
                  // Render pie chart
                  PieSeries<Data_pref_chart_garph, String>(
                      enableTooltip: true,
                      dataSource: data_pref,
                      xValueMapper: (Data_pref_chart_garph data_pref, _) =>
                          data_pref.date,
                      yValueMapper: (Data_pref_chart_garph data_pref, _) =>
                          int.tryParse(data_pref.point),
                      name: "Data",
                      dataLabelSettings: DataLabelSettings(isVisible: true)),
                ]),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage()),
                  );
                },
                child: Text("BACK HOME")),
          ],
        )
        //Initialize the chart widget
        );
  }
}

class Data_pref_chart_garph {
  Data_pref_chart_garph(
    this.date,
    this.point,
  );
  final String point;
  final String date;
}
