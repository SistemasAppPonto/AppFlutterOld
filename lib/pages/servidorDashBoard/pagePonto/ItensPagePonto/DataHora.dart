import 'dart:async';

import 'package:flutter/material.dart';
import 'package:registro_ponto_mobile/util/Util.dart';
import 'package:registro_ponto_mobile/util/core/Cores.dart';

class DataHora extends StatefulWidget {
  @override
  _DataHoraState createState() => _DataHoraState();
}

class _DataHoraState extends State<DataHora> {
  Timer t;
  DateTime dateTime;
  String data;
  String hora;

  @override
  void initState() {
    super.initState();
    carregarDataHora();
    t = Timer.periodic(Duration(seconds: 20), (Timer t) {
      print('t');
      print(t);
      setState(() {
        carregarDataHora();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    t.cancel();
  }

  void carregarDataHora() {
    this.data = UtilFormat.getStringToDateTime(DateTime.now(), UtilFormat.FORMAT_DD_MM_YYYY);
    this.hora = UtilFormat.getStringToDateTime(DateTime.now(), UtilFormat.HORA_MINUTO);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 18, top: 5, bottom: 5),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.access_time,
            size: 30,
            color: Cores.primaria,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  data,
                ),
              )),
          Expanded(
              flex: 4,
              child: Center(
                child: Text(
                  hora,
                  style: TextStyle(fontSize: 30),
                ),
              )),
        ],
      ),
    );
  }
}
