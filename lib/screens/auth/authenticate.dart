import 'package:dustbin_mangment/screens/auth/Register_page.dart';
import 'package:dustbin_mangment/screens/auth/SignIn_page.dart';
import 'package:flutter/material.dart';


class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void toggleView(){
    //print(showSignIn.toString());
    setState(() => showSignIn = !showSignIn);
  }


  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignInPage(toggleView:  toggleView);
    } else {

      return RegisterPage(toggleView:  toggleView);
      //

    }
  }
}
