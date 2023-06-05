import 'package:flutter/material.dart';

class Text_Field_Icon extends StatelessWidget {
  final String hint_text;
  final icon;
  final TextEditingController controller;
  const Text_Field_Icon({Key? key, required this.hint_text, required this.icon, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20).copyWith(top: 0),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.deepOrangeAccent,
            width: 2,

          ),
          borderRadius: BorderRadius.all(Radius.circular(8))
      ),

      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            prefixIcon: icon,
            hintText: hint_text,
            hintStyle: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
            contentPadding: EdgeInsets.only(top: 14),
            prefixIconColor: Colors.deepOrangeAccent
        ),

      ),
    );
  }
}
