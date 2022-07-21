// import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';

import 'package:ache_entregas/ui/pages/login.dart';
import 'package:ache_entregas/ui/pages/sinup-veiculo.dart';
import 'package:ache_entregas/ui/pages/sinupAdress.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../widgets/masked.dart';

class Sinup extends StatefulWidget {
  @override
  _SinupState createState() => _SinupState();
}

class _SinupState extends State<Sinup> {
  final TextEditingController _nameController = TextEditingController();
  
  final TextEditingController _cnhController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  var _cpfController = MaskedTextController(mask: '000.000.000-00');
  var _telController = MaskedTextController(mask: '(00)00000-0000');
  var _dataNCController = MaskedTextController(mask: '00/00/0000');
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey();

  register() {
    if (!_form.currentState!.validate()) {
      return;
    }

    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => SinupAdressPage(
            email: _emailController.text,
            password: _passwordController.text,
            confirmPassword: _confirmPasswordController.text,
            name: _nameController.text,
            cpf: _cpfController.text,
            cnh: _cnhController.text,
            dataNc: _dataNCController.text,
            phone: _telController.text)));

    // http.post(Uri.parse(''),
    //     body: json.encode({
    //       "email": "danieltest2@test.com",
    //       "password": "danieltest@test.com",
    //       "confirmPassword": "danieltest@test.com",
    //       "CNH": _cnhController.text,
    //       "NCDate": _dataNCController.text,
    //       "cpf": _cpfController.text,
    //       "name": _nameController.text,
    //       "cep": _cepController.text
    //     }));
  }

  widgetTextField(TextEditingController controler, TextInputType textInputType,
      String labelText, String? Function(String?)? validator, {bool? obscureText}) {
    final size = MediaQuery.of(context).size;
    return TextFormField(
      controller: controler,
      keyboardType: textInputType,
      validator: validator,
      obscureText: obscureText == null ? false : true,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
            color: Colors.white,
            fontSize: size.height * 0.03,
            fontFamily: font1),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: Colors.white, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: Colors.white, width: 1.0),
        ),
        // errorBorder: InputBorder.none,
        // focusedErrorBorder: InputBorder.none,
        // errorStyle: TextStyle(
        //   color: Color.fromARGB(255, 233, 120, 120),
        // ),
      ),
      style: TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontFamily: font1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.orange[800],
          // image: DecorationImage(
          //     image: AssetImage('assets/icons/home/fundo.png'),
          //     fit: BoxFit.cover,),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Container(
                //   width: size.width,
                //   height: 170,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.only(
                //       bottomRight: Radius.circular(30),
                //       bottomLeft: Radius.circular(30),
                //     ),
                //     color: Colors.white,
                //   ),
                // ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  'Cadastre-se, é grátis.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontSize: 32, fontFamily: font1),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.height * 0.02, vertical: 5),
                    child: widgetTextField(
                        _emailController, TextInputType.emailAddress, 'E-mail',
                        (value) {
                      if (value!.length < 8 || !value.contains('@')) {
                        return "       E-mail inválido";
                      }
                      return null;
                    })),
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.height * 0.02, vertical: 5),
                    child: widgetTextField(
                        _passwordController, TextInputType.name, 'Senha',
                        (value) {
                      if (value!.length < 6) {
                        return "       Senha inválida";
                      }
                      return null;
                    }, obscureText: true)),
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.height * 0.02, vertical: 5),
                    child: widgetTextField(_confirmPasswordController,
                        TextInputType.name, 'Confirmar senha', (value) {
                      if (_passwordController.text != value) {
                        return "       Senha não corresponde";
                      }
                      return null;
                    }, obscureText: true)),
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.height * 0.02, vertical: 5),
                    child: widgetTextField(
                        _nameController, TextInputType.name, 'nome', (value) {
                      if (value!.length < 4) {
                        return "       Nome inválido";
                      }
                      return null;
                    })),
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.height * 0.02, vertical: 5),
                    child: widgetTextField(
                        _cpfController, TextInputType.number, 'CPF', (value) {
                      if (value!.length < 10) {
                        return "       Cpf inválido";
                      }
                      return null;
                    })),
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.height * 0.02, vertical: 5),
                    child: widgetTextField(
                        _cnhController, TextInputType.text, 'CNH', (value) {
                      if (value!.length < 9) {
                        return "       Núme inválido";
                      }
                      return null;
                    })),
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.height * 0.02, vertical: 5),
                    child: widgetTextField(
                        _dataNCController, TextInputType.name, 'Data NC',
                        (value) {
                      if (value!.length < 4) {
                        return "       Data Nc inválida";
                      }
                      return null;
                    })),
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.height * 0.02, vertical: 5),
                    child: widgetTextField(
                        _telController, TextInputType.phone, 'Telefone',
                        (value) {
                      if (value!.length < 9) {
                        return "       Telefone inválido";
                      }
                      return null;
                    })),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    register();
                  },
                  child: Container(
                    width: size.width * 0.6,
                    // height: 60,
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
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          'Prosseguir',
                          style: TextStyle(
                            color: Colors.orange[800],
                            fontSize: 40,
                            fontFamily: font1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (ctx) => Login()));
                  },
                  child: Text(
                    'Fazer login',
                    style: TextStyle(
                        color: Colors.white, fontFamily: font1, fontSize: 25),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
