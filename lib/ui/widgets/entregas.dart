import 'dart:convert';
import 'dart:math';

import 'package:ache_entregas/ui/constants.dart';
import 'package:ache_entregas/ui/models/acceptRequest.dart';
import 'package:ache_entregas/ui/models/allrequest.dart';
import 'package:ache_entregas/ui/models/location.dart';
import 'package:ache_entregas/ui/models/request.dart';
import 'package:ache_entregas/ui/models/store.dart';
import 'package:ache_entregas/ui/models/userBuyer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EntregasNotification extends StatefulWidget {
  final AllRequestModel request;
  final AcceptRequestModel? acceptRequest;
  String? locationPermission;
  Function? functionCallBack;
  String? filter;
  EntregasNotification(
      {required this.request,
      this.functionCallBack,
      this.locationPermission,
      this.filter,
      this.acceptRequest,
      Key? key})
      : super(key: key);

  @override
  _EntregasNotificationState createState() => _EntregasNotificationState();
}

class _EntregasNotificationState extends State<EntregasNotification> {
  bool detail = false;
  Store? store;
  bool loading = false;
  TextEditingController _controller = TextEditingController();
  GlobalKey<FormState> _form = GlobalKey();
  UserBuyer? userBuyer;
  int number = Random().nextInt(10);

  Future loadStore() async {
    await http
        .get(Uri.parse('$url/store/${widget.request.requests!.storeId}'))
        .then((value) {
      store = Store.fromJson(json.decode(value.body));

      setState(() {});
    });
  }

  loadUserBuyer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    http.get(Uri.parse('$url/usersBuyer'),
        headers: {'Authorization': 'Bearer $token'}).then((value) {
      final map = jsonDecode(value.body);
      for (var user in map) {
        if (user['id'] == widget.request.requests!.userId!) {
          userBuyer = UserBuyer.fromJson(user);
        }
      }
    });
  }

  bool _isLoading = false;

  acceptRequest() async {
    setState(() {
      _isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String id = prefs.getString('id') ?? '';
    http
        .post(
      Uri.parse('$url/requestSendFreelancer/${widget.request.requests!.id}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(
        {
          "userId": widget.request.requests!.userId,
          "addressId": widget.request.requests!.addressId,
          // "statusId": 4,
          "deliverId": id,
          "value": widget.request.requests!.value,
          "quantity": widget.request.requests!.quantity,
          "statusSendId": 1,
          "storeId": widget.request.requests!.storeId,
          "productsId": widget.request.products!
              .where((element) => element.id != null)
              .toList(),
          "productsFoodId": widget.request.productsFood!
              .where((element) => element.id != null)
              .toList(),
          "requestId": widget.request.requests!.id,
          // "userBuyerId": widget.request.requests!.userId,
        },
      ),
    )
        .then((value) {
      if (value.statusCode == 200) {
        setState(() {
          _isLoading = false;
        });
        widget.functionCallBack!.call();
      }
    });
  }

  finalize() async {
    if (!_form.currentState!.validate()) {
      _controller.clear();
      return;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    setState(() {
      _isLoading = true;
    });
    http
        .post(
      Uri.parse('$url/finalizeRequest/${widget.request.requests!.id}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(
        {
          "requestId": widget.request.requests!.id,
        },
      ),
    )
        .then((value) {
      print(value.body);
      print(value.statusCode);
      if (value.statusCode == 200) {
        widget.functionCallBack!.call();
        setState(() {
          _isLoading = false;
        });
      }
      setState(() {
        _isLoading = false;
      });
    });
  }

  double weight = 0;
  double? distance;
  _calculeDistance() async {
    double _distance = await Location().calcuteDistance(
        latStore: double.parse(store!.address!.lat!),
        longStore: double.parse(store!.address!.long!));
    print(_distance);
    setState(() {
      distance = _distance;
    });
  }

  @override
  void initState() {
    loadStore().then((value) {
      if (widget.locationPermission == '') {
        _calculeDistance();
      }
    });
    loadUserBuyer();
    // print(widget.request['deliverId']);
    // print(widget.request['productFoodId']);
    // print(widget.request['store']);
    if (widget.request.products != null) {
      double wei = 0.0;
      for (Products w in widget.request.products!) {
        wei = wei + double.parse(w.weight.toString());
      }
      setState(() {
        weight = wei;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return store == null
        ? Container(
            padding: const EdgeInsets.all(10),
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
                        child: Container(
                            width: 25,
                            child: widget.locationPermission == ''
                                ? Column(
                                    children: [
                                      distance == null
                                          ? LinearProgressIndicator(
                                              color: backgroundColor,
                                            )
                                          : Expanded(
                                              child: Text(
                                                '${distance!.toStringAsFixed(0)}',
                                                maxLines: 2,
                                                style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 20,
                                                  color: backgroundColor,
                                                ),
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
                                  )
                                : Text(
                                    'N',
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: backgroundColor,
                                    ),
                                  )),
                      ),
                      Container(
                        width: widget.filter == 'getNews'
                            ? size.width * 0.85
                            : size.width * 0.855,
                        decoration: BoxDecoration(
                            color: widget.filter == 'getNews'
                                ? backgroundColor
                                : widget.filter == 'getInProgess'
                                    ? Colors.black
                                    : widget.filter == 'getFinalized'
                                        ? Colors.green
                                        : backgroundColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: size.width * .33,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Text(
                                      'C: ${store!.address!.city}',
                                      // 'Cidade: ${widget.request.requests.}',
                                      // store!.address!.city.toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Text(
                                      'R: ${store!.address!.street}',
                                      // 'Rua: ${widget.request["store"]['address']['street']}',
                                      // store!.address!.street.toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Text(
                                      'N: ${store!.address!.number}',
                                      // 'Número: ${widget.request["store"]['address']['number']}',
                                      // store!.address!.number.toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            widget.filter == 'getNews'
                                ? Container()
                                : Column(
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        ">>",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(">>",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ],
                                  ),
                            widget.filter == 'getNews'
                                ? Container()
                                : Container(
                                    width: widget.filter == 'getNews'
                                        ? size.width * .5
                                        : size.width * .33,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Text(
                                            'C: ${widget.request.requests!.address!.city}',
                                            // 'Cidade: ${widget.request['address']['city']}',
                                            // store!.address!.city.toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Text(
                                            'R: ${widget.request.requests!.address!.street}',
                                            // 'Rua: ${widget.request['address']['street']}',
                                            // store!.address!.street.toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Text(
                                            'N: ${widget.request.requests!.address!.number}',
                                            // 'Número: ${widget.request['address']['number']}',
                                            // store!.address!.number.toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            widget.request.products != null
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      weight <= 0.5
                                          ? '1A'
                                          : weight > 0.5 && weight <= 1
                                              ? "1B"
                                              : weight > 1 && weight <= 2
                                                  ? "1C"
                                                  : weight > 2 && weight <= 5
                                                      ? "2D"
                                                      : weight > 5 &&
                                                              weight <= 7
                                                          ? "2E"
                                                          : weight > 7 &&
                                                                  weight <= 10
                                                              ? "3F"
                                                              : weight > 10 &&
                                                                      weight <=
                                                                          15
                                                                  ? "3G"
                                                                  : weight > 15
                                                                      ? "3H"
                                                                      : "--",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 35,
                                      ),
                                    ),
                                  )
                                : Container()
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
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Text(
                              'Distancia para chegar na loja:',
                            ),
                            Text(
                              widget.locationPermission == ''
                                  ? '${distance!.toStringAsFixed(0)} km '
                                  : '${widget.locationPermission}',
                              style: TextStyle(color: backgroundColor),
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: widget.filter == 'getNews'
                              ? MainAxisAlignment.center
                              : MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Empresa',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 20),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      '${store!.fantasyName}',
                                      // widget.request['store']['fantasyName'],
                                      // store!.fantasyName.toString(),
                                      style: TextStyle(
                                          color: backgroundColor, fontSize: 20),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Text(
                                        'Cidade: \n ${store!.address!.city}',
                                        // 'Cidade: ${widget.request["store"]['address']['city']}',
                                        // store!.address!.city.toString(),
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 17),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Text(
                                        'Rua: ${store!.address!.street}',
                                        // 'Rua: ${widget.request["store"]['address']['street']}',
                                        // store!.address!.street.toString(),
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 17),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Text(
                                        'Número: ${store!.address!.number}',
                                        // 'Número: ${widget.request["store"]['address']['number']}',
                                        // store!.address!.number.toString(),
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 17),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                widget.filter == 'getNews'
                                    ? InkWell(
                                        onTap: () {
                                          if (_isLoading != true) {
                                            acceptRequest();
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.orange,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                color: Colors.black26,
                                                blurRadius: 5.0,
                                                offset: Offset(0.0, 0.75),
                                              ),
                                            ],
                                          ),
                                          child: _isLoading == true
                                              ? CircularProgressIndicator(
                                                  color: Colors.white,
                                                )
                                              : Text(
                                                  'ACEITAR',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                ),
                                        ),
                                      )
                                    : Container(),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                            widget.filter == 'getNews'
                                ? Container()
                                : Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        ">>",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        ">>",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 20),
                                      ),
                                    ],
                                  ),
                            widget.filter == 'getNews'
                                ? Container()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Cliente Endereço',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 20),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: Text(
                                              // 'Cidade:',
                                              'Cidade: ${widget.request.requests!.address!.city}',
                                              // store!.address!.city.toString(),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: Text(
                                              // 'Rua: ',
                                              'Rua: ${widget.request.requests!.address!.street}',
                                              // store!.address!.street.toString(),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: Text(
                                              // 'Número: ',
                                              'Número: ${widget.request.requests!.address!.number}',
                                              // store!.address!.number.toString(),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: Text(
                                              'Telefone: ',
                                              // 'Telefone: \n${widget.request['user']['telephone']}',
                                              // store!.address!.city.toString(),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '${userBuyer!.name!}',
                                        // widget.request['user']['name'],
                                        style: TextStyle(
                                            color: backgroundColor,
                                            fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  )
                          ],
                        ),
                        widget.filter == "getInProgess"
                            ? Row(
                                children: [
                                  Container(
                                    width: size.width / 1.12,
                                    child: Row(
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.spaceBetween,
                                      children: [
                                        Form(
                                          key: _form,
                                          child: Container(
                                            width: size.width / 1.9,
                                            // height: 100,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                controller: _controller,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                validator: (value) {
                                                  if (value !=
                                                      widget
                                                          .request.requests!.id
                                                          .toString()) {
                                                    return "Código inválido";
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  errorStyle: TextStyle(
                                                      color: Colors.black),
                                                  labelText: "Código",
                                                  labelStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 27,
                                                      fontFamily: font1),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    borderSide: BorderSide(
                                                        color: Colors.black,
                                                        width: 1.0),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    borderSide: BorderSide(
                                                        color: Colors.black,
                                                        width: 1.0),
                                                  ),
                                                ),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontFamily: font1,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            print(widget.request.requests!.id
                                                .toString());
                                            finalize();
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: backgroundColor,
                                            ),
                                            child: _isLoading == true
                                                ? CircularProgressIndicator(
                                                    color: Colors.white,
                                                  )
                                                : Text(
                                                    'Finalizar',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white),
                                                  ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : Container()
                      ],
                    ),
                  ),
              ],
            ),
          );
  }
}
