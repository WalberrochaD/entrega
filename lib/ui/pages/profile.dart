import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../widgets/masked.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> _form = GlobalKey();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _cnhController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  var _cpfController = MaskedTextController(mask: '000.000.000-00');
  var _telController = MaskedTextController(mask: '(00)00000-0000');
  var _dataNCController = MaskedTextController(mask: '00/00/0000');
  bool selectIn = false;

  String? name;
  String? email;
  String? cpf;
  String? photoUrl;

  getInformations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? '';
      email = prefs.getString('email') ?? '';
      cpf = prefs.getString('cpf') ?? '';
      photoUrl = prefs.getString("photo") ?? "";
      _emailController = TextEditingController(text: email);
      _nameController = TextEditingController(text: name);
      _cpfController = MaskedTextController(mask: '000.000.000-00', text: cpf);
    });
  }

  @override
  void initState() {
    getInformations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'Perfil',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        color: backgroundColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: backgroundColor,
                // height: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(150),
                            color: Colors.white),
                        height: 90,
                        width: 90,
                        child: photoUrl == null ? Icon(
                          Icons.person,
                          size: 45,
                          color: backgroundColor,
                        ) : ClipRRect(
                          borderRadius: BorderRadius.circular(150),
                          child: Image.network(photoUrl ?? "",
                          fit: BoxFit.cover,),
                        )
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$name',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              'Mirassol D\'Oeste',
                              style: TextStyle(color: Colors.white),
                            ),
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Form(
                key: _form,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.height * 0.02, vertical: 5),
                        child: widgetTextField(_emailController,
                            TextInputType.emailAddress, 'E-mail', (value) {
                          if (value!.length < 8 || !value.contains('@')) {
                            return "       E-mail inválido";
                          }
                          return null;
                        })),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.height * 0.02, vertical: 5),
                        child: widgetTextField(
                            _nameController, TextInputType.name, 'nome',
                            (value) {
                          if (value!.length < 4) {
                            return "       Nome inválido";
                          }
                          return null;
                        })),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.height * 0.02, vertical: 5),
                        child: widgetTextField(
                            _cpfController, TextInputType.number, 'CPF',
                            (value) {
                          if (value!.length < 10) {
                            return "       Cpf inválido";
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  widgetTextField(TextEditingController controler, TextInputType textInputType,
      String labelText, String? Function(String?)? validator,
      {bool? obscureText}) {
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
}
