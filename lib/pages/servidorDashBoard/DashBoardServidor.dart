import 'package:flutter/material.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:registro_ponto_mobile/services/provider_mob_x/dash_board_servidor/ControllerDashBoardServidor.dart';
import 'package:registro_ponto_mobile/util/core/Cores.dart';
import 'package:registro_ponto_mobile/util/Util.dart';

import 'package:registro_ponto_mobile/pages/servidorDashBoard/menus/escala/MenuEscalas.dart';
import 'package:registro_ponto_mobile/pages/servidorDashBoard/menus/MenuResumo.dart';

import 'package:registro_ponto_mobile/pages/servidorDashBoard/pagePonto/PagePonto.dart';

class DashBoardServidor extends StatefulWidget {
  @override
  _DashBoardServidorState createState() => _DashBoardServidorState();
}

class _DashBoardServidorState extends State<DashBoardServidor> {
  int selectedIndex = 0;
  Widget atual;

  ControllerDashBoardServidor controllerDashBoardServidor;

  _DashBoardServidorState() {
    this.controllerDashBoardServidor = ControllerDashBoardServidor();
    this.controllerDashBoardServidor.inicializarDados();
  }

  @override
  void initState() {
    super.initState();
    this.atual = getMenuEscala();
  }

  carregarEscalas() async {
    await this.controllerDashBoardServidor.carregarEscalasPontoServidor(false);
    this.controllerDashBoardServidor.validarAcessoRegistroPonto();
    print('carregarEscalas');
    print(this.controllerDashBoardServidor.subsSetores);


  }

  Widget getMenuEscala() {
    return FutureBuilder(
      future: carregarEscalas(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return MenuEscalas(this.controllerDashBoardServidor);

          case ConnectionState.waiting:
            return Container(
              child: Center(
                child: Text('11111111111111'),
              ),
            );

          default:
            return Container(
              child: Center(
                child: Text('aaaaaaaaaaa'),
              ),
            );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Scaffold scaffold = Scaffold(
      appBar: Util.appBarPadrao(context),
      body: this.atual,
      floatingActionButton: Container(
        height: 80,
        width: 80,
        child: FittedBox(child: Observer(
          builder: (context) {
            return FloatingActionButton(
              backgroundColor: this.controllerDashBoardServidor.flagValidarRegistroPonto ? Cores.primaria : Colors.grey,
              onPressed: () {
                print("FloatingActionButton");
                print(this.controllerDashBoardServidor.flagValidarRegistroPonto);
                print(this.controllerDashBoardServidor.eventos);
                print(this.controllerDashBoardServidor.subsSetores);

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PagePonto(this.controllerDashBoardServidor)),
                );
              },
              child: Icon(
                Icons.fingerprint,
              ),
            );
          },
        )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
            barBackgroundColor: Cores.inativeColor,
            selectedItemBackgroundColor: Cores.primaria,
            selectedItemIconColor: Colors.white,
            selectedItemLabelColor: Colors.black,
            selectedItemBorderColor: Cores.primaria,
            unselectedItemLabelColor: Cores.primaria,
            unselectedItemIconColor: Cores.primaria),
        selectedIndex: selectedIndex,
        onSelectTab: (index) => _onItemTapped(index),
        items: [
          FFNavigationBarItem(
            iconData: Icons.calendar_today,
            label: 'Escalas',
            itemWidth: 20,
          ),
          FFNavigationBarItem(
            label: '',
          ),
          FFNavigationBarItem(
            iconData: Icons.assignment,
            label: 'Resumos',
          ),
        ],
      ),
    );
    return Provider<ControllerDashBoardServidor>(
      create: (_) => this.controllerDashBoardServidor,
      child: scaffold,
    );
  }

  _onItemTapped(int index) {
    Widget novo;
//    if (this.controllerDashBoardServidor.flagCarregandoAcoesDash == false) {
    if (index == 0) {
      novo = getMenuEscala();
    }
    if (index == 2) {
      novo = getMenuResumo();
    }
    setState(() {
      this.selectedIndex = index;
      this.atual = novo;
    });
//    }
  }

  Widget getMenuResumo() {
    return FutureBuilder(
      future: this.controllerDashBoardServidor.carregarResumoPorEscala(controllerDashBoardServidor.competenciaAtual),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return MenuResumo(this.controllerDashBoardServidor);

          case ConnectionState.waiting:
            return Container(
              child: Center(
                child: Placeholder(
                  strokeWidth: 50,
                ),
              ),
            );

          default:
            return Container(
              child: Center(
                child: Text('aaaaaaaaaaa'),
              ),
            );
        }
      },
    );
  }
}
