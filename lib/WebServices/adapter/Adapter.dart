import 'package:registro_ponto_mobile/models/Competencia.dart';
import 'package:registro_ponto_mobile/models/DiasTrabalhar.dart';
import 'package:registro_ponto_mobile/models/Escala.dart';
import 'package:registro_ponto_mobile/models/RegistroPonto.dart';
import 'package:registro_ponto_mobile/models/Usuario.dart';
import 'package:registro_ponto_mobile/models/SubSetorEmpresaServidor.dart';

class WebServiceAdapter {
  WebServiceAdapter._();

  Usuario servidor;
  bool flagResponser;
  String mensagemResponser;

  List<Competencia> competencias;

  List<SubSetorEmpresaServidor> subsSetores;
  List<RegistroPonto> registrosPontos;
  List<Escala> escalas;

  Map<DateTime, List<DiasTrabalhar>> eventos;
  Map<DateTime, List<RegistroPonto>> holidays;

  iniciarAdapter() {
    this.flagResponser = false;
    this.mensagemResponser = null;
  }

  WebServiceAdapter.fromMapWebGetSetoresCompentenciasServidor(Map dados) {
    this.iniciarAdapter();
    eventos = {};
    holidays = {};
    competencias = [];
    for (dynamic obj in dados["compentencias"]) {
      competencias.add(Competencia.fromMapWeb(obj));
    }

    registrosPontos = [];
    for (dynamic obj in dados["registrosPontos"]) {
      RegistroPonto registro = RegistroPonto.fromMapWeb(obj);
      registrosPontos.add(registro);

      List<RegistroPonto> lista = holidays[registro.getDiaEntradaDataTime()];
      if (lista == null) {
        lista = [];
        lista.add(registro);
        holidays[registro.getDiaEntradaDataTime()] = lista;
      } else {
        print('AAAAAAAAAAAAAAAAAAAA');
      }
    }

    subsSetores = [];
    escalas = [];
    for (dynamic obj in dados["listaSubSetores"]) {
      subsSetores.add(SubSetorEmpresaServidor.fromMapWeb(obj['SubSetor']));
      for (dynamic escalaDias in obj["listaEscalas"]) {
        Escala escala = Escala.fromMapWeb(escalaDias['escala']);
        List<DiasTrabalhar> diasTrabalhar = [];
        for (dynamic dias in escalaDias['listaDiasTrabalhar']) {
          DiasTrabalhar dia = DiasTrabalhar.fromMapWeb(dias);
          diasTrabalhar.add(dia);

          List<DiasTrabalhar> lista = eventos[dia.getDiaEntradaDataTime()];
          if (lista == null) {
            lista = [];
            lista.add(dia);
            eventos[dia.getDiaEntradaDataTime()] = lista;
          } else {
            print('AAAAAAAAAAAAAAAAAAAA');
          }
        }
        escala.diasTrabalhar = diasTrabalhar;
        escalas.add(escala);
      }
    }
  }

  WebServiceAdapter.fromMapWebResumoCompetencia(Map dados) {
    this.iniciarAdapter();
    print('WebServiceAdapter.fromMapWebResumoCompetencia');
    print(dados);
  }

  WebServiceAdapter.fromMapWebAutenticarusuario(Map dados) {
    this.iniciarAdapter();
    print('fromMapWebAutenticarusuario');
    print(dados);
    this.flagResponser = dados['responser'];
    if (this.flagResponser) {
      this.servidor = Usuario.fromMapWeb(dados['servidor']);
      List<SubSetorEmpresaServidor> lista = SubSetorEmpresaServidor.getListFrom(dados['servidor']['locais_trabalho']);
      this.servidor.subSetoresEmpresaServidor = lista;
    } else {
      this.mensagemResponser = dados['mensagem'];
    }
    print('print(dados);');
  }

  WebServiceAdapter.fromMapWebStatusMensage(Map dados) {
    print('fromMapWebStatusMensage');
    this.flagResponser = dados['responser'];
    this.mensagemResponser = dados['mensagem'];
  }
}
