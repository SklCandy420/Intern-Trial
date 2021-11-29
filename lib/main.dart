import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/homePage.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
    theme: ThemeData(hintColor: Colors.white),
    debugShowCheckedModeBanner: false,
  ));
}
