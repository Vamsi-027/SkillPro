import 'package:firstskillpro/Services/api.dart';
import 'package:firstskillpro/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'edit.dart';
import 'package:firstskillpro/utils/styling.dart';

class FacultyProfile extends StatefulWidget {
  const FacultyProfile({Key? key}) : super(key: key);

  @override
  _FacultyProfileState createState() => _FacultyProfileState();
}

class _FacultyProfileState extends State<FacultyProfile> {
  late Api obj;
  @override
  Widget build(BuildContext context) {
    obj = Provider.of<Api>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _getHeader(),
            const SizedBox(
              height: 5,
            ),
            _profileName(obj.profileData.first.name),
            const Divider(
              height: 10,
            ),
            _heading("Personal Details"),
            const SizedBox(
              height: 6,
            ),
            _detailsCard(),
            const SizedBox(
              height: 10,
            ),
            _heading("Settings"),
            const SizedBox(
              height: 6,
            ),
            _settingsCard(),
          ],
        ),
      ),
    );
  }

  Widget _getHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Padding(
          padding: EdgeInsets.all(15.0),
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 5, 10, 0),
            child: CircleAvatar(
              child: Text('a'),
              radius: 40,
            ),
          ),
        ),
      ],
    );
  }

  Widget _profileName(String name) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.80, //80% of width,
      child: Center(
        child: Text(name, style: GoogleFonts.baloo(fontSize: 24)),
      ),
    );
  }

  Widget _heading(String heading) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.80, //80% of width,
      child: Text(
        heading,
        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _detailsCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.email),
              title: Text(obj.profileData.first.name, style: poppins),
            ),
            const Divider(
              height: 0.6,
              color: Colors.black87,
            ),
            ListTile(
              leading: const Icon(Icons.phone_android_rounded),
              title: Text(obj.profileData.first.phone, style: poppins),
            ),
            const Divider(
              height: 0.6,
              color: Colors.black87,
            ),
            obj.profileData.first.role == 'faculty'
                ? Container()
                : ListTile(
                    leading: const Icon(Icons.badge_rounded),
                    title: Text(obj.profileData.first.batch, style: poppins),
                  ),
            const Divider(
              height: 0.6,
              color: Colors.black87,
            ),
          ],
        ),
      ),
    );
  }

  Widget _settingsCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            ListTile(
              leading: const Icon(
                Icons.edit,
              ),
              title: Text('Edit', style: poppins),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Edit()));
              },
            ),
            const Divider(
              height: 0.6,
              color: Colors.black87,
            ),
            ListTile(
              leading: const Icon(Icons.info_rounded),
              title: Text("About", style: poppins),
            ),
            const Divider(
              height: 0.6,
              color: Colors.black87,
            ),
            ListTile(
              leading: const Icon(Icons.logout_rounded),
              title: Text("Logout", style: poppins),
              onTap: () async {
                bool k = await obj.removeLoginStatus();
                if (k) {
                  Navigator.pushAndRemoveUntil<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) => const LoginWidget(),
                    ),
                    (route) => false,
                  );
                }
              },
            ),
            const Divider(
              height: 0.6,
              color: Colors.black87,
            ),
          ],
        ),
      ),
    );
  }
}
