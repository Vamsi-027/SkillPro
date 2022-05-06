// This file will run after the successful login of the faculty
// It contains three main widgets, they are 1.Profile 2. Dashboard 3.To-Do

import 'package:firstskillpro/Services/api.dart';
import 'package:firstskillpro/screens/faculty/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:firstskillpro/utils/styling.dart';
import 'package:provider/provider.dart';
import 'dashboard/dashboard.dart';
import 'todo/to_do.dart';

class FacultyLoggedIn extends StatefulWidget {
  const FacultyLoggedIn({Key? key}) : super(key: key);

  @override
  _FacultyLoggedInState createState() => _FacultyLoggedInState();
}

class _FacultyLoggedInState extends State<FacultyLoggedIn> {
  int currentIndex = 1;
  final tabs = [
    const FacultyProfile(),
    const FacultyDashBoard(),
    const FacultyToDo(),
  ];
  bool first = true;
  bool loading = true;
  late Api obj;
  void getData() async {
    bool k = await obj.specialityStatusCheck(mail: obj.globalEmail);
    bool m = await obj.getProfile(email: obj.globalEmail);
    if (k && m) {
      if (!mounted) return;
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    obj = Provider.of<Api>(context);
    if (first) {
      first = false;
      getData();
    }
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(32), topRight: Radius.circular(32)),
          child: BottomNavigationBar(
            selectedLabelStyle: poppins,
            currentIndex: currentIndex,
            onTap: (index) => setState(() {
              currentIndex = index;
            }),
            type: BottomNavigationBarType.shifting,
            unselectedItemColor: Colors.blueGrey,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.person_rounded),
                label: 'Profile',
                backgroundColor: primaryColor,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.dashboard_rounded),
                label: 'Dashboard',
                backgroundColor: primaryColor,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.pending_actions_rounded),
                label: 'To do',
                backgroundColor: primaryColor,
              ),
            ],
          ),
        ),
        body: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : tabs[currentIndex],
      ),
    );
  }
}
