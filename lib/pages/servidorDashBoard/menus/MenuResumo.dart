import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registro_ponto_mobile/models/Competencia.dart';
import 'package:registro_ponto_mobile/pages/util/AlertDialogFilterBase.dart';
import 'package:registro_ponto_mobile/pages/util/MyBuilds.dart';
import 'package:registro_ponto_mobile/services/provider_mob_x/dash_board_servidor/ControllerDashBoardServidor.dart';

class MenuResumo extends StatefulWidget {
  final ControllerDashBoardServidor controllerDashBoardServidor;

  MenuResumo(this.controllerDashBoardServidor);

  @override
  _MenuResumoState createState() {
    return _MenuResumoState();
  }
}

class _MenuResumoState extends State<MenuResumo> {
  Competencia competenciaAtual;
  bool expanser = false;
  ControllerDashBoardServidor controllerDashBoardServidor;

  @override
  void initState() {
    super.initState();
//    this.compentencias =
    this.controllerDashBoardServidor = widget.controllerDashBoardServidor;
    competenciaAtual = controllerDashBoardServidor.competencias[0];
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = List();
    widgets.add(Padding(
      padding: EdgeInsets.only(top: 10),
      child: Text("Compentêcia"),
    ));
    widgets.add(MyAlertDialogsBuilds.menuCompetencia(context, competenciaAtual, _onTextPressEmpresa));

    widgets.add(Expanded(
        child: ListView(
      children: <Widget>[dados()],
    )));
    return Center(
      child: Column(children: widgets),
    );
  }

  void _onTextPressEmpresa() async {
    AlertDialogCompetenciaFilter alertEmpresas =
        AlertDialogCompetenciaFilter(controllerDashBoardServidor.competencias,
            competenciaAtual);
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertEmpresas;
        });

    setState(() {
      competenciaAtual = alertEmpresas.elementoAtual;
    });

//    Util.carregarProgressDialog1(context, "Carregando...");

//    if (e != null) {
//      WebServiceAdapter adapter = await WebServiceDio.carregarVeiculosEmpresa(e.id);
//
//      setState(() {
//        _currentCity = e;
//        veiculos = List();
//        veiculos = adapter.veiculos;
//        getDropDownMenuItemsVeiculos();
//        _currentVeiculo = veiculos[0];
//        abastecimentosList = List();
//        dadosVeiculo = _currentVeiculo.getPlacaModelo();
//      });
//    }

//    Util.desativarProgressDialog1();
  }

  Widget dados() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ExpansionPanelList(
        animationDuration: Duration(seconds: 1),
        children: [
          ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Período: ${competenciaAtual.getIntervalo()}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                );
              },
              body: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'PRICE: ',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'PRICE: ',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'PRICE: ',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'PRICE: ',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'PRICE: ',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'PRICE: ',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'PRICE: ',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'PRICE: ',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'PRICE: ',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'PRICE: ',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'PRICE: ',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              isExpanded: expanser),
          ExpansionPanel(
              body: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'PRICE: ',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              headerBuilder: (BuildContext context, bool isExpanded) {
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Resumo',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                    ),
                  ),
                );
              },
              isExpanded: true)
        ],
        expansionCallback: (int item, bool status) {
          setState(() {
            expanser = !expanser;
          });
        },
      ),
    );
  }
}
