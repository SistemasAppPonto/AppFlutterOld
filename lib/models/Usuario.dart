import 'package:registro_ponto_mobile/Sqlite/SQLUtil.dart';
import 'package:registro_ponto_mobile/Sqlite/SqLite.dart';
import 'package:registro_ponto_mobile/models/SubSetorEmpresaServidor.dart';
import 'package:sqflite/sqlite_api.dart';

class Usuario {
  int id;
  String nome;
  String login;
  String senha;
  String tipo;
  bool ativo;
  List<SubSetorEmpresaServidor> subSetoresEmpresaServidor;

  //  --------CONTRUTORES--------

  Usuario();

  Usuario.fromMapWeb(Map map) {
    id = map["id"];
    nome = map["nome"];
    login = map["login"];
    senha = map["senha"];
    tipo = map["tipo"];
    ativo = map["ativo"];
  }

  Usuario.fromMapSqLite(Map map) {
    id = map[COL_ID];
    nome = map[TabelaUsuario.COL_NOME];
    login = map[TabelaUsuario.COL_LOGIN];
    senha = map[TabelaUsuario.COL_SENHA];
    tipo = map[TabelaUsuario.COL_TIPO];
    ativo = map[COL_ATIVO] == 1 ? ativo = true : ativo = false;
  }

//  --------CONVERSÕES--------
  Map toMap() {
    Map<String, dynamic> map = {
      COL_ID: id,
      TabelaUsuario.COL_NOME: nome,
      TabelaUsuario.COL_LOGIN: login,
      TabelaUsuario.COL_SENHA: senha,
      TabelaUsuario.COL_TIPO: tipo,
      COL_ATIVO: ativo,
    };
    return map;
  }

//  --------SQL--------
  Future save() async {
    Database dataBase = await SqlHelper().db;
//    int valor = await dataBase.insert(TabelaUsuario.NOME_TABELA, toMap());
    await dataBase.insert(TabelaUsuario.NOME_TABELA, toMap());
  }

  static Future<List<Usuario>> getAll() async {
    Database dataBase = await SqlHelper().db;
    List listMap = await dataBase.rawQuery(SQL_UTIL.sqlGetAll(TabelaUsuario.NOME_TABELA));
    List<Usuario> usuarios = List();
    for (Map m in listMap) {
      usuarios.add(Usuario.fromMapSqLite(m));
    }
    return usuarios;
  }

  static Future<Usuario> getAtivo() async {
    Database dataBase = await SqlHelper().db;
    List listMapUsuario = await dataBase.rawQuery(SQL_UTIL.sqlGetAllPorAtivo(TabelaUsuario.NOME_TABELA, true));
    if (listMapUsuario.length > 0) {
      Usuario usuario = Usuario.fromMapSqLite(listMapUsuario.first);
      return usuario;
    }
    return null;
  }

  static Future removeAll() async {
    Database dataBase = await SqlHelper().db;
    await dataBase.rawDelete(SQL_UTIL.sqlRemoveAll(TabelaUsuario.NOME_TABELA));
  }

  @override
  String toString() {
    return 'Usuario{id: $id, nome: $nome, login: $login, senha: $senha, tipo: $tipo, ativo: $ativo, subSetoresEmpresaServidor: $subSetoresEmpresaServidor}';
  }


}
