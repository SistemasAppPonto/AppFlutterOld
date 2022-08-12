import 'package:registro_ponto_mobile/util/Util.dart';

import 'RegistroPonto.dart';

class DiasTrabalhar {
  int id;
  String diaEntrada;
  String diaSaida;

  String horaEntrada1;
  String horaSaida1;

  String horaEntrada2;
  String horaSaida2;

  String horaEntrada3;
  String horaSaida3;

  String tipo_da_escala;
  String localTrabalho;
  String totalHoras;
  int verificarJustificativa;

  List<RegistroPonto> pontos;

  DiasTrabalhar();

  DiasTrabalhar.fromMapWeb(Map map) {
    this.id = map["id"];
    this.diaEntrada = map['dia_entrada'];
    this.diaSaida = map['dia_saida'];

    this.horaEntrada1 = map['hora_entrada_1_escala'];
    this.horaSaida1 = map['hora_saida_1_escala'];

    this.horaEntrada2 = map['hora_entrada_2_escala'];
    this.horaSaida2 = map['hora_saida_2_escala'];

    this.horaEntrada3 = map['hora_entrada_3_escala'];
    this.horaSaida3 = map['hora_saida_3_escala'];
    this.tipo_da_escala = map['tipo_da_escala'];
    this.localTrabalho = map['localTrabalho'];
    this.verificarJustificativa = map['verificarJustificativa'];
    this.totalHoras = map['totalHoras'];
  }

  DateTime getDiaEntradaDataTime() {
    return UtilFormat.getDateTimeToString(this.diaEntrada, UtilFormat.FORMAT_DD_MM_YYYY);
  }

  @override
  String toString() {
    return 'DiasTrabalhar{id: $id, diaEntrada: $diaEntrada, diaSaida: $diaSaida, horaEntrada1: $horaEntrada1, horaSaida1: $horaSaida1, horaEntrada2: $horaEntrada2, horaSaida2: $horaSaida2, horaEntrada3: $horaEntrada3, horaSaida3: $horaSaida3, tipo_da_escala: $tipo_da_escala, localTrabalho: $localTrabalho, verificarJustificativa: $verificarJustificativa}';
  }
}
