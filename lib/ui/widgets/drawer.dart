import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../constants.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token').then((value) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => MyApp()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Drawer(
      child: Container(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: size.width,
                height: 110,
                color: backgroundColor,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Jorge Silva Marinho',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Mirassol - MT',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 5),
                      child: Icon(
                        Icons.person,
                        color: Colors.black,
                        size: 50,
                      ),
                    ),
                    Text(
                      'Perfil',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              Divider(),
              // Row(
              //   children: [
              //     Padding(
              //       padding:
              //           const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              //       child: Icon(
              //         Icons.motorcycle_outlined,
              //         color: Colors.black,
              //         size: 50,
              //       ),
              //     ),
              //     Text(
              //       'Novas Entregas',
              //       style: TextStyle(fontSize: 18),
              //     ),
              //   ],
              // ),
              // Divider(),
              // Row(
              //   children: [
              //     Padding(
              //       padding:
              //           const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              //       child: Icon(
              //         Icons.motorcycle_outlined,
              //         color: Colors.black,
              //         size: 50,
              //       ),
              //     ),
              //     Text(
              //       'Em Entrega',
              //       style: TextStyle(fontSize: 18),
              //     ),
              //   ],
              // ),
              // Divider(),
              // InkWell(
              //   onTap: () {
              //   },
              //   child: Row(
              //     children: [
              //       Padding(
              //         padding:
              //             const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              //         child: Icon(
              //           Icons.train_rounded,
              //           color: Colors.black,
              //           size: 50,
              //         ),
              //       ),
              //       Text(
              //         'Pedidos Entregues',
              //         style: TextStyle(fontSize: 18),
              //       ),
              //     ],
              //   ),
              // ),
              // Divider(),
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 5),
                      child: Icon(
                        Icons.account_balance_wallet_outlined,
                        color: Colors.black,
                        size: 50,
                      ),
                    ),
                    Text(
                      'Saldo e Transferência',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              Divider(),
              Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    child: Icon(
                      Icons.star,
                      color: Colors.black,
                      size: 50,
                    ),
                  ),
                  Text(
                    'Avaliações',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              Divider(),
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 5),
                      child: Icon(
                        Icons.price_change_outlined,
                        color: Colors.black,
                        size: 50,
                      ),
                    ),
                    Text(
                      'Preço por KM',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              Divider(),
              // InkWell(
              //   onTap: () {
              //   },
              //   child: Row(
              //     children: [
              //       Padding(
              //         padding: const EdgeInsets.symmetric(
              //             horizontal: 8, vertical: 5),
              //         child: Icon(
              //           Icons.av_timer_rounded,
              //           color: Colors.black,
              //           size: 50,
              //         ),
              //       ),
              //       Text(
              //         'Horario de Atividade',
              //         style: TextStyle(fontSize: 18),
              //       ),
              //     ],
              //   ),
              // ),
              // Divider(),
              Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    child: Icon(
                      Icons.motorcycle_outlined,
                      color: Colors.black,
                      size: 50,
                    ),
                  ),
                  Text(
                    'Configurar Veiculo',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    child: Icon(
                      Icons.settings,
                      color: Colors.black,
                      size: 50,
                    ),
                  ),
                  Text(
                    'Configurações',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              Divider(),
              InkWell(
                onTap: () {
                  logout();
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 5),
                      child: Icon(
                        Icons.logout,
                        color: Colors.black,
                        size: 50,
                      ),
                    ),
                    Text(
                      'Sair',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
