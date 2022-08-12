import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:registro_ponto_mobile/models/Competencia.dart';
import 'package:registro_ponto_mobile/models/SubSetorEmpresaServidor.dart';
import 'package:registro_ponto_mobile/models/Usuario.dart';
import 'package:registro_ponto_mobile/services/DeviceInfo.dart';
import 'package:registro_ponto_mobile/util/Util.dart';
import 'package:registro_ponto_mobile/util/exceptions/Exceptions.dart';

import 'adapter/Adapter.dart';
import 'adapter/URLs.dart';

class WebServiceDio {
  static WebServiceDio _instance;

  Dio _dio;
  Response _response;
  String _base64Str;
  Map _mapResponser;
  Map _dadosRequest;
  Map _dadosResponser;
  bool _flag;

  WebServiceDio._(Usuario servidor) {
    _dio = Dio();
    _base64Str = Util.getBase64(servidor);
  }

  static WebServiceDio getInstance(Usuario servidor) {
    return _instance = _instance ?? WebServiceDio._(servidor);
  }

  Future<WebServiceAdapter> carregarDadosLogin() async {
    DeviceInfo device = await DeviceInfo.getInstance();
    _dadosRequest = {
      'base64': _base64Str,
      'end_point': URLS.END_POINT_AUTENTICAR_SERVIDOR,
      'dados': {'imei': device.imei}
    };
    try {
      _response = await _dio.post(URLS.URL_END_POINT, data: _dadosRequest);
      _mapResponser = jsonDecode(_response.toString());
      return WebServiceAdapter.fromMapWebAutenticarusuario(_mapResponser);
    } catch (e, s) {
      print('AQUI;');
      print(e);
      print(s);
      throw DioException(DioException.mensagemPadrao);
    }
  }

  Future<WebServiceAdapter> carregarEscalasPontosServidorMesAtual(
      @required DateTime dataTime,
      {sincronizao = false}) async {
    _dadosRequest = {
      'base64': _base64Str,
      'end_point': URLS.END_POINT_GET_ESCALAS_PONTOS_SERVIDOR_MES_ANO,
      'dados': {
        'dataAtual': UtilFormat.getStringToDateTime(
            dataTime, UtilFormat.FORMAT_DD_MM_YYYY)
      }
    };
    try {
      _response = await _dio.post(URLS.URL_END_POINT, data: _dadosRequest);
      _mapResponser = jsonDecode(_response.toString());
      _flag = _mapResponser['responser'];
      _dadosResponser = _mapResponser['dados'];
      if (_flag) {
        return WebServiceAdapter.fromMapWebGetSetoresCompentenciasServidor(
            _dadosResponser);
      } else {
        return null;
      }
    } catch (e, s) {
      print(e);
      print(s);
      throw DioException(DioException.mensagemPadrao);
    }
  }

  Future<WebServiceAdapter> carregarResumoCompenentencia(
      Competencia compentencia) async {
    _dadosRequest = {
      'base64': _base64Str,
      'end_point': URLS.END_POINT_GET_RESUMO_COMPETENCIA,
      'dados': {}
    };
    try {
      _response = await _dio.post(URLS.URL_END_POINT, data: _dadosRequest);
      _mapResponser = jsonDecode(_response.toString());
      _flag = _mapResponser['responser'];
      _dadosResponser = _mapResponser['dados'];
      if (_flag) {
        return WebServiceAdapter.fromMapWebResumoCompetencia(_dadosResponser);
      } else {
        return null;
      }
    } catch (e, s) {
      print(e);
      print(s);
      throw DioException(DioException.mensagemPadrao);
    }
  }

  Future<WebServiceAdapter> salvarRegistroPonto(
      SubSetorEmpresaServidor subSetor) async {
    print('salvarRegistroPonto');

    _dadosRequest = {
      'base64': _base64Str,
      'end_point': URLS.END_POINT_SAVE_REGISTRO_PONTO,
      'dados': {}
    };
    try {
      _response = await _dio.post(URLS.URL_END_POINT, data: _dadosRequest);
      _mapResponser = jsonDecode(_response.toString());
      return WebServiceAdapter.fromMapWebStatusMensage(_mapResponser);
    } catch (e, s) {
      print(e);
      print(s);
      throw DioException(DioException.mensagemPadrao);
    }
  }
}
