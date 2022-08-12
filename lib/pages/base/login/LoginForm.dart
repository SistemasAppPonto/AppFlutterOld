import 'package:flutter/material.dart';
import 'package:registro_ponto_mobile/WebServices/WebServiceDio.dart';
import 'package:registro_ponto_mobile/WebServices/adapter/Adapter.dart';
import 'package:registro_ponto_mobile/models/Usuario.dart';
import 'package:registro_ponto_mobile/services/DeviceInfo.dart';
import 'package:registro_ponto_mobile/util/core/Constantes.dart';
import 'package:registro_ponto_mobile/util/core/Cores.dart';
import 'package:registro_ponto_mobile/util/Util.dart';

class LoginForm extends StatefulWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  LoginForm(this.scaffoldKey);

  @override
  State<StatefulWidget> createState() {
    return _LoginFormState();
  }
}

class _LoginFormState extends State<LoginForm> {
  final _controladorLogin = TextEditingController();
  final _controladorSenha = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _flagErro = false;

  @override
  void initState() {
    super.initState();
    setState(() {
//      _controladorLogin.text = 'ari@gmail.com';
//      _controladorSenha.text = 'ariari';

//      ANNA SYLVIA JUSTO ANGELO  RUFINO PORTELLA
      _controladorLogin.text = 'anna@gmail.com';
      _controladorSenha.text = 'annaanna';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Expanded(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 62),
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 60,
                    padding:
                        EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5)
                        ]),
                    child: TextFormField(
                      controller: _controladorLogin,
                      validator: (value) {
                        value = value.trim();
                        if (value.isEmpty) {
                          return Constantes.MSG_CAMPO_OBRIGATORIO;
                        }
                        if (_flagErro) {
                          return Constantes.MSG_LOGIN_SENHA_INVALIDOS;
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                        hintText: Constantes.LB_LOGIN,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 60,
                    margin: EdgeInsets.only(top: 32),
                    padding:
                        EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5)
                        ]),
                    child: TextFormField(
                      controller: _controladorSenha,
                      validator: (value) {
                        value = value.trim();
                        if (value.isEmpty) {
                          return Constantes.MSG_CAMPO_OBRIGATORIO;
                        }
                        if (_flagErro) {
                          return Constantes.MSG_LOGIN_SENHA_INVALIDOS;
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.vpn_key,
                          color: Colors.grey,
                        ),
                        hintText: Constantes.LB_SENHA,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16, right: 32),
                      child: Text(
                        'Esqueceu a Senha?',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width / 1.2,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Cores.primaria, Cores.secundaria],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: FlatButton(
                      onPressed: () {
                        _flagErro = false;
                        if (_formKey.currentState.validate()) {
                          Usuario user = Usuario();
                          user.login = _controladorLogin.text.trim();
                          user.senha = _controladorSenha.text.trim();
                          _showDashBoard(usuario: user);
                        } else {}
                      },
                      child: Text(
                        'Login'.toUpperCase(),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void _showDashBoard({Usuario usuario}) async {
    try {
      DeviceInfo device = DeviceInfo.getInstance();
      await device.getDeviceSerialNumber();

      print(device);

      Util.carregarProgressDialog(context, Constantes.MSG_CARREGANDO);
      bool isInternet = await Util.isInternet();
      if (!isInternet) {
        Util.desativarProgressDialog();
        Util.snackBar(widget.scaffoldKey.currentState,
            Constantes.MSG_CONEXAO_INTERNET, Colors.red, true,
            tempo: 3);
        return;
      }

      print('antes');
      WebServiceAdapter adapter =
          await WebServiceDio.getInstance(usuario).carregarDadosLogin();

      print('depois');
      print(adapter.flagResponser);

//      Servidor usuarioLogado = await WebServiceDio.getInstance(usuario).carregarDadosLogin();
      if (adapter.flagResponser == false) {
        this._flagErro = true;
        Util.desativarProgressDialog();
        if (adapter.mensagemResponser != null) {
          Util.snackBar(widget.scaffoldKey.currentState,
              adapter.mensagemResponser, Colors.red, false);
          return;
        }

        this._formKey.currentState.validate();
        return;
      }
      Usuario usuarioLogado = adapter.servidor;
      usuarioLogado.ativo = true;
      await usuarioLogado.save();
      Util.desativarProgressDialog();

      Navigator.pushReplacementNamed(context, 'dashServidor');
    } catch (e, s) {
      print('......');
      print(e);
      print(s);
      Util.desativarProgressDialog();
      Util.snackBar(widget.scaffoldKey.currentState,
          Constantes.MSG_PROBLEMA_SERVIDOR, Colors.red, false);
    }
  }
}
