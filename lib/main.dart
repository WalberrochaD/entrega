import 'dart:async';

import 'package:ache_entregas/ui/models/location.dart';
import 'package:ache_entregas/ui/pages/primeira.dart';
import 'package:ache_entregas/ui/pages/sinup-veiculo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ui/pages/home.dart';

void main() {
  runApp(MyApp());
  Location().getPosition();
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _splash = true;

  var token;
  String? vehicle;

  void splash() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
    vehicle = prefs.getString('vehicle');
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Location())
      ],
      child: MaterialApp(
        title: 'Ache Entregas',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: _splash == true
            ? Container(
                color: Colors.white,
                child: Center(child: Image.asset("assets/logo.png")),
              )
            :  token == ''
                ? Primeira()
                : vehicle == '' ? SinupVeiculo(view: false,): Home(),
      ),
    );
  }
}

// "{  
//   'placa': '4444',         
//   'chassi': '3466',          
//   'vehicleTypeId': 1,         
//   'dealership': 'teste2',
//   'modelCar': 'teste2'
// }"