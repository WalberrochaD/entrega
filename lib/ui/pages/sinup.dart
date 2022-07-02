// import 'package:firebase_auth/firebase_auth.dart';
import 'package:ache_entregas/ui/pages/login.dart';
import 'package:ache_entregas/ui/pages/sinup-veiculo.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class Sinup extends StatefulWidget {
  @override
  _SinupState createState() => _SinupState();
}

class _SinupState extends State<Sinup> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _dataNCController = TextEditingController();
  final TextEditingController _telController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _ruaController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();

  // Future<void> register() async {
  //   try {
  //     FirebaseAuth.instance.createUserWithEmailAndPassword(
  //         email: _emailController.text, password: _phoneController.text);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  widgetTextField(TextEditingController controler, TextInputType textInputType,
      String labelText) {
    final size = MediaQuery.of(context).size;
    return TextFormField(
      controller: controler,
      keyboardType: textInputType,
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
          child: Column(
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
                      _nameController, TextInputType.name, 'nome')),
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.height * 0.02, vertical: 5),
                  child: widgetTextField(
                      _cpfController, TextInputType.number, 'CPF')),
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.height * 0.02, vertical: 5),
                  child: widgetTextField(
                      _dataNCController, TextInputType.name, 'Data NC')),
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.height * 0.02, vertical: 5),
                  child: widgetTextField(
                      _telController, TextInputType.phone, 'Tel')),
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.height * 0.02, vertical: 5),
                  child: widgetTextField(
                      _cidadeController, TextInputType.name, 'Cidade')),
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.height * 0.02, vertical: 5),
                  child: widgetTextField(
                      _cepController, TextInputType.number, 'CEP')),
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.height * 0.02, vertical: 5),
                  child: widgetTextField(
                      _estadoController, TextInputType.name, 'Estado')),
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.height * 0.02, vertical: 5),
                  child: widgetTextField(
                      _ruaController, TextInputType.name, 'Rua')),
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.height * 0.02, vertical: 5),
                  child: widgetTextField(
                      _numeroController, TextInputType.number, 'Numero')),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => SinupVeiculo()));
                },
                child: Container(
                  width: size.width * 0.6,
                  // height: 60,
                  decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 15.0,
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
    );
  }
}
