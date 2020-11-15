import 'package:flutter/material.dart';

const Color yellow = Color(0xff03A9F4);
const Color mediumYellow = Color(0xff4FC3F7);
const Color darkYellow = Color(0xff0277BD);
const Color transparentYellow = Color.fromRGBO(2, 103, 183, 0.7);
const Color darkGrey = Color(0xff202020);

const LinearGradient mainButton = LinearGradient(colors: [
  Color(0xFF0D47A1),
  Color(0xFF1976D2),
  //Color(0xFF42A5F5),

], begin: FractionalOffset.topCenter, end: FractionalOffset.bottomCenter);

const List<BoxShadow> shadow = [
  BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 6)
];

screenAwareSize(int size, BuildContext context) {
  double baseHeight = 640.0;
  return size * MediaQuery.of(context).size.height / baseHeight;
}