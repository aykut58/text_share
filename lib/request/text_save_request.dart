// ignore: unused_import
import 'package:flutter/material.dart';

class TextSaveRequest 
{
  //TimeOfDay? timeOfDay;
  String? dateTime;
  String? text;

  Map<String ,dynamic> toJson() => 
  {
    "expireDate" : dateTime,
    "text" : text
  };
}