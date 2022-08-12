import 'dart:async';
import 'package:flutter/material.dart';
import 'package:registro_ponto_mobile/models/Usuario.dart';
import 'package:registro_ponto_mobile/util/core/Cores.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return await Timer(_duration, navigationPage);
  }

  Future<void> navigationPage() async {
    Usuario servidor = await Usuario.getAtivo();
    print("navigationPage");
    print("servidor");
    print(servidor);
    if (servidor == null) {
      Navigator.pushReplacementNamed(context, 'loginPage');
    } else {
      Navigator.pushReplacementNamed(context, 'dashServidor');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Cores.primaria,
        body: Center(
          child: Icon(
            Icons.fingerprint,
            size: 150,
            color: Colors.white,
          ),
        ));
  }
}
