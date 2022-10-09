import 'dart:convert';

import 'package:ache_entregas/ui/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AvaliationPage extends StatefulWidget {
  const AvaliationPage({Key? key}) : super(key: key);

  @override
  State<AvaliationPage> createState() => _AvaliationPageState();
}

class _AvaliationPageState extends State<AvaliationPage> {
  String? photoUrl;

  getInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      photoUrl = prefs.getString("photo") ?? "";
    });
  }

  double note = 0;
  bool _loadingStars = false;
  int total = 0;
  List<int> listStars = [];
  getStars() async {
    setState(() {
      _loadingStars = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String id = prefs.getString('id') ?? '';
    print(id);
    await http.get(
      Uri.parse('$url/deliverNote/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ).then((value) {
      Iterable response = jsonDecode(value.body);
      if (response.isNotEmpty) {
        for (var stars in response) {
          if (stars['note'] != null) {
            int star = stars['note'];
            total = total + star;
            listStars.add(stars['note']);
          }
        }
        setState(() {
          note = total / listStars.length;
          _loadingStars = false;
        });
      } else {
        setState(() {
          _loadingStars = false;
        });
      }
      print(note);
      // print(value.body);
      // print(value.statusCode);
    });
  }

  @override
  void initState() {
    getStars();
    getInfo();
    super.initState();
  }

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
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(150),
                  child: photoUrl == null
                      ? CircularProgressIndicator()
                      : Image.network(
                          photoUrl!,
                          fit: BoxFit.cover,
                        )),
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
              child: _loadingStars == true
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Suas Avaliações',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        starNotes(note),
                        Column(
                          children: [
                            Text(
                              'Total de avaliações',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                            Text(
                              '${listStars.length}',
                              style:
                                  TextStyle(fontSize: 35, color: Colors.black),
                            ),
                            Text(
                              'Total de estrelas',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                            Text(
                              '$total',
                              style:
                                  TextStyle(fontSize: 35, color: Colors.black),
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

  Widget starNotes(double n) {
    if (n >= 0.5 && n <= 1.5) {
      return Padding(
        padding: const EdgeInsets.only(top: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
      );
    } else if (n > 1.5 && n <= 2.5) {
      return Padding(
        padding: const EdgeInsets.only(top: 3),
        child: Row(
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
              Icons.star_border,
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
      );
    } else if (n > 2.5 && n <= 3.5) {
      return Padding(
        padding: const EdgeInsets.only(top: 3),
        child: Row(
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
      );
    } else if (n > 3.5 && n <= 4.5) {
      return Padding(
        padding: const EdgeInsets.only(top: 3),
        child: Row(
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
              Icons.star,
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
      );
    } else if (n > 4.5 && n <= 5) {
      return Padding(
        padding: const EdgeInsets.only(top: 3),
        child: Row(
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
              Icons.star,
              color: backgroundColor,
              size: 35,
            ),
            Icon(
              Icons.star,
              color: backgroundColor,
              size: 35,
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            Icon(
              Icons.star_border,
              color: backgroundColor,
              size: 35,
            ),
          ],
        ),
      );
    }
  }
}
