// Creates the login Page
// This page is common for any type of User
// This is initialized whenever user open the application

import 'package:firstskillpro/Services/api.dart';
import 'package:firstskillpro/screens/faculty/logged_in.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../admins/login_controller.dart';
import 'package:sign_button/sign_button.dart';
import 'package:firstskillpro/utils/styling.dart';

class BuildLogin extends StatefulWidget {
  const BuildLogin({Key? key}) : super(key: key);

  @override
  _BuildLoginState createState() => _BuildLoginState();
}

class _BuildLoginState extends State<BuildLogin> {
  bool _isHidden = true;
  bool loading = false;
  late Api obj;
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    obj = Provider.of<Api>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(
            "WELCOME",
            style: GoogleFonts.baloo(
              letterSpacing: 5,
              fontSize: 30,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image(
                    height: (height * 0.30),
                    image: const AssetImage(
                      'assets/login.jpg',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: TextFormField(
                  style: GoogleFonts.poppins(color: Colors.white),
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.left,
                  onChanged: (text) {
                    setState(() {
                      email = text;
                    });
                  },
                  decoration: InputDecoration(
                    fillColor: primaryColor,
                    filled: true,
                    hintText: "Enter Email",
                    hintStyle: GoogleFonts.poppins(color: Colors.white),
                    prefixIcon: const Icon(
                      Icons.account_circle,
                      color: Colors.white,
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: TextFormField(
                  style: GoogleFonts.poppins(color: Colors.white),
                  obscureText: _isHidden,
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (text) {
                    setState(() {
                      password = text;
                    });
                  },
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    fillColor: primaryColor,
                    filled: true,
                    hintText: "Enter Password",
                    hintStyle: GoogleFonts.poppins(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    prefixIcon: const Icon(
                      Icons.lock_rounded,
                      color: Colors.white,
                    ),
                    suffixIcon: IconButton(
                        color: Colors.white,
                        onPressed: () {
                          setState(() {
                            _isHidden = !_isHidden;
                          });
                        },
                        icon: Icon(_isHidden
                            ? Icons.visibility
                            : Icons.visibility_off)),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "FORGOT PASSWORD?",
                        style: GoogleFonts.poppins(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: width - (width * 0.10),
                child: ElevatedButton(
                  onPressed: loading
                      ? null
                      : () async {
                          setState(() {
                            loading = true;
                          });
                          bool k = await obj.loginStatusCheck(
                              mail: email, password: password);
                          if (k) {
                            setState(() {
                              loading = false;
                            });
                            Navigator.pushAndRemoveUntil<dynamic>(
                              context,
                              MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) =>
                                    const FacultyLoggedIn(),
                              ),
                              (route) => false,
                            );
                          }
                        },
                  child: loading
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Text(
                          "LOGIN",
                          style: GoogleFonts.baloo(
                            letterSpacing: 5,
                            fontSize: 30,
                          ),
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
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
                child: Row(
                  children: <Widget>[
                    const Expanded(
                      child: Divider(
                        color: Colors.black,
                        thickness: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text(
                        "Login Or SignUp With",
                        style: GoogleFonts.poppins(
                            textStyle:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        color: Colors.black,
                        thickness: 2,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SignInButton.mini(
                    elevation: 15,
                    buttonType: ButtonType.google,
                    onPressed: () {
                      controller.login();
                    },
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
