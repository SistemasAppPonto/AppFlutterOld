import 'DiasTrabalhar.dart';

class Escala {
  int id;
  int idCompentencia;
  String _diaEntrada;
  String plantonista;
  String mesAno;
  List<DiasTrabalhar> diasTrabalhar;

  Escala();

  Escala.fromMapWeb(Map map) {
    this.id = map["id"];
    this.idCompentencia = map["competencia_id"];
    this.mesAno = map["mes_ano"];
    this.plantonista = map["plantonista"];
  }

  @override
  String toString() {
    return 'Escala{id: $id, idCompentencia: $idCompentencia, _diaEntrada: $_diaEntrada, plantonista: $plantonista, mesAno: $mesAno, diasTrabalhar: $diasTrabalhar}';
  }
}
