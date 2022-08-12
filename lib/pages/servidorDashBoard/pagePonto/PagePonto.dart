import 'dart:async';

import 'package:flutter/material.dart';
import 'package:registro_ponto_mobile/models/Competencia.dart';
import 'package:registro_ponto_mobile/services/provider_mob_x/dash_board_servidor/ControllerDashBoardServidor.dart';
import 'package:registro_ponto_mobile/util/core/Cores.dart';
import 'package:registro_ponto_mobile/util/Util.dart';

import 'ItensPagePonto/CameraDados.dart';
import 'ItensPagePonto/DataHora.dart';
import 'ItensPagePonto/LocalizacaoDados.dart';
import 'ItensPagePonto/MapSample.dart';
import 'controller/ControllerPonto.dart';

class PagePonto extends StatefulWidget {
  final ControllerDashBoardServidor _controllerDashBoardServidor;

  PagePonto(this._controllerDashBoardServidor);

  @override
  _PagePontoState createState() {
    return _PagePontoState(this._controllerDashBoardServidor);
  }
}

class _PagePontoState extends State<PagePonto> {
  Competencia competenciaAtual;
  bool expanser = false;
  ControllerDashBoardServidor _controllerDashBoardServidor;
  ControllerPonto _controllerPonto;

  _PagePontoState(this._controllerDashBoardServidor) {
    this._controllerPonto = ControllerPonto();
  }

  Stream<DateTime> stream;

  @override
  void initState() {
    super.initState();
    print('_PagePontoState');
    print(_controllerDashBoardServidor.subsSetores);
  }

  @override
  Widget build(BuildContext context) {
    Widget dadosPessoais() {
      return Container(
        child: FlatButton(
          onPressed: () {
            print('on');
          },
          child: Container(
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.account_circle,
                  size: 30,
                  color: Cores.primaria,
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text("NOME COMPLETO"),
                      Text("CARGO"),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward,
                  color: Cores.primaria,
                )
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: Util.appBarPadrao(context,
          texto: 'MARCAR PONTO', iconFlag: true, iconBackPage: true),
      body: Column(
        children: <Widget>[
          dadosPessoais(),
          Divider(height: 2, color: Cores.primaria),
          DataHora(),
          Divider(height: 2, color: Cores.primaria),
          LocalizacaoDados(this._controllerPonto),
          Divider(height: 2, color: Cores.primaria),
          CameraDados(this._controllerPonto),
          Divider(height: 2, color: Cores.primaria),
          Expanded(
            child: MapSample(
                this._controllerDashBoardServidor, this._controllerPonto),
          )
        ],
      ),
    );
  }
}
