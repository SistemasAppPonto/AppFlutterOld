import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:registro_ponto_mobile/Sqlite/SQLUtil.dart';

class SubSetorEmpresaServidor {
  int id;
  String descricao;
  String latitude;
  String longitude;
  int jornadaTrabalho;
  String plantonista;
  String cargo;
  int raio;
  bool ativo;

  //  --------CONTRUTORES--------

  SubSetorEmpresaServidor();

  SubSetorEmpresaServidor.fromMapWeb(Map map) {
    id = map["id"];
    descricao = map["local"];
    longitude = map["longitude"];
    latitude = map["latitude"];
    cargo = map["cargo"];
    jornadaTrabalho = map["jornada_trabalho"];
    plantonista = map["plantonista"];
    ativo = map["ativo"];
    raio = map["raio"];
  }

  SubSetorEmpresaServidor.fromMapSqLite(Map map) {
    id = map[COL_ID];
    descricao = map[TabelaServidorSubSetorEmpresaServidor.COL_DESCRICAO];
    latitude = map[TabelaServidorSubSetorEmpresaServidor.COL_LATITUDE];
    longitude = map[TabelaServidorSubSetorEmpresaServidor.COL_LONGITUDE];
    jornadaTrabalho = map[TabelaServidorSubSetorEmpresaServidor.COL_JORNADA_TRABALHO];
    plantonista = map[TabelaServidorSubSetorEmpresaServidor.COL_PLANTONISTA];
    cargo = map[TabelaServidorSubSetorEmpresaServidor.COL_CARGO];
    ativo = map[COL_ATIVO] == 1 ? ativo = true : ativo = false;
  }

  //  --------CONVERSÕES--------
  Map toMap() {
    Map<String, dynamic> map = {
      COL_ID: id,
      TabelaServidorSubSetorEmpresaServidor.COL_DESCRICAO: descricao,
      TabelaServidorSubSetorEmpresaServidor.COL_LATITUDE: latitude,
      TabelaServidorSubSetorEmpresaServidor.COL_LONGITUDE: longitude,
      TabelaServidorSubSetorEmpresaServidor.COL_JORNADA_TRABALHO: jornadaTrabalho,
      TabelaServidorSubSetorEmpresaServidor.COL_PLANTONISTA: plantonista,
      TabelaServidorSubSetorEmpresaServidor.COL_CARGO: cargo,
      COL_ATIVO: ativo,
    };
    return map;
  }

  static getListFrom(List lista) {
    List<SubSetorEmpresaServidor> novaLista = [];
    for (final i in lista) {
      novaLista.add(SubSetorEmpresaServidor.fromMapWeb(i));
    }
    return novaLista;
  }

  LatLng getLatLng() {
    print("getLatLng");
    return LatLng(double.parse(this.latitude), double.parse(this.longitude));
  }

  @override
  String toString() {
    return 'SubSetorEmpresaServidor{id: $id, descricao: $descricao, latitude: $latitude, longitude: $longitude, jornadaTrabalho: $jornadaTrabalho, plantonista: $plantonista, cargo: $cargo, raio: $raio, ativo: $ativo}';
  }
}
