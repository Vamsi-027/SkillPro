import 'package:flutter/material.dart';
import 'package:firstskillpro/utils/styling.dart';
import 'mentoring.dart';
import 'references.dart';

class FacultyToDo extends StatefulWidget {
  const FacultyToDo({Key? key}) : super(key: key);

  @override
  _FacultyToDoState createState() => _FacultyToDoState();
}

class _FacultyToDoState extends State<FacultyToDo> {
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8),
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: AppBar(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 20,
                shadowColor: primaryColor,
                backgroundColor: secondaryColor,
                bottom: TabBar(
                  indicatorColor: Colors.white,
                  unselectedLabelColor: Colors.blueGrey,
                  tabs: [
                    Tab(
                      icon: Icon(Icons.auto_stories_rounded),
                      text: 'References',
                    ),
                    Tab(
                      icon: Icon(Icons.group_rounded),
                      text: '1-1 Mentoring',
                    ),
                  ],
                ),
              ),
            ),
            body: TabBarView(
              children: [
                buildPage('References'),
                buildPage('1-1 Mentoring'),
              ],
            ),
          ),
        ),
      );

  Widget buildPage(String text) {
    if (text == 'References') {
      return FacultyReferences();
    } else {
      return Mentoring();
    }
  }
}
