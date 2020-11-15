import 'package:dustbin_mangment/components/app_properties.dart';
import 'package:flutter/material.dart';

class Regbutton extends StatelessWidget {
  Regbutton({@required this.onPress, @required this.typeText});

  final Function onPress;
  final Text typeText;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        height: 70,
        child: Center(child: typeText),
        decoration: BoxDecoration(
            gradient: mainButton,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.16),
                offset: Offset(0, 5),
                blurRadius: 10.0,
              )
            ],
            borderRadius: BorderRadius.circular(50.0)),
      ),
    );
  }
}
