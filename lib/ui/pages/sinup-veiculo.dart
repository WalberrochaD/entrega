import 'dart:convert';
import 'dart:io';

import 'package:ache_entregas/ui/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class SinupVeiculo extends StatefulWidget {
  const SinupVeiculo({Key? key}) : super(key: key);

  @override
  _SinupVeiculoState createState() => _SinupVeiculoState();
}

class _SinupVeiculoState extends State<SinupVeiculo> {
  final TextEditingController _cnhController = TextEditingController();
  final TextEditingController _placaController = TextEditingController();
  final TextEditingController _chassiController = TextEditingController();
  final TextEditingController _descriController = TextEditingController();
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

  Future RegisterVehicle() async {
    // if (!_form.currentState!.validate()) {
    //   return;
    // }

    final multiPartFilel = http.MultipartFile.fromPath('photo', photo!.path);
    final toen =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OCwiZW1haWwiOiJ3YWxiZXJAZ21haWwuY29tIiwiY3BmIjoiMjExMTU0MDg4MzMiLCJuYW1lIjoiV2FsYmVyIHJvY2hhIiwidHlwZVVzZXIiOiJkZWxpdmVyeW1hbiIsImlhdCI6MTY1NTEzMDQ0Mn0.Hpq3AqntjO51I3BGa7ADSCeYuvOYFzZ3Bns1rWgQ3aU';

    setState(() {
      progress = true;
    });

    await http
        .post(
      Uri.parse('$url/vehicle'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $toen",
        "photo": '$multiPartFilel',
      },
      body: jsonEncode({
        "placa": "placa",
        "chassi": "chassi",
        "vehicleTypeId": 1,
        "ownerVehicleId": 1,
        "dealership": "HONDA",
        "modelCar": "Titan 150"
      }),
    )
        .then((value) {
      final json = jsonDecode(value.body);
      print(value.body);
      print(json);
      // setState(() {
      //   progress = false;
      // });
      // return ScaffoldMessenger.of(context)
      //   ..hideCurrentSnackBar()
      //   ..showSnackBar(
      //     SnackBar(
      //       content: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: <Widget>[
      //           Text(
      //             "Usuario não encontrado",
      //             style: TextStyle(color: Colors.white),
      //           ),
      //           Icon(
      //             Icons.error,
      //             color: Colors.white,
      //           ),
      //         ],
      //       ),
      //     ),
      //   );
    });
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
                height: 35,
              ),
              TextButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: backgroundColor,
                      ),
                      margin: EdgeInsets.only(left: 20),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Motocicleta',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 20),
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
                          Icons.keyboard_arrow_down_sharp,
                          size: 33,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 10,
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
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child:
                    widgetTextField(_cnhController, TextInputType.text, 'CNH'),
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
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: backgroundColor,
                          ),
                          margin: EdgeInsets.only(left: 20),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Marca',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: backgroundColor),
                            child: Icon(
                              Icons.keyboard_arrow_down_sharp,
                              size: 33,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: backgroundColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Modelo',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: backgroundColor),
                            child: Icon(
                              Icons.keyboard_arrow_down_sharp,
                              size: 33,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: widgetTextField(
                    _descriController, TextInputType.text, 'Descrição'),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: InkWell(
                    onTap: () {
                      RegisterVehicle();
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
