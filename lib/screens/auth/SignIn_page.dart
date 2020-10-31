import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {

  final Function toggleView;
  SignInPage({this.toggleView});


  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {

    Widget welcomeBack = Text(
         'Welcome Driver',
        style: TextStyle(
            color: Color.fromRGBO(25, 35, 45, 1),
            fontSize: 50.0,
            fontWeight: FontWeight.bold)
    );

    Widget loginButton = Positioned(
      left: MediaQuery.of(context).size.width / 6,
      bottom: 10,
      child: InkWell(
        onTap: () async {


          // if (_formKey.currentState.validate()) {
          //
          //
          //   // dynamic result =
          //   // await _auth.signInWithEmailAndPass(email, password);
          //   //
          //   //
          //
          //   if () {}
          //
          //   else{
          //     showCupertinoDialog(
          //         context: context,
          //         builder: (context) => CupertinoAlertDialog(
          //           content: Text(
          //               "Login failed. Please try again!"),
          //           actions: <Widget>[
          //             CupertinoButton(
          //                 child: Text("Ok"),
          //                 onPressed: () {
          //                   Navigator.pop(context);
          //                 }),
          //           ],
          //         ));
          //   }
          // }
          //


        },
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: 80,
          child: Center(
              child: new Text('Log In',
                  style: const TextStyle(
                      color: const Color(0xfffefefe),
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      fontSize: 20.0))),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xFF0D47A1),
                    Color(0xFF1976D2),
                    Color(0xFF42A5F5),
                  ],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.16),
                  offset: Offset(0, 5),
                  blurRadius: 10.0,
                )
              ],
              borderRadius: BorderRadius.circular(50.0)),
        ),
      ),
    );

    Widget loginForm = Container(
      height: 260,
      child: Stack(
        children: <Widget>[
          Container(
            height: 160,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.8),
                borderRadius: BorderRadius.circular(9.0),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0),
                    offset: Offset(0, 5),
                    blurRadius: 10.0,
                  )
                ]),
            child: Form(
              key: _formKey,
//              mainAxisAlignment: MainAxisAlignment.start,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Your Email',
                      ),
                      validator: (val) => val.isEmpty ?'Please enter your Email' : null,
                      onChanged: (val) => setState(() => email = val ),
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Your Password',

                      ),
                      validator:(val) =>val.isEmpty ? 'Please enter your password':null,
                      onChanged: (val)=> setState(() =>password = val),
                      style: TextStyle(fontSize: 16.0),
                      obscureText: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          loginButton,
        ],
      ),
    );


    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        actions:<Widget> [
          FlatButton.icon(
              onPressed:() => widget.toggleView() ,
              icon: Icon(Icons.person),
          label: Text('Register')
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/main.jpg'),
                    fit: BoxFit.cover)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 20.0,
                  height: 70.0,
                ),
                welcomeBack,
                Spacer(flex: 1),
                loginForm,
                Spacer(flex: 2),
                // forgotPassword
              ],
            ),
          ),
          //*Positioned(
          // top: 35,
          // left: 0,
          // child: IconButton(
          // color: Colors.black,
          // icon: Icon(Icons.arrow_back),
          // onPressed: () {
          // Navigator.pop(context);
          //},
          //),
          //)
        ],
      ),




    );
  }
}
