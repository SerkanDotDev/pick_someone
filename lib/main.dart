import 'dart:io';
import 'dart:math';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:flutter/material.dart';
import 'listofstudents.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ScrollController sc = ScrollController();
  ScrollController sc2 = ScrollController();
  int selectedindex;
  String selectedLesson = "Sayısal Elektronik";
  List selectedLessonStudents;
  List selectedStudents;

  @override
  void initState() {
 selectedStudents  = Students.selectedSayisal;
 selectedLessonStudents = Students.sayisalElektronik;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          onPressed: () {
            actionSheet();
          },
          child: Icon(Icons.dehaze),
        ),
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          title: Text(selectedLesson),
        ),
        body: Column(
            children: [
              Divider(),
              Expanded(
                flex: 5,
                child: victimsWidgets(),
              ),
              Expanded(
                flex: 2,
                child: turnButton(),
              ),
              Expanded(
                  flex: 20,
                  child: selectedVictimsWidget(
                  )
              )
            ]
        ));
  }

  void pickSomeone() {
    int i = Random().nextInt(selectedLessonStudents.length);
    double slide = 110 * i.toDouble();
    jumpToSelected(i, slide);
  }

  void choiceLesson(int i) {
    if (i == 0) {
      setState(() {
        selectedLesson = "Bilgisayar Güvenliği";
        selectedLessonStudents = Students.bilgisayarGuvenligi;
        selectedStudents = Students.selectedGuvenlik;
        goToStart(1);
      });
    } else if (i == 1) {
      setState(() {
        selectedLesson = "Elektronik İmalat Teknolojileri";
        selectedLessonStudents = Students.imalat;
        selectedStudents = Students.selectedImalat;
        goToStart(1);
      });
    } else {
      setState(() {
        selectedLesson = "Sayısal Elektronik";
        selectedLessonStudents = Students.sayisalElektronik;
        selectedStudents = Students.selectedSayisal;
        goToStart(1);
      });
    }
  }

  goToStart(int duration) {
    sc.animateTo(0, duration: Duration(seconds: duration), curve: Curves.ease);
  }

  void jumpToSelected(int i, double slide) {
    sc
        .animateTo(slide, duration: Duration(seconds: 1), curve: Curves.ease)
        .then((value) =>
        setState(() {
          selectedindex = i;
          selectedStudents.add(selectedLessonStudents[selectedindex]);
          sleep(const Duration(milliseconds: 500));
          selectedLessonStudents.removeAt(selectedindex);
        }));
  }

  void actionSheet() {
    showAdaptiveActionSheet(
      context: context,
      actions: <BottomSheetAction>[
        BottomSheetAction(
            title: 'Bilgisayar Güvenliği',
            onPressed: () {
              choiceLesson(0);
            }),
        BottomSheetAction(
            title: 'Elektronik İmalat Teknolojileri',
            onPressed: () {
              choiceLesson(1);
            }),
        BottomSheetAction(
            title: 'Sayısal Elektronik',
            onPressed: () {
              choiceLesson(2);
            }),
      ],
      cancelAction: CancelAction(title: 'Cancel'),
    );
  }

  victimsWidgets() {
    return ListView.builder(
      itemCount: selectedLessonStudents.length,
      physics: AlwaysScrollableScrollPhysics(),
      controller: sc,
      itemBuilder: (BuildContext context, int i) {
        return Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(5),
          alignment: Alignment.center,
          width: 100,
          height: 100,
          child: Text(
            selectedLessonStudents[i],
            style: TextStyle(fontSize: 10),
          ),
          decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
        );
      },
      scrollDirection: Axis.horizontal,
    );
  }

  turnButton() {
    return Container(
      child: FlatButton(
          onPressed: () {
            pickSomeone();
          },
          child: Text("Döndür")),
      decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.amber[700].withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]),
    );
  }

  selectedVictimsWidget() {
    return ListView.builder(
        itemCount: selectedStudents.length,
        controller: sc2,
        itemBuilder: (BuildContext context, int i) {
          return Card(
            child: Text(
              selectedStudents[i],
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            color: i == 0
                ? Colors.transparent
                : Colors.red[i < 9 ? 900 - i * 100 : 100],
            elevation: 0,
          );
        });

  }


}
