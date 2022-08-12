const String COL_ID = "id";
const String COL_ATIVO = "ativo";

class SQL_UTIL {
  static String sqlGetAllPorAtivo(String nomeTabela, bool ativo) {
    int valor;
    ativo == true ? valor = 1 : valor = 0;
    return "SELECT * FROM $nomeTabela where $COL_ATIVO='$valor'";
  }

  static String sqlGetAll(String nomeTabela) {
    return "SELECT * FROM $nomeTabela";
  }

  static String sqlGetPorId(String nomeTabela, int id) {
    return "SELECT * FROM $nomeTabela where $COL_ID='$id'";
  }

  static String sqlRemoveId(String nomeTabela, int id) {
    return "DELETE FROM $nomeTabela where $COL_ID='$id'";
  }

  static String sqlRemoveAll(String nomeTabela) {
    return "DELETE FROM $nomeTabela ";
  }
}

class TabelaUsuario {
  TabelaUsuario._();

  static const String NOME_TABELA = "usuario";

//  ----------------------------------------------
  static const String COL_NOME = "nome";
  static const String COL_LOGIN = "login";
  static const String COL_SENHA = "senha";
  static const String COL_TIPO = "tipo";

  static const createTable = "CREATE TABLE $NOME_TABELA ( "
      "$COL_ID INTEGER PRIMARY KEY, "
      "$COL_NOME TEXT, "
      "$COL_LOGIN TEXT, "
      "$COL_SENHA TEXT, "
      "$COL_TIPO TEXT, "
      "$COL_ATIVO BOOL);";
}

class TabelaServidorSubSetorEmpresaServidor {
  TabelaServidorSubSetorEmpresaServidor._() {}

  static const String NOME_TABELA = "sub_servidor_empresa_servidor";

  //  ----------------------------------------------
  static const String COL_DESCRICAO = "descricao";
  static const String COL_LATITUDE = "latitude";
  static const String COL_LONGITUDE = "longitude";
  static const String COL_JORNADA_TRABALHO = "jornadaTrabalho";
  static const String COL_PLANTONISTA = "plantonista";
  static const String COL_CARGO = "cargo";

  static const createTable = "CREATE TABLE $NOME_TABELA ( "
      "$COL_ID INTEGER PRIMARY KEY, "
      "$COL_DESCRICAO TEXT, "
      "$COL_LATITUDE TEXT, "
      "$COL_LONGITUDE TEXT, "
      "$COL_JORNADA_TRABALHO TEXT, "
      "$COL_PLANTONISTA TEXT, "
      "$COL_CARGO TEXT, "
      "$COL_ATIVO BOOL);";
}
