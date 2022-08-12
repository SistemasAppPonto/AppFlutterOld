import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registro_ponto_mobile/util/core/Cores.dart';

import 'LoginForm.dart';

class LoginPage extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Scaffold scaffold = Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Cores.primaria, Cores.secundaria],
                ),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(
                  flex: 6,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.fingerprint,
                    size: 110,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5, right: 32),
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
          LoginForm(_scaffoldKey)
        ],
      ),
    );


    return scaffold;
  }
}
