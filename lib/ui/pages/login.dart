// import 'package:firebase_auth/firebase_auth.dart';
// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:convert';

import 'package:ache_entregas/ui/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool progress = false;
  GlobalKey<FormState> _form = GlobalKey();

  Future<void> login() async {
    if (!_form.currentState!.validate()) {
      return;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      progress = true;
    });

    http
        .post(
      Uri.parse('$url/userDeliver/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": _emailController.text,
        "password": _passwordController.text
      }),
    )
        .then((value) {
      final json = jsonDecode(value.body);
      print(json);
      if (json['error'] == "Usuario Não Encontrado" || value.statusCode != 200) {
        setState(() {
          progress = false;
        });
        return ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Usuario não encontrado",
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(
                    Icons.error,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          );
      } else if (json['token'].toString().isNotEmpty && value.statusCode == 200) {
        prefs.setString('token', json['token'].toString());
        print(json['token'].toString());
        
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (ctx) => Home()));
      }
        setState(() {
          progress = false;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.orange[800],
          // image: DecorationImage(
          //   image: AssetImage('assets/icons/fundo.png'),
          //   fit: BoxFit.cover,
          // ),
        ),
        child: Container(
          height: size.height,
          width: size.width,
          color: Color.fromRGBO(239, 109, 0, 35),
          child: Form(
            key: _form,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: size.width,
                    height: size.height / 3,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Fazer login',
                    style: TextStyle(
                        color: Colors.white, fontSize: 30, fontFamily: font1),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.height * 0.02, vertical: 5),
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.length < 8 || !value.contains('@')) {
                          return "E-mail inválido";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.white),
                        labelText: "E-mail",
                        labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 27,
                            fontFamily: font1),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: font1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.height * 0.02, vertical: 5),
                    child: TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.length < 6) {
                          return "Senha inválido";
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.white),
                        labelText: "Senha",
                        labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 27,
                            fontFamily: font1),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: font1,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: size.width * .6,
                    decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black54,
                            blurRadius: 5.0,
                            offset: Offset(0.0, 0.75),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.white),
                    child: TextButton(
                      onPressed: () {
                        login();
                        // Navigator.of(context).push(
                        //     MaterialPageRoute(builder: (context) => Home()));
                      },

                      // shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(40)),
                      // highlightElevation: 1,
                      // borderSide: BorderSide(color: Colors.white),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: progress == true
                                ? CircularProgressIndicator(
                                    color: backgroundColor,
                                  )
                                : Text(
                                    'Entrar',
                                    style: TextStyle(
                                      color: Colors.orange[800],
                                      fontSize: size.height * .04,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

OutlineButton(
    {required MaterialColor splashColor,
    required Null Function() onPressed,
    required RoundedRectangleBorder shape,
    required int highlightElevation,
    required BorderSide borderSide,
    required Row child}) {}
