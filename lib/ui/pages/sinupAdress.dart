import 'dart:convert';
import 'dart:io';

import 'package:ache_entregas/ui/models/user.dart';
import 'package:ache_entregas/ui/pages/login.dart';
import 'package:ache_entregas/ui/pages/sinup-veiculo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as p;

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
  File? photo;
  bool acceptTerms = false;
  bool viewTerms = false;

  widgetTextField(TextEditingController controler, TextInputType textInputType,
      String labelText) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: size.height * 0.02, vertical: 5),
      child: Container(
        height: 50,
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
      ),
    );
  }

  bool _isLoading = false;
  register() async {
    setState(() {
      _isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserModel user = UserModel(
      cep: _cepController.text,
      cnh: widget.cnh,
      cpf: widget.cpf,
      dataNc: widget.dataNc,
      email: widget.email,
      name: widget.name,
      password: widget.password,
    );
    String extension = p.extension(photo!.path);

    String day = '${widget.dataNc.substring(0, 2)}';
    String month = '${widget.dataNc.substring(3, 5)}';
    String year = '${widget.dataNc.substring(6, 10)}';
    String date = '$year-$month-$day';

    var uri = Uri.parse('$url/userDeliver/register');
    // var uri = Uri.https('https://weupback.azurewebsites.net/vehicle', 'create');
    var request = http.MultipartRequest('POST', uri)
      ..fields['deliver'] = jsonEncode({
        "cep": _cepController.text,
        "CNH": widget.cnh,
        "cpf": widget.cpf,
        "dataNc": "$date 22:16:03",
        "email": widget.email,
        "name": widget.name,
        "telephone": widget.phone,
        "password": widget.password,
        "confirmPassword": widget.password,
      })
      ..files.add(await http.MultipartFile.fromPath(
        "photo",
        photo!.path,
        contentType: MediaType('image', extension.substring(1)),
      ))
      ..headers.addAll({"Content-Type": "multipart/form-data"});

    var _result = await request.send();
    print(_result.statusCode);
    await http.Response.fromStream(_result).then((value) {
      final json = jsonDecode(value.body);
      print('body: ${value.body}');
      print('status: ${value.statusCode}');
      if (value.statusCode == 200) {
        // prefs.setString('token', json['token'].toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Perfil criado!')));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login()));
        setState(() => _isLoading = false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${json['err']}')));
        Navigator.of(context).pop();
        setState(() => _isLoading = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
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
                    'Cadastre seu endereço e sua foto',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontSize: 20, fontFamily: font1),
                  ),
                  TextButton(
                    onPressed: () async {
                      final picker = ImagePicker();
                      final getPic =
                          await picker.pickImage(source: ImageSource.gallery);
                      if (getPic != null) {
                        setState(() {
                          photo = File(getPic.path);
                        });
                      }
                    },
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: backgroundColor,
                          ),
                          height: 150,
                          width: 250,
                          margin: EdgeInsets.only(left: 20),
                          child: photo == null
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/icons/cadastro/foto.png',
                                    color: Colors.white,
                                  ))
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    photo!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: backgroundColor),
                            child: Icon(
                              Icons.arrow_upward_outlined,
                              size: 33,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                  widgetTextField(_cepController, TextInputType.number, 'CEP'),
                  widgetTextField(
                      _stateController, TextInputType.name, 'Estado'),
                  widgetTextField(
                      _cityController, TextInputType.name, 'Cidade'),
                  widgetTextField(_streetController, TextInputType.name, 'Rua'),
                  widgetTextField(
                      _numberController, TextInputType.number, 'Número'),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Switch(
                        value: acceptTerms,
                        onChanged: (bool value) {
                          setState(() {
                            acceptTerms = value;
                          });
                        },
                        activeColor: Colors.white,
                      ),
                      Text(
                        'Aceitar',
                        style: TextStyle(color: Colors.white),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            viewTerms = true;
                          });
                        },
                        child: Text(
                          'Termos de uso.',
                          style: TextStyle(color: Colors.blue),
                        ),
                      )
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      if (_isLoading == false && acceptTerms == true) {
                        setState(() {
                          _isLoading = true;
                        });
                        register();
                      }
                    },
                    child: Container(
                      width: size.width * 0.6,
                      // height: 70,
                      decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black54,
                            blurRadius: 3.0,
                            offset: Offset(0.0, 0.75),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                        color:
                            acceptTerms == false ? Colors.grey : Colors.white,
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
                                    color: acceptTerms == false
                                        ? Colors.blueGrey
                                        : Colors.orange[800],
                                    fontSize: 30,
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
          viewTerms == false ? Container() : containerTerms()
        ],
      ),
    );
  }

  Widget containerTerms() {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        setState(() {
          viewTerms = false;
        });
      },
      child: Container(
        width: size.width,
        height: size.height,
        color: Colors.black26,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: InkWell(
              onTap: () {},
              child: Container(
                height: size.height / 2,
                width: size.width * .9,
                color: Colors.white,
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      "Termos de uso",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 5),
                    Expanded(
                        child: SingleChildScrollView(
                            child: Text(
                      terms,
                      textAlign: TextAlign.center,
                    ))),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
