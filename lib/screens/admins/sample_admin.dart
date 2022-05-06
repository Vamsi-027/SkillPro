import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firstskillpro/utils/styling.dart';
import 'facultydbtable.dart';
import 'package:firstskillpro/screens/admins/login_controller.dart';

class SampleAdmin extends StatefulWidget {
  const SampleAdmin({Key? key}) : super(key: key);

  @override
  _SampleAdminState createState() => _SampleAdminState();
}

class _SampleAdminState extends State<SampleAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome", style: GoogleFonts.poppins()),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 120,
              height: 100,
              margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage("assets/login.jpg"), fit: BoxFit.fill),
              ),
            ),
            Text(
              "Name",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Divider(
              height: 20.00,
              thickness: 2.00,
              color: Colors.black,
            ),
            ExpansionTile(
              // collapsedBackgroundColor: Colors.indigo,
              title: Text("Student"),
              children: [
                ListTile(
                  title: Text("2017-2021"),
                  trailing: Icon(Icons.edit),
                ),
                ListTile(
                  title: Text("2018-2022"),
                  trailing: Icon(Icons.edit),
                ),
                ListTile(
                  title: Text("2019-2023"),
                  trailing: Icon(Icons.edit),
                ),
              ],
            ),
            ListTile(
              title: Text("Faculty"),
              trailing: Icon(Icons.edit),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => FacultyDb()));
              },
            ),
            ListTile(
              title: Text("Admin"),
              trailing: Icon(Icons.edit),
            ),
            ListTile(
              leading: Icon(Icons.logout_rounded),
              title: Text("Logout", style: poppins),
              onTap: () {
                controller.logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
