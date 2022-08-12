class DioException implements Exception {
  static String mensagemPadrao = 'Erro de Conexão, contactar o ADMIN';

  String _msg;

  DioException(String msg) {
    this._msg = msg;
  }

  String errMsg() => this._msg;
}
