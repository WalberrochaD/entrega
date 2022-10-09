import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ache_entregas/ui/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class SinupVeiculo extends StatefulWidget {
  final bool view;
  const SinupVeiculo({required this.view, Key? key}) : super(key: key);

  @override
  _SinupVeiculoState createState() => _SinupVeiculoState();
}

class _SinupVeiculoState extends State<SinupVeiculo> {
  TextEditingController _cnhController = TextEditingController();
  TextEditingController _placaController = TextEditingController();
  TextEditingController _chassiController = TextEditingController();
  TextEditingController _descriController = TextEditingController();
  File? photo;
  bool progress = false;
  GlobalKey<FormState> _form = GlobalKey();

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

  registerVehicle() async {
    // if (!_form.currentState!.validate()) {
    //   return;
    // }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    print(token);
    setState(() {
      progress = true;
    });

    String extension = p.extension(photo!.path);
    print(extension.substring(1));

    Map<String, dynamic> fields = {
      "placa": _placaController.text,
      "chassi": _chassiController.text,
      "vehicleTypeId": _veiculoSelec == 'Motocicleta' ? 2 : 1,
      "dealership": _marcaSelec,
      "modelCar": _modeloSelec
    };
    var uri = Uri.parse('$url/vehicle');
    // var uri = Uri.https('https://weupback.azurewebsites.net/vehicle', 'create');
    var request = http.MultipartRequest('POST', uri)
      ..fields['store'] = jsonEncode(fields)
      ..files.add(await http.MultipartFile.fromPath(
        "photo",
        photo!.path,
        contentType: MediaType('image', extension.substring(1)),
      ))
      ..headers.addAll({
        "Content-Type": "multipart/form-data",
        "Authorization": "Bearer $token"
      });
    var response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 201) {
      setState(() {
        progress = false;
      });
      prefs.remove('vehicle');
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => Home()));
    } else {
      return ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Veículo já cadastrado!",
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
    }
    print(response.statusCode);
  }

  var _veiculo = [
    'Motocicleta',
    'Carro',
  ];

  String? _veiculoSelec;

  List<String> _marca = [];
  var _marc = [];
  String? _marcaSelec;

  Future getMarca() async {
    String vehicle;

    if (_veiculoSelec == 'Motocicleta') {
      vehicle = 'motos';
    } else {
      vehicle = 'carros';
    }
    _marca.clear();

    http
        .get(Uri.parse('https://parallelum.com.br/fipe/api/v1/$vehicle/marcas'))
        .then((value) {
      final decode = jsonDecode(value.body);
      var list = decode;

      for (var model in list) {
        _marca.add(model['nome']);
        _marc.add(model);
      }
      if (widget.view == true) {
        String? code;
        for (var marc in _marc) {
          if (marc['nome'] == _marcaSelec) {
            code = marc['codigo'];
          }
        }
        getModelo(code!);
        // http
        //     .get(Uri.parse(
        //         'https://parallelum.com.br/fipe/api/v1/motos/marcas/$code/modelos'))
        //     .then((value) {
        //   print(value.body);
        //   final decode = jsonDecode(value.body);
        //   var list = decode;
        //   for (var model in list['modelos']) {
        //     _modelo.add(model['nome']);
        //   }
        //   setState(() => {});
        // });
      }
      print(_marca);
      setState(() => {});
    });
  }

  List<String> _modelo = [];
  String? _modeloSelec;

  getModelo(String marcSelect) async {
    String modeloId = '';
    _modelo.clear();
    print(marcSelect);

    for (var marc in _marc) {
      if (marc['nome'] == marcSelect) {
        modeloId = marc['codigo'];
      }
    }
    print(modeloId);

    http
        .get(Uri.parse(
            'https://parallelum.com.br/fipe/api/v1/motos/marcas/$modeloId/modelos'))
        .then((value) {
      print(value.body);
      final decode = jsonDecode(value.body);
      var list = decode;
      for (var model in list['modelos']) {
        _modelo.add(model['nome']);
      }
      setState(() => {});
    });
  }

  String? photoVehicle;

  getParams() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String vehicleId = prefs.getString('vehicleId') ?? "";
    String photoVehiclee = prefs.getString('photoVehicle') ?? "";
    String placa = prefs.getString('placa') ?? "";
    String chassi = prefs.getString('chassi') ?? "";
    String vehicleTypeId = prefs.getString('vehicleTypeId') ?? "";
    String dealership = prefs.getString('dealership') ?? "";
    String modelCar = prefs.getString('modelCar') ?? "";
    String ownerVehicleId = prefs.getString('ownerVehicleId') ?? "";

    _placaController = TextEditingController(text: placa);
    _chassiController = TextEditingController(text: chassi);
    if (vehicleTypeId == "1") {
      _veiculoSelec = "Carro";
    } else {
      _veiculoSelec = "Motocicleta";
    }
    photoVehicle = photoVehiclee;
    _marcaSelec = dealership;
    _modeloSelec = modelCar;
    _cnhController = TextEditingController(text: "213444");
    getMarca();
    setState(() {});
  }

  @override
  void initState() {
    if (widget.view == true) {
      getParams();
    }
    super.initState();
  }

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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                height: widget.view == false ? 35 : 25,
              ),
              widget.view == false
                  ? Container()
                  : TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.navigate_before,
                        color: Colors.white,
                        size: 30,
                      )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      // border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(50),
                      color: backgroundColor),
                  child: DropdownButton<String>(
                    dropdownColor: backgroundColor,
                    isExpanded: true,
                    autofocus: true,
                    underline: Text(''),
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                      size: size.height * 0.045,
                    ),
                    hint: Text(
                      'Veiculo',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    // menuMaxHeight: size.height / 3,
                    items: _veiculo.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Center(
                            child: Text(
                          dropDownStringItem,
                          style: TextStyle(color: Colors.white),
                        )),
                      );
                    }).toList(),
                    onChanged: (novoItemSelecionado) {
                      setState(() {
                        _veiculoSelec = novoItemSelecionado;
                      });
                      getMarca();
                    },
                    value: _veiculoSelec,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              photoVehicle != null
                  ? Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: backgroundColor,
                          ),
                          height: 150,
                          width: 250,
                          margin: EdgeInsets.only(left: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              photoVehicle!,
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
                    )
                  : TextButton(
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
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: widgetTextField(
                    _placaController, TextInputType.text, 'Placa'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: widgetTextField(
                    _chassiController, TextInputType.text, 'Chassi numero'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      width: size.width * 0.4,
                      decoration: BoxDecoration(
                          // border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(10),
                          color: backgroundColor),
                      child: DropdownButton<String>(
                        dropdownColor: backgroundColor,
                        isExpanded: true,
                        autofocus: true,
                        underline: Text(''),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                          size: size.height * 0.045,
                        ),
                        hint: Text(
                          'Marca',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        // menuMaxHeight: size.height / 3,
                        items: _marca.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Center(
                                child: Text(
                              dropDownStringItem,
                              style: TextStyle(color: Colors.white),
                            )),
                          );
                        }).toList(),
                        onChanged: (novoItemSelecionado) {
                          setState(() {
                            _marcaSelec = novoItemSelecionado;
                            getModelo(novoItemSelecionado!);
                          });
                        },
                        value: _marcaSelec,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      width: size.width * 0.4,
                      decoration: BoxDecoration(
                          // border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(10),
                          color: backgroundColor),
                      child: DropdownButton<String>(
                        dropdownColor: backgroundColor,
                        isExpanded: true,
                        autofocus: true,
                        underline: Text(''),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                          size: size.height * 0.045,
                        ),
                        hint: Text(
                          'Modelo',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        items: _modelo.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Center(
                                child: Text(
                              dropDownStringItem,
                              style: TextStyle(color: Colors.white),
                            )),
                          );
                        }).toList(),
                        onChanged: (novoItemSelecionado) {
                          setState(() {
                            _modeloSelec = novoItemSelecionado;
                          });
                        },
                        value: _modeloSelec,
                      ),
                    ),
                  ),
                  // TextButton(
                  //   onPressed: () {},
                  //   child: Row(
                  //     children: [
                  //       Container(
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(10),
                  //           color: backgroundColor,
                  //         ),
                  //         margin: EdgeInsets.only(left: 20),
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: Text(
                  //             'Marca',
                  //             textAlign: TextAlign.center,
                  //             style:
                  //                 TextStyle(color: Colors.white, fontSize: 20),
                  //           ),
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         width: 5,
                  //       ),
                  //       Container(
                  //           decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(50),
                  //               color: backgroundColor),
                  //           child: Icon(
                  //             Icons.keyboard_arrow_down_sharp,
                  //             size: 33,
                  //             color: Colors.white,
                  //           ))
                  //     ],
                  //   ),
                  // ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: widgetTextField(
                    _descriController, TextInputType.text, 'Descrição'),
              ),
              widget.view == true
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            progress == true ? null : registerVehicle();
                            // Navigator.of(context)
                            //     .push(MaterialPageRoute(builder: (ctx) => Home()));
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
                                padding: progress == true
                                    ? const EdgeInsets.all(10)
                                    : const EdgeInsets.all(2.0),
                                child: progress == true
                                    ? CircularProgressIndicator(
                                        color: backgroundColor,
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
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
