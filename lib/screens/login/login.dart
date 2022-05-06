import 'package:firstskillpro/Services/api.dart';
import 'package:firstskillpro/screens/login/build_login.dart';
import 'package:firstskillpro/screens/faculty/logged_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  bool first = true;
  bool isLoggedIn = false;
  bool loading = true;
  late Api obj;

  void getData() async {
    isLoggedIn = await obj.getLoginStatus();
    if (isLoggedIn) {
      bool k = await obj.loginStatusCheck(
          mail: obj.globalEmail, password: obj.globalPassword);
      if (k) {
        if (!mounted) return;
        setState(() {
          loading = false;
        });
      }
    } else {
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

    return Scaffold(
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : isLoggedIn
              ?
              // (obj.loginCheck!.role == 'faculty' &&
              //         obj.loginCheck!.status == 'True')
              //     ? const FacultyLoggedIn()
              //     : (obj.loginCheck!.role == 'admin' &&
              //             obj.loginCheck!.status == 'True')
              //         ? const SampleAdmin()
              //         : const BuildLogin()
              const FacultyLoggedIn()
              : const BuildLogin(),
    );
  }
}
