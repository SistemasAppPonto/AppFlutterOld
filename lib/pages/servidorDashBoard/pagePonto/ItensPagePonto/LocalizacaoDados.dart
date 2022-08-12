import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:registro_ponto_mobile/pages/servidorDashBoard/pagePonto/controller/ControllerPonto.dart';
import 'package:registro_ponto_mobile/util/Util.dart';
import 'package:registro_ponto_mobile/util/core/Cores.dart';
import 'package:registro_ponto_mobile/util/core/Texto.dart';

class LocalizacaoDados extends StatefulWidget {
  final ControllerPonto controllerPonto;

  LocalizacaoDados(this.controllerPonto);

  @override
  _LocalizacaoDadosState createState() => _LocalizacaoDadosState(this.controllerPonto);
}

class _LocalizacaoDadosState extends State<LocalizacaoDados> {
  bool flagLocation;
  LatLng userLocation;
  Timer t;
  final ControllerPonto controllerPonto;

  _LocalizacaoDadosState(this.controllerPonto);

  @override
  void initState() {
    super.initState();

    print('initState - INITSTATE _LocalizacaoDadosState');
//    locationService.ativarLocalizacaoAutomatica();
    flagLocation = false;
    t = Timer.periodic(Duration(seconds: 3), (Timer t) {
      print('VER');
      this.controllerPonto.carregarLocalizacao().then((bool flag) => {
            setState(() {
              this.flagLocation = flag;
            })
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 18, right: 10),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                flagLocation ? Icons.location_on : Icons.location_off,
                size: 30,
                color: flagLocation ? Cores.primaria : Cores.vermelho,
              ),
              SizedBox(
                width: 50,
              ),
              Expanded(
                child: Center(
                  child: flagLocation
                      ? (Observer(
                          builder: (_) {
                            if (this.controllerPonto.flagValidarLocalizacao) {
                              return Text('LOCALIZAÇÃO VALIDADA');
                            }
                            return Text('LOCALIZAÇÃO NÃO VALIDADA');
                          },
                        ))
                      : botaoAtiarLocalizao(),
                ),
              ),
              SizedBox(
                width: 50,
              ),
              Observer(
                builder: (_) {
                  print("Observer");
                  print(flagLocation);
                  print(this.controllerPonto.flagValidarLocalizacao);
                  if (flagLocation == false) {
                    return Icon(Icons.error, color: Cores.vermelho);
                  }

                  if (this.controllerPonto.flagValidarLocalizacao) {
                    return Icon(Icons.check_circle, color: Cores.verde);
                  }
                  return Icon(Icons.block, color: Cores.amarelo);
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget botaoAtiarLocalizao() {
    return RaisedButton(
      shape: UtilWidget.shapeBordasAredondadas(Cores.vermelho),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.my_location,
            color: Cores.branco,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Texto.textoBranco("ATIVAR LOCALIZAÇÃO"),
          )
        ],
      ),
      color: Colors.red,
      onPressed: () async {
        userLocation = await controllerPonto.locationService.getLocation();
        if (userLocation != null) {
          setState(() {
            flagLocation = true;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    t.cancel();
//    locationService.cancelarLocalizacaoAutomatica();
  }
}
