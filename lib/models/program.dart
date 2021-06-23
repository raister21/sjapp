import 'package:flutter/material.dart';

class Program {
  final String programName;
  bool isSelected = false;
  final Icon programIcon;
  final Icon programIconEnabled;

  Program({this.programName, this.programIcon, this.programIconEnabled});
}
