import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:registro_ponto_mobile/models/Usuario.dart';

import 'package:registro_ponto_mobile/util/core/Constantes.dart';
import 'package:registro_ponto_mobile/util/core/Cores.dart';
import 'adapters/ProgessDialogAdapter.dart';

class Util {
  static final int DISTANCE_METROS = 1;
  static final int DISTANCE_KILOMETROS = 2;

  static ProgressDialog _processDialog;
  static bool flagSuccess = false;
  static String mensagem;

  static dynamic getBase64(Usuario user) {
    String dados = user.login + '--' + user.senha;
    var bytes = utf8.encode(dados);
    var base64Str = base64.encode(bytes);
    return base64Str;
  }

  static void snackBar(ScaffoldState scafoof, String mensagem, Color cor, bool timeAuto, {tempo = 5}) {
    if (timeAuto) {
      scafoof.showSnackBar(SnackBar(
        content: Text(
          mensagem,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 10),
        ),
        backgroundColor: cor,
        duration: Duration(seconds: tempo),
      ));
    } else {
      scafoof.showSnackBar(SnackBar(
        content: Text(
          mensagem,
          textAlign: TextAlign.left,
        ),
        backgroundColor: cor,
        duration: Duration(minutes: 1),
        action: SnackBarAction(textColor: Colors.black, label: "Fechar", onPressed: () {}),
      ));
    }
  }

  static Future<bool> isInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  static void carregarProgressDialog(BuildContext context, String mensagem) {
    _processDialog = ProgressDialog(context, ProgressDialogType.Normal);
    _processDialog.setMessage(mensagem);
    _processDialog.show();
  }

  static void desativarProgressDialog() {
    if (_processDialog != null) {
      _processDialog.hide();
    }
  }

  static void atualizarProgressDialog(String mensagem) {
    if (_processDialog != null) {
      _processDialog.update(message: mensagem);
    }
  }

  static AppBar appBarPadrao(@required BuildContext context,
      {String texto, bool iconFlag = true, bool logoutFlag = false, bool iconBackPage = false}) {
    List<Widget> lista = [];

    if (iconFlag) {
      lista.add(Icon(
        Icons.fingerprint,
        size: 50,
        color: Colors.white,
      ));
    }

    lista.add(Text(
      texto != null ? texto : Constantes.MSG_APP_PONTO,
      style: TextStyle(
        color: Colors.white,
      ),
    ));

    List<Widget> acoes = [];

    if (iconFlag) {
      acoes.add(IconButton(
        icon: Icon(Icons.directions_walk),
        onPressed: () async {
          print('TESTE');
          await Usuario.removeAll();
          Navigator.pushReplacementNamed(context, 'splash');
        },
      ));
    }

    return AppBar(
      actions: acoes,
      leading: iconBackPage
          ? new IconButton(
              icon: new Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      backgroundColor: Cores.primaria,
      automaticallyImplyLeading: false,
      title: Row(
        children: lista,
      ),
    );
  }

  static double getDistance(int tipo, LatLng circle, LatLng marker) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((circle.latitude - marker.latitude) * p) / 2 +
        c(circle.latitude * p) * c(marker.latitude * p) * (1 - c((circle.longitude - marker.longitude) * p)) / 2;
    double valor = 12742 * asin(sqrt(a));

    switch (tipo) {
      case 1:
        return valor * 1000;
        break;
      case 2:
        return valor;
        break;
    }
  }

  static Future<void> startTimeSleep(int tempoSegundos, Function() function) async {
    await Future.delayed(Duration(seconds: tempoSegundos));
    print('startTimeSleep');
  }
}

class UtilFormat {
//  static final String FORMAR_DD_MM_YYYY = "dd/MM/yyyy hh:mm:ss";
  static final String FORMAT_DD_MM_YYYY_h_m = "dd/MM/yyyy hh:mm";
  static final String FORMAT_DD_MM_YYYY = "dd/MM/yyyy";
  static final String FORMAT_MM_YYYY = "MM/yyyy";
  static final String HORA_MINUTO = "HH:mm";

  static String getStringToDateTime(DateTime dateTime, String format) {
    return DateFormat(format).format(dateTime);
  }

  static DateTime getDateTimeToString(String data, String format) {
    return DateFormat(format).parse(data);
  }
}

class UtilWidget {
  static RoundedRectangleBorder shapeBordasAredondadas(Color cor) {
    return RoundedRectangleBorder(borderRadius: new BorderRadius.circular(18.0), side: BorderSide(color: cor));
  }
}
