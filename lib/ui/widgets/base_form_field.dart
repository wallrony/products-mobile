import 'package:flutter/material.dart';

class BaseFormField extends StatelessWidget {
  final TextEditingController _controller;
  final String hint;
  final TextInputType inputType;
  final String Function(String) validator;

  BaseFormField(
    this._controller, {
    this.hint = '',
    this.inputType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.black26,
          ),
        ],
      ),
      child: TextFormField(
        keyboardType: inputType,
        controller: _controller,
        validator: validator,
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 18,
        ),
        decoration: InputDecoration(
          errorStyle: TextStyle(
            fontSize: 12,
            height: .3,
          ),
          contentPadding: EdgeInsets.only(
            top: 8,
            bottom: 0,
          ),
          labelText: this.hint,
          labelStyle: TextStyle(
            color: Colors.black,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

typedef StringFun = String Function();
