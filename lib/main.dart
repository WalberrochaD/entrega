import 'dart:async';

import 'package:ache_entregas/ui/pages/primeira.dart';
import 'package:ache_entregas/ui/pages/sinup-veiculo.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ui/pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _splash = true;

  var token;

  void splash() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
    // token = prefs.clear();
    Timer(Duration(seconds: 3), () {
      // print('Passou no timer');
      // print(DateTime.now());
      // print(DateTime.now().second);
      setState(() {
        _splash = false;
      });
    });
  }

  @override
  void initState() {
    splash();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ache Entregas',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: _splash == true
          ? Container(
              color: Colors.white,
              child: Center(child: Image.asset("assets/logo.png")),
            )
          : token == ''
              ? Primeira()
              : SinupVeiculo(),
    );
  }
}
