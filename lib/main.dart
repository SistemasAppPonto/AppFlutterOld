import 'package:flutter/material.dart';
import 'package:registro_ponto_mobile/pages/base/SplashScreem.dart';
import 'package:registro_ponto_mobile/pages/base/login/LoginPage.dart';
import 'package:registro_ponto_mobile/pages/servidorDashBoard/DashBoardServidor.dart';
import 'package:intl/date_symbol_data_local.dart';



//void main() => runApp(MainApp());
void main() => initializeDateFormatting().then((_) => runApp(MainApp()));


class MainApp extends StatelessWidget {


  Map<String, WidgetBuilder> _rotas = <String, WidgetBuilder>{
    'loginPage': (_) => LoginPage(),
    'dashServidor': (_) => DashBoardServidor(),
    'splash': (_) => Splash(),
//    'dashAdmin': (_) => DashBoardAdmin(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      routes: _rotas,
      home: Splash(),
    );
  }
}
