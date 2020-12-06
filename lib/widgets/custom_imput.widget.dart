import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool oscureText;
  final TextEditingController textController;
  final TextInputType keyboardType;
  const CustomTextField({
    @required this.hintText,
    @required this.icon,
    @required this.textController,
    this.oscureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(50), boxShadow: [
          BoxShadow(
              color: Colors.grey[300], blurRadius: 10, offset: Offset(0, 5)),
        ]),
        child: TextField(
          controller: textController,
          autocorrect: false,
          keyboardType: keyboardType,
          obscureText: oscureText,
          cursorColor: Theme.of(context).primaryColor,
          decoration: InputDecoration(
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(50),
            ),
            fillColor: Colors.white,
            prefixIcon: Icon(
              icon,
              color: Colors.grey[500],
            ),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500]),
          ),
        ),
      ),
    );
  }
}
