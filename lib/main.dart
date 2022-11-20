import 'package:api_using/Home_page.dart';
import 'package:api_using/example_four.dart';
import 'package:api_using/example_three.dart';
import 'package:api_using/example_tow.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: ExampleFoue()
    );
  }
}

