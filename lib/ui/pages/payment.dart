import 'dart:convert';

import 'package:ache_entregas/ui/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? photoUrl;
  double? balance;

  getInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await http.get(Uri.parse('https://www.asaas.com/api/v3/finance/balance'),
        headers: {
          "access_token":
              "\$aact_YTU5YTE0M2M2N2I4MTliNzk0YTI5N2U5MzdjNWZmNDQ6OjAwMDAwMDAwMDAwMDAyMDkwODg6OiRhYWNoXzQyYTZmZTFjLWRhNDctNDk4OS1hNTU1LWMzYjQ0ZGJmOTQwYg=="
        }).then((value) {
          final response = jsonDecode(value.body);
          balance = response['balance'];
    });
    setState(() {
      photoUrl = prefs.getString("photo") ?? "";
    });
  }

  @override
  void initState() {
    getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.navigate_before, color: Colors.white, size: 35,)),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(150),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(150),
                  child: photoUrl == null ? Center(child: CircularProgressIndicator(),): Image.network(
                    photoUrl ?? "",
                    fit: BoxFit.cover,
                  )),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              width: size.width * 0.9,
              // height: 200,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Saldo R\$: ',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  Text(
                    balance == null ? '0,00' :  '${balance!.toStringAsFixed(2).replaceAll('.', ',')}',
                    style: TextStyle(fontSize: 35, color: Colors.white),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              width: size.width * 0.9,
              // height: 200,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    'Conta',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: TextFormField(
                      // controller: controler,
                      // keyboardType: textInputType,
                      // validator: validator,
                      // obscureText: obscureText == null ? false : true,
                      decoration: InputDecoration(
                        labelText: 'Conta',
                        labelStyle: TextStyle(
                            color: Colors.white,
                            // fontSize: size.height * 0.03,
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
                        // errorBorder: InputBorder.none,
                        // focusedErrorBorder: InputBorder.none,
                        // errorStyle: TextStyle(
                        //   color: Color.fromARGB(255, 233, 120, 120),
                        // ),
                      ),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: font1,
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: TextFormField(
                      // controller: controler,
                      // keyboardType: textInputType,
                      // validator: validator,
                      // obscureText: obscureText == null ? false : true,
                      decoration: InputDecoration(
                        labelText: 'Agência',
                        labelStyle: TextStyle(
                            color: Colors.white,
                            // fontSize: size.height * 0.03,
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
                        // errorBorder: InputBorder.none,
                        // focusedErrorBorder: InputBorder.none,
                        // errorStyle: TextStyle(
                        //   color: Color.fromARGB(255, 233, 120, 120),
                        // ),
                      ),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: font1,
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: TextFormField(
                      // controller: controler,
                      // keyboardType: textInputType,
                      // validator: validator,
                      // obscureText: obscureText == null ? false : true,
                      decoration: InputDecoration(
                        labelText: 'Banco',
                        labelStyle: TextStyle(
                            color: Colors.white,
                            // fontSize: size.height * 0.03,
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
                        // errorBorder: InputBorder.none,
                        // focusedErrorBorder: InputBorder.none,
                        // errorStyle: TextStyle(
                        //   color: Color.fromARGB(255, 233, 120, 120),
                        // ),
                      ),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: font1,
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: TextFormField(
                      // controller: controler,
                      // keyboardType: textInputType,
                      // validator: validator,
                      // obscureText: obscureText == null ? false : true,
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        labelStyle: TextStyle(
                            color: Colors.white,
                            // fontSize: size.height * 0.03,
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
                        // errorBorder: InputBorder.none,
                        // focusedErrorBorder: InputBorder.none,
                        // errorStyle: TextStyle(
                        //   color: Color.fromARGB(255, 233, 120, 120),
                        // ),
                      ),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: font1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Container(
                width: size.width * 0.9,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: backgroundColor,
                ),
                child: Center(
                  child: Text(
                    'Transferir',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
