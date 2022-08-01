import 'package:ache_entregas/ui/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class AvaliationPage extends StatefulWidget {
  const AvaliationPage({Key? key}) : super(key: key);

  @override
  State<AvaliationPage> createState() => _AvaliationPageState();
}

class _AvaliationPageState extends State<AvaliationPage> {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Avaliações', style: TextStyle(color: Colors.white)),
        
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              height: 100,
              width: 100,
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5.0,
                    offset: Offset(0.0, 0.75),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Suas Avaliações',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star,
                        color: backgroundColor,
                        size: 35,
                      ),
                      Icon(
                        Icons.star,
                        color: backgroundColor,
                        size: 35,
                      ),
                      Icon(
                        Icons.star,
                        color: backgroundColor,
                        size: 35,
                      ),
                      Icon(
                        Icons.star_border,
                        color: backgroundColor,
                        size: 35,
                      ),
                      Icon(
                        Icons.star_border,
                        color: backgroundColor,
                        size: 35,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Total de avaliações',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      Text(
                        '115',
                        style: TextStyle(fontSize: 35, color: Colors.black),
                      ),
                      Text(
                        'Total de estrelas',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      Text(
                        '225',
                        style: TextStyle(fontSize: 35, color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
