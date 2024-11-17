import 'package:flutter/material.dart';

class CustomDialogs{
  static void showFailureDialog(BuildContext context, String text){
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        content: Text(text),
      ),
    );
  }
}