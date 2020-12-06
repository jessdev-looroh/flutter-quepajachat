import 'package:flutter/material.dart';

class CustomBoton extends StatelessWidget {
  final Function onPressed;
  final String text;
  const CustomBoton({
    @required this.onPressed,
    @required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      width: double.infinity,
      height: 50,
      child: RaisedButton(
        highlightElevation: 5,
        elevation: 2,
        shape: StadiumBorder(),
        onPressed: onPressed,
        child: Text(text, style: TextStyle(color: Colors.white)),
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
