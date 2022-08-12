import 'package:registro_ponto_mobile/util/Util.dart';

class RegistroPonto {
  int id;
  bool ativo;
  String local;
  String dataEntrada;
  String horaEntrada;
  String dataSaida;
  String horaSaida;
  String horas;

  RegistroPonto();

  RegistroPonto.fromMapWeb(Map map) {
    this.id = map['id'];
    this.ativo = map['ativo'];
    this.local = map['local'];
    this.dataEntrada = map['dataEntrada'];
    this.horaEntrada = map['horaEntrada'];
    this.dataSaida = map['dataSaida'];
    this.horaSaida = map['horaSaida'];
    this.horas = map['horas'];
  }

  DateTime getDiaEntradaDataTime() {
    return UtilFormat.getDateTimeToString(this.dataEntrada, UtilFormat.FORMAT_DD_MM_YYYY);
  }

  String getTotalHora() {
    DateTime d1 = UtilFormat.getDateTimeToString('$dataEntrada $horaEntrada', UtilFormat.FORMAT_DD_MM_YYYY_h_m);
    DateTime d2 = UtilFormat.getDateTimeToString('$dataSaida $horaSaida', UtilFormat.FORMAT_DD_MM_YYYY_h_m);

    print(d2.difference(d1));

    return 'teste';
  }
}
