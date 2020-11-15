import 'package:dustbin_mangment/LoadingScreen.dart';
import 'package:dustbin_mangment/components/regbutton.dart';
import 'package:dustbin_mangment/screens/auth/form_constraints.dart';
import 'package:dustbin_mangment/screens/map/driver_map.dart';
import 'package:dustbin_mangment/utils/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dustbin_mangment/screens/home/HomeScreen.dart';
import 'package:international_phone_input/international_phone_input.dart';

class RegisterPage extends StatefulWidget {
  final Function toggleView;
  RegisterPage({this.toggleView});
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool loading = false;
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String address = '';
  String fullName = '';
  String nicNumber = '';
  double fieldRadius = 25;
  String error = '';
  String phoneNumber;
  String phoneIsoCode;
  String confirmedNumber;

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      phoneNumber = number;
      phoneIsoCode = isoCode;
    });
  }

  onValidPhoneNumber(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      confirmedNumber = internationalizedPhoneNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget registerForm = Container(
      height: MediaQuery.of(context).size.height / 1.15,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.8),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          )),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(10.0)),
              Container(
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  decoration: textInputDecoration.copyWith(
                      errorStyle: TextStyle(height: 0),
                      hintText: 'Full Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(fieldRadius))),
                  validator: (val) =>
                      val == null || val.trim() == '' ? '' : null,
                  onChanged: (val) => setState(() => fullName = val),
                ),
              ),
              Padding(padding: EdgeInsets.all(3.0)),
              Container(
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  decoration: textInputDecoration.copyWith(
                      errorStyle: TextStyle(height: 0),
                      hintText: 'Address',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(fieldRadius))),
                  validator: (val) =>
                      val == null || val.trim() == '' ? '' : null,
                  onChanged: (val) => setState(() => address = val),
                ),
              ),
              Padding(padding: EdgeInsets.all(3.0)),
              Container(
                width: MediaQuery.of(context).size.width,
                child: InternationalPhoneInput(
                    hintText: "eg:0772009803",
                    onPhoneNumberChange: onValidPhoneNumber,
                    initialPhoneNumber: confirmedNumber,
                    initialSelection: phoneIsoCode,
                    enabledCountries: ['+94'],
                    labelText: 'Phone Number'),
              ),
              Padding(padding: EdgeInsets.all(3.0)),
              Container(
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  decoration: textInputDecoration.copyWith(
                      errorStyle: TextStyle(height: 0),
                      hintText: 'NIC Number',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(fieldRadius))),
                  validator: (val) =>
                      val == null || val.trim() == '' ? '' : null,
                  onChanged: (val) => setState(() => nicNumber = val),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 3.0)),
              Container(
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  decoration: textInputDecoration.copyWith(
                      errorStyle: TextStyle(height: 0),
                      hintText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(fieldRadius))),
                  validator: (val) =>
                      val == null || val.trim() == '' ? '' : null,
                  onChanged: (val) => setState(() => email = val),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 3.0)),
              Container(
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  decoration: textInputDecoration.copyWith(
                      errorStyle: TextStyle(height: 0),
                      hintText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(fieldRadius))),
                  validator: (val) =>
                      val == null || val.trim() == '' ? '' : null,
                  onChanged: (val) => setState(() => password = val),
                ),
              ),
              SizedBox(height: 12.0),
              Container(
                  child: Center(
                      child: Regbutton(
                onPress: () async {
                  if (_formKey.currentState.validate()) {
                    setState(() => loading = true);
//
//                             User user = new User(email, uname, fname, lname, city,
//                                 district, address, confirmedNumber, 0, 0, "");
                    //
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (_) =>
                    //         ConfirmOtpPage(user, password, widget.fromCart)));
                  }
                },
                typeText: Text('register',
                    style: const TextStyle(
                        color: const Color(0xfffefefe),
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        fontSize: 20.0)),
              ))),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
    );
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Sign In'),
                  onPressed: () => widget.toggleView(),
                ),
              ],
            ),
            resizeToAvoidBottomPadding: false,
            body: Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/main.jpg'),
                      fit: BoxFit.cover)),
              child: registerForm,
            ),
          );
  }
}
