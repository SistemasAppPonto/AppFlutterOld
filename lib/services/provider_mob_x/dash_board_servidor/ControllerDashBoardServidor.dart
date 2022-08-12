import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:registro_ponto_mobile/WebServices/WebServiceDio.dart';
import 'package:registro_ponto_mobile/WebServices/adapter/Adapter.dart';
import 'package:registro_ponto_mobile/models/Competencia.dart';
import 'package:registro_ponto_mobile/models/DiasTrabalhar.dart';
import 'package:registro_ponto_mobile/models/Escala.dart';
import 'package:registro_ponto_mobile/models/RegistroPonto.dart';
import 'package:registro_ponto_mobile/models/Usuario.dart';
import 'package:registro_ponto_mobile/models/SubSetorEmpresaServidor.dart';
import 'package:registro_ponto_mobile/util/Util.dart';

part 'ControllerDashBoardServidor.g.dart';

//flutter pub run build_runner buildControllerDashBoardServidor
class ControllerDashBoardServidor = ControllerBase with _$ControllerDashBoardServidor;

abstract class ControllerBase with Store {
  Usuario _usuario;

//  bool _flagCarregandoAcoesDash = true;

//  bool get flagCarregandoAcoesDash => _flagCarregandoAcoesDash;

  DateTime dateAtual;

  @observable
  bool flagValidarRegistroPonto = false;

  @observable
  List<Competencia> competencias;

  Competencia competenciaAtual;

  @observable
  List<SubSetorEmpresaServidor> subsSetores;

  @observable
  List<Escala> escalas;

  @observable
  List<RegistroPonto> registrosPontos;

  List<DiasTrabalhar> eventosHoje = [];
  List<RegistroPonto> holidaysHoje = [];

  @observable
  Map<DateTime, List<DiasTrabalhar>> eventos = {};
  Map<DateTime, List<RegistroPonto>> holidays = {};

  @action
  carregarEscalasPontoServidor(@required bool sincronizao) async {
//    await Future.delayed(Duration(seconds: 10));

    WebServiceAdapter adapter;
//    this._flagCarregandoAcoesDash = true;
    try {
      if (dateAtual == null) {
        dateAtual = DateTime.now();
      }

      var data = UtilFormat.getStringToDateTime(dateAtual, UtilFormat.FORMAT_MM_YYYY);
      bool flagEscala = false;

      this.escalas?.forEach((Escala escala) {
        if (escala.mesAno == data) {
          flagEscala = true;
          return;
        }
      });

      this._usuario = await Usuario.getAtivo();
      adapter = await WebServiceDio.getInstance(this._usuario)
          .carregarEscalasPontosServidorMesAtual(dateAtual, sincronizao: sincronizao);

      this.competencias = adapter.competencias;
      this.competenciaAtual = this.competencias[0];
      this.subsSetores = adapter.subsSetores;

      this.escalas.addAll(adapter.escalas);
      this.registrosPontos.addAll(adapter.registrosPontos);
      this.eventos.addAll(adapter.eventos);
      this.holidays.addAll(adapter.holidays);

//      this._flagCarregandoAcoesDash = false;
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  @action
  carregarResumoPorEscala(Competencia competencia) async {
    WebServiceAdapter adapter;
    try {
      this._usuario = await Usuario.getAtivo();
      adapter = await WebServiceDio.getInstance(this._usuario).carregarResumoCompenentencia(competencia);

      print('adapter');
      print(adapter);

//      this.competencias = adapter.competencias;
//      this.subsSetores = adapter.subsSetores;
//
//      this.escalas.addAll(adapter.escalas);
//      this.registrosPontos.addAll(adapter.registrosPontos);
//      this.eventos.addAll( adapter.eventos);
//      this.holidays .addAll( adapter.holidays);

//      this._flagCarregandoAcoesDash = false;
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  inicializarDados() {
    this.escalas = [];
    this.registrosPontos = [];
    this.eventos = {};
    this.holidays = {};
    this.eventosHoje = [];
    this.holidaysHoje = [];
  }

  validarAcessoRegistroPonto() {
    print("validarAcessoRegistroPonto");
    DateTime data = DateTime.now();
    if (this.flagValidarRegistroPonto == false) {
      if (this.eventos.length == 0) {
        this.flagValidarRegistroPonto = true;
      } else {
        this.eventos.forEach((d, e) {
          String dia = UtilFormat.getStringToDateTime(d, UtilFormat.FORMAT_DD_MM_YYYY);
          String hoje = UtilFormat.getStringToDateTime(data, UtilFormat.FORMAT_DD_MM_YYYY);
          print(dia);
          print(hoje);
          if (dia == hoje) {
            print("OBA....");
            this.flagValidarRegistroPonto = true;
            this.eventosHoje = e;
          }
        });
      }
    }
  }

  dispose() {
    print("SAIR");
  }
}
