import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  String label;
  bool obscure;
  IconButton? icon;
  TextEditingController textController = TextEditingController();
  FormFieldValidator<String> callBack;
  MyTextField(
      {required this.label,
      required this.textController,
      required this.obscure,
      required this.callBack,
      this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width * 0.85,
      child: TextFormField(
        obscureText: obscure,
        controller: textController,
        validator: callBack,
        keyboardType: TextInputType.number,
        style: const TextStyle(
          backgroundColor: Color.fromRGBO(0, 0, 0, 0),
          color: Colors.black,
          fontSize: 22,
        ),
        decoration: InputDecoration(
          suffixIcon: icon,
          filled: true,
          fillColor: Colors.white,
          labelStyle: TextStyle(color: Colors.black54),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black12, width: 1.0),
          ),
          contentPadding: EdgeInsets.all(18),
          hintText: label,
          hintStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black45,
          ),
        ),
      ),
    );
  }
}
