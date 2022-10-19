import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomWhiteButton extends StatelessWidget {
  const CustomWhiteButton(
      {Key? key, required this.text, required this.onPressed})
      : super(key: key);
  final String text;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 150,
      margin: EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Color(0xFF0E85FF),
            fontSize: 22.5,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
