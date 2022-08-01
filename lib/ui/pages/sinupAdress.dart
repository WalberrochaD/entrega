import 'dart:convert';

import 'package:ache_entregas/ui/models/user.dart';
import 'package:ache_entregas/ui/pages/sinup-veiculo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../widgets/masked.dart';

class SinupAdressPage extends StatefulWidget {
  final String email;
  final String password;
  final String confirmPassword;
  final String name;
  final String cpf;
  final String cnh;
  final String dataNc;
  final String phone;

  const SinupAdressPage(
      {required this.email,
      required this.password,
      required this.confirmPassword,
      required this.name,
      required this.cpf,
      required this.cnh,
      required this.dataNc,
      required this.phone,
      Key? key})
      : super(key: key);

  @override
  State<SinupAdressPage> createState() => _SinupAdressPageState();
}

class _SinupAdressPageState extends State<SinupAdressPage> {
  var _cepController = MaskedTextController(mask: '00000-000');
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _streetController = TextEditingController();
  TextEditingController _numberController = TextEditingController();

  widgetTextField(TextEditingController controler, TextInputType textInputType,
      String labelText) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: size.height * 0.02, vertical: 5),
      child: TextFormField(
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
      ),
    );
  }

  bool _isLoading = false;
  register() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoading = true;
    });
    UserModel user = UserModel(
      cep: _cepController.text,
      cnh: widget.cnh,
      cpf: widget.cpf,
      dataNc: '2022-04-05T20:45:13.758Z',
      email: widget.email,
      name: widget.name,
      password: widget.password,
    );

    await http
        .post(Uri.parse('$url/userDeliver/register'),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(user.toJson()))
        .then((value) {
          final json = jsonDecode(value.body);
      print('body: ${value.body}');
      print('status: ${value.statusCode}');
      if (value.statusCode == 200) {
        prefs.setString('token', json['token'].toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Perfil criado!')));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SinupVeiculo()));
        setState(() => _isLoading = false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Algo deu errado, verifique os dados!')));
        Navigator.of(context).pop();
        setState(() => _isLoading = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          color: Colors.orange[800],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 35,
              ),
              Text(
                'Cadastre seu endereço',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white, fontSize: 32, fontFamily: font1),
              ),
              widgetTextField(_cepController, TextInputType.number, 'CEP'),
              widgetTextField(_stateController, TextInputType.name, 'Estado'),
              widgetTextField(_cityController, TextInputType.name, 'Cidade'),
              widgetTextField(_streetController, TextInputType.name, 'Rua'),
              widgetTextField(
                  _numberController, TextInputType.number, 'Número'),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  register();
                },
                child: Container(
                  width: size.width * 0.6,
                  height: 70,
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
                      child: _isLoading == true
                          ? CircularProgressIndicator(
                              color: Colors.orange[800],
                            )
                          : Text(
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
            ],
          ),
        ),
      ),
    );
  }
}
