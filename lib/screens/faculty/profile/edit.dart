import 'package:flutter/material.dart';
import 'package:firstskillpro/utils/styling.dart';
import 'package:google_fonts/google_fonts.dart';

class Edit extends StatefulWidget {
  const Edit({Key? key}) : super(key: key);
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "EDIT DETAILS",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: TextFormField(
                style: GoogleFonts.poppins(color: Colors.black),
                cursorColor: Colors.black,
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.left,
                onChanged: (text) {},
                decoration: InputDecoration(
                  hintText: "Enter Email",
                  hintStyle: GoogleFonts.poppins(color: Colors.black),
                  prefixIcon: Icon(
                    Icons.email_rounded,
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: TextFormField(
                style: GoogleFonts.poppins(color: Colors.black),
                cursorColor: Colors.black,
                keyboardType: TextInputType.name,
                textAlign: TextAlign.left,
                onChanged: (text) {},
                decoration: InputDecoration(
                  hintText: "Name",
                  hintStyle: GoogleFonts.poppins(color: Colors.black),
                  prefixIcon: Icon(
                    Icons.person_rounded,
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: TextFormField(
                style: GoogleFonts.poppins(color: Colors.black),
                cursorColor: Colors.black,
                keyboardType: TextInputType.phone,
                textAlign: TextAlign.left,
                onChanged: (text) {},
                decoration: InputDecoration(
                  hintText: "Phone Number",
                  hintStyle: GoogleFonts.poppins(color: Colors.black),
                  prefixIcon: Icon(
                    Icons.dialpad_rounded,
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                ),
              ),
            ),
            Container(
              width: width - (width * 0.10),
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Submit",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 20,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  primary: secondaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


