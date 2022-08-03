
import 'package:ache_entregas/ui/pages/sinup.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class Primeira extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.orange[800],
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10),
                width: size.width,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
                  color: Colors.white,
                ),
                child: Image.asset("assets/logo.png", width: 30, fit: BoxFit.cover,),
              ),
              SizedBox(
                height: 100,
              ),
              Container(
                child: Text(
                  'Vamos \n Trabalhar?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 50, color: Colors.white, fontFamily: font1),
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Image.asset('assets/icons/home/seta.png', scale: 2,),
              SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => Sinup(),
                    ),
                  );
                },
                child: Container(
                  width: 250,
                  height: 60,
                  decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 3.0,
                        offset: Offset(0.0, 0.75),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      'Me cadastrar',
                      style: TextStyle(
                        color: Colors.orange[800],
                        fontSize: 35,fontFamily: font1
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

