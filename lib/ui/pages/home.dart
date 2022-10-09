import 'dart:convert';

import 'package:ache_entregas/ui/constants.dart';
import 'package:ache_entregas/ui/models/allrequest.dart';
import 'package:ache_entregas/ui/models/request.dart';
import 'package:ache_entregas/ui/widgets/drawer.dart';
import 'package:ache_entregas/ui/widgets/entregas.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/location.dart';

enum FilterOptions {
  Novas,
  Em,
  Entregues,
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool button = true;
  var scaffoldey = GlobalKey<ScaffoldState>();
  List<AllRequestModel> request = [];
  bool loading = false;
  String filter = 'getNews';
  String? photo;

  Future getRequests() async {
    setState(() {
      loading = true;
      request.clear();
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    setState(() {
      photo = prefs.getString("photo") ?? "";
    });
    print(token);
    await http.get(Uri.parse('$url/allRequest'), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    }).then((value) {
      print(value.statusCode);
      setState(() {
        Iterable lista = json.decode(value.body);
        List<AllRequestModel> requestt =
            lista.map((e) => AllRequestModel.fromJson(e)).toList();
        for (var re in requestt) {
          if (re.requests!.statusId == 6) {
            print(re);
            setState(() {
              request.add(re);
            });
          }
        }
        request.sort((a, b) =>
            DateTime.parse(a.createdAt!).isAfter(DateTime.parse(b.createdAt!))
                ? 1
                : -1);
        setState(() {
          loading = false;
        });
      });
      // print(request);
    });
  }

  Future getInProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String id = prefs.getString('id') ?? '';
    print("DeliverId: $id");
    setState(() {
      request.clear();
      loading = true;
    });
    await http.get(Uri.parse('$url/allRequest'), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    }).then((value) {
      setState(() {
        Iterable lista = json.decode(value.body);
        List<AllRequestModel> requestt =
            lista.map((e) => AllRequestModel.fromJson(e)).toList();
        print(lista.length);
        for (var re in requestt) {
          if (re.requests!.deliverId.toString() == id &&
              re.requests!.statusId == 4) {
            setState(() {
              request.add(re);
            });
          }
        }
        setState(() {
          loading = false;
        });
      });
      print(request.length);
    });
  }

  Future getDeliverysFinalized() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String id = prefs.getString('id') ?? '';
    print("DeliverId: $id");
    setState(() {
      request.clear();
      loading = true;
    });
    await http.get(Uri.parse('$url/allRequest'), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    }).then((value) {
      setState(() {
        Iterable lista = json.decode(value.body);
        List<AllRequestModel> requestt =
            lista.map((e) => AllRequestModel.fromJson(e)).toList();
        print(lista.length);
        for (var re in requestt) {
          if (re.requests!.deliverId.toString() == id &&
              re.requests!.statusId == 5) {
            setState(() {
              request.add(re);
            });
          }
        }
        setState(() {
          loading = false;
        });
      });
      print(request.length);
    });
  }

  // Future acceptRequest() async {
  //   await http.put(Uri.parse('$url/deliveringRequest/:requestId'), headers: {
  //     "Content-Type": "application/json",
  //     "Authorization":
  //         "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJ3YWxiZXJAdGVzdC5jb20iLCJjcGYiOiIxMjM0NTIyMTkyOCIsIm5hbWUiOiJNZXVOb21lIiwidHlwZVVzZXIiOiJhZG1pbiIsImlhdCI6MTY0OTY4NDI2NX0.wHauTTJ_AIm_KybjTjfOavXyPsDGuTC52EIl0U2w0RU"
  //   });
  // }

  @override
  void initState() {
    Location().getPosition();
    getRequests();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          key: scaffoldey,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                scaffoldey.currentState?.openDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: Colors.white,
                size: 50,
              ),
            ),
            actions: [
              PopupMenuButton(
                onSelected: (FilterOptions selectedValue) {
                  setState(
                    () {
                      if (selectedValue == FilterOptions.Novas) {
                        filter = 'getNews';
                        getRequests();
                      }
                      if (selectedValue == FilterOptions.Em) {
                        filter = 'getInProgess';
                        getInProgress();
                      }
                      if (selectedValue == FilterOptions.Entregues) {
                        filter = 'getFinalized';
                        getDeliverysFinalized();
                      }
                    },
                  );
                },
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                itemBuilder: (_) => [
                  PopupMenuItem(
                    child: Text('Novas Entregas'),
                    value: FilterOptions.Novas,
                  ),
                  PopupMenuItem(
                    child: Text('Em Entrega'),
                    value: FilterOptions.Em,
                  ),
                  PopupMenuItem(
                    child: Text('Pedidos Entregues'),
                    value: FilterOptions.Entregues,
                  ),
                ],
              )
            ],
          ),
          drawer: AppDrawer(),
          body: SingleChildScrollView(
            child: Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                  image: AssetImage('assets/icons/home/fundo.png'),
                  opacity: 0.6,
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                width: size.width,
                height: size.height,
                color: Colors.black12,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 170,
                      width: 170,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(150),
                        color: Colors.white,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10.0,
                            offset: Offset(0.0, 0.5),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(150),
                        child: photo == null
                            ? Icon(Icons.person)
                            : Image.network(
                                photo!,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Container(
                      // width: size.width * 0.97,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            margin: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
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
                            child: Text(
                              'Ordenar',
                              style: TextStyle(
                                  color: backgroundColor, fontSize: 25),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              if (button == true) {
                                setState(() {
                                  button = false;
                                });
                              } else {
                                setState(() {
                                  button = true;
                                });
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 5.0,
                                    offset: Offset(0.0, 0.75),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: button == false
                                          ? Colors.orange
                                          : Colors.white,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    child: Text(
                                      'off',
                                      style: TextStyle(
                                          color: button == false
                                              ? Colors.white
                                              : backgroundColor,
                                          fontSize: 20),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: button == true
                                          ? Colors.orange
                                          : Colors.white,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    child: Text(
                                      'on',
                                      style: TextStyle(
                                          color: button == true
                                              ? Colors.white
                                              : backgroundColor,
                                          fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    // loading == true
                    //     ? CircularProgressIndicator(
                    //         color: Colors.white,
                    //       )
                    //     : button == true
                    //         ? EntregasNotification(
                    //             request: request[0],
                    //           )
                    //         : Container(),
                    // button == true ? EntregasNotification() : Container(),
                    // button == true ? EntregasNotification() : Container(),
                    loading == true
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : button == true
                            ? Expanded(
                                // width: size.width,
                                // height: size.height - size.height * 0.4,
                                child: request.isEmpty
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Text(
                                          "Nenhuma entrega",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    : ChangeNotifierProvider<Location>(
                                        create: (context) => Location(),
                                        child: Builder(
                                          builder: (context) {
                                            final locale =
                                                context.watch<Location>();
                                            String message = locale.erro == ''
                                                ? ''
                                                : locale.erro;
                                            return ListView.builder(
                                              itemCount: request.length,
                                              itemBuilder: (context, index) {
                                                return EntregasNotification(
                                                  request: request[index],
                                                  locationPermission: message,
                                                  functionCallBack: () {
                                                    getRequests();
                                                  },
                                                  filter: filter,
                                                );
                                              },
                                            );
                                          },
                                        )),
                              )
                            : Container()
                  ],
                ),
              ),
            ),
          ),
        ),
        // Positioned(
        //   top: 50,
        //   left: size.width * 0.28,
        //   child: Container(
        //     height: 170,
        //     width: 170,
        //     decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(150),
        //         color: Colors.black),
        //   ),
        // ),
      ],
    );
  }
}
