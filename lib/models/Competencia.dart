import 'interfaces/TextFilter.dart';

class Competencia implements TextFilterAdapter {
  int id;
  String mes;
  String ano;
  String descricao;
  String inicio;
  String fim;

  Competencia();

  Competencia.fromMapWeb(Map map) {
    id = map["id"];
    var mesAno = map["competencia_mes_ano"].split('/');
    mes = mesAno[0];
    ano = mesAno[1];
    descricao = map["descricao"];
    inicio = map["competencia_inicio"];
    fim = map["competencia_fim"];
  }

  String getIntervalo() {
    return '$inicio - $fim';
  }

  @override
  String toString() {
    return '$mes/$ano ($descricao)';
  }

  @override
  String texFilterPrint() {
    return "$mes/$ano ($descricao)";
  }
}
