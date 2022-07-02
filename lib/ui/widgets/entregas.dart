import 'dart:convert';

import 'package:ache_entregas/ui/constants.dart';
import 'package:ache_entregas/ui/models/request.dart';
import 'package:ache_entregas/ui/models/store.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EntregasNotification extends StatefulWidget {
  final Requests request;
  const EntregasNotification({required this.request, Key? key})
      : super(key: key);

  @override
  _EntregasNotificationState createState() => _EntregasNotificationState();
}

class _EntregasNotificationState extends State<EntregasNotification> {
  bool detail = false;
  Store? store;
  bool loading = true;

  Future loadStore() async {
    http.get(Uri.parse('$url/store/${widget.request.storeId}')).then((value) {
      setState(() {
        store = Store.fromJson(json.decode(value.body));
        loading = false;
      });
    });
  }

  @override
  void initState() {
    loadStore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return loading == true
        ? Container(
            width: size.width,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          )
        : InkWell(
            onTap: () {
              if (detail == false) {
                setState(() {
                  detail = true;
                });
              } else {
                setState(() {
                  detail = false;
                });
              }
            },
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.symmetric(vertical: 1.5),
                  decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5.0,
                        offset: Offset(0.0, 0.75),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  height: 65,
                  width: size.width * 0.97,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            Text(
                              '3',
                              style: TextStyle(
                                fontSize: 30,
                                color: backgroundColor,
                              ),
                            ),
                            Text(
                              'km',
                              style: TextStyle(
                                fontSize: 17,
                                color: backgroundColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: size.width * 0.83,
                        decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 3,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    store!.address!.street.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    store!.address!.number.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    store!.address!.city.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'A',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                if (detail == true)
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5.0,
                          offset: Offset(0.0, 0.75),
                        ),
                      ],
                    ),
                    width: size.width * 0.97,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cliente',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 20),
                            ),
                            Text(
                              'Alexandre de Souza',
                              style: TextStyle(
                                  color: backgroundColor, fontSize: 20),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 5.0,
                                        offset: Offset(0.0, 0.75),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    'ACEITAR',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 5.0,
                                        offset: Offset(0.0, 0.75),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    'RECUSAR',
                                    style: TextStyle(
                                      color: backgroundColor,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Empresa',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 20),
                            ),
                            Text(
                              store!.fantasyName.toString(),
                              style: TextStyle(
                                  color: backgroundColor, fontSize: 20),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
              ],
            ),
          );
  }
}
