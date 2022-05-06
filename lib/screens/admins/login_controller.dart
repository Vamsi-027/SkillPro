// This file takes care about the Google Login and logout.

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final _googleSignIn = GoogleSignIn();
  var googleAccount = Rx<GoogleSignInAccount?>(null);
  login() async {
    googleAccount.value = await _googleSignIn.signIn();
  }

  logout() async {
    googleAccount.value = await _googleSignIn.signOut();
  }
}

var controller = Get.put(LoginController());



// class LoginController extends ChangeNotifier {
//   final googleSignIn = GoogleSignIn();
//   GoogleSignInAccount? _user;
//   GoogleSignInAccount get user => _user!;
//   Future login() async {
//     final googleUser = await googleSignIn.signIn();
//     if (googleUser == null) return buildLogin();
//     _user = googleUser;
//     final googleAuth = await googleUser.authentication;

//     final credential = GoogleAuthProvider.credential(
//       idToken: googleAuth.idToken,
//       accessToken: googleAuth.accessToken,
//     );

//     await FirebaseAuth.instance.signInWithCredential(credential);
//     notifyListeners();
//   }
// }


