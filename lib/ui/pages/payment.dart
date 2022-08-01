import 'package:ache_entregas/ui/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
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
                color: Colors.black,
              ),
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
                    '999,60',
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
