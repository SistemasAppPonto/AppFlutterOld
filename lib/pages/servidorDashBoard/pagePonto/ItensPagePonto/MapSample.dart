import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:registro_ponto_mobile/WebServices/WebServiceDio.dart';
import 'package:registro_ponto_mobile/WebServices/adapter/Adapter.dart';
import 'package:registro_ponto_mobile/models/SubSetorEmpresaServidor.dart';
import 'package:registro_ponto_mobile/models/Usuario.dart';
import 'package:registro_ponto_mobile/pages/servidorDashBoard/pagePonto/controller/ControllerPonto.dart';
import 'package:registro_ponto_mobile/services/ServiceLocation.dart';
import 'package:registro_ponto_mobile/services/provider_mob_x/dash_board_servidor/ControllerDashBoardServidor.dart';
import 'package:registro_ponto_mobile/util/core/Constantes.dart';
import 'package:registro_ponto_mobile/util/core/Cores.dart';
import 'package:registro_ponto_mobile/util/Util.dart';

class MapSample extends StatefulWidget {
  final ControllerDashBoardServidor controllerDashBoardServidor;
  final ControllerPonto controllerPonto;

  MapSample(this.controllerDashBoardServidor, this.controllerPonto);

  @override
  State<MapSample> createState() =>
      MapSampleState(this.controllerDashBoardServidor, this.controllerPonto);
}

class MapSampleState extends State<MapSample> {
  ControllerDashBoardServidor controllerDashBoardServidor;
  final ControllerPonto controllerPonto;
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController controllerMap;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  static LatLng patosLatLng = LatLng(-7.0178, -37.275);

  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  Map<CircleId, Circle> _circles = <CircleId, Circle>{};

//  final Marker markerLocal = Marker(
//    infoWindow: InfoWindow(title: "asdasdasd"),
//    markerId: MarkerId('1'),
//    position: LatLng(-7.0295, -37.2765066),
//    onTap: () {
//      print('asdasdasd');
//    },
//  );

  final CameraPosition _kGooglePlex = CameraPosition(
    target: patosLatLng,
    zoom: 14.4746,
  );

  MapSampleState(this.controllerDashBoardServidor, this.controllerPonto);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('initState - MapSampleState');
    print(this.controllerDashBoardServidor.subsSetores);
    LocationService locationService = LocationService.getInstance();
//    locationService.getLocation().then((_) => {});

    for (SubSetorEmpresaServidor sub
        in this.controllerDashBoardServidor.subsSetores) {
      Circle circle = Circle(
          circleId: CircleId(sub.id.toString()),
          radius: sub.raio.ceilToDouble(),
          center: sub.getLatLng(),
          fillColor: Color.fromRGBO(171, 39, 133, 0.1),
          strokeColor: Color.fromRGBO(171, 39, 133, 0.5),
          onTap: () {
            print('circle pressed');
          });

      _circles[circle.circleId] = circle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: GoogleMap(
//        myLocationEnabled: true,
//        mapToolbarEnabled: true,

//
//        myLocationButtonEnabled: true,
//        buildingsEnabled: true,
//        compassEnabled: true,
//        indoorViewEnabled: true,
//        mapToolbarEnabled: true,
//        onCameraMoveStarted: _goToTheLake,
        circles: _circles.values.toSet(),
        markers: _markers.values.toSet(),
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          print('onMapCreated');
          _controller.complete(controller);
          controllerMap = controller;
          _goToTheLake();
        },
      ),
      floatingActionButton: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 70,
              child: FittedBox(
                child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(100.0),
                        side: BorderSide(color: Cores.primaria)),
                    color: Cores.primaria,
                    disabledColor: Colors.red,
                    onPressed: () {
                      _goToTheLake();
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.fingerprint,
                        ),
                        Text(
                          'asdasdad',
                          style: TextStyle(color: Cores.preto),
                        )
                      ],
                    )),
              ),
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future _goToTheLake() async {
    SubSetorEmpresaServidor subSetorAtual;
    await LocationService.getInstance().getLocation();
    final Marker markerLocal = Marker(
      infoWindow: InfoWindow(title: "asdasdasd"),
      markerId: MarkerId('1'),
      position: LocationService.getInstance().currentLocationValor,
      onTap: () {
//        print('asdasdasd');
      },
    );
    print('_goToTheLake');
    final CameraPosition _kLake = CameraPosition(
      target: markerLocal.position,
      zoom: 17.0,
    );
    controllerMap.animateCamera(CameraUpdate.newCameraPosition(_kLake));
    print('------------');
    print(controllerMap.getVisibleRegion());
    setState(() {
      _markers[markerLocal.markerId] = markerLocal;
    });

    print('atual');
    bool flag = false;
    print('................................................');
    this.controllerDashBoardServidor.subsSetores.forEach((subSetor) {
      print(subSetor);
      Circle circle = _circles[CircleId(subSetor.id.toString())];
      final double meter = Util.getDistance(
          Util.DISTANCE_METROS, circle.center, markerLocal.position);

      if (meter <= subSetor.raio) {
        flag = true;
        subSetorAtual = subSetor;
      }
    });
    this.controllerPonto.validarLocalizacao(flag);
print('------------------------------------------------------');
    if (!this.controllerPonto.flagValidarFoto) {
      Util.snackBar(scaffoldKey.currentState, 'Registre uma foto para o ponto',
          Colors.red, false);
      print('flagValidarFoto');
    }

    if (!this.controllerPonto.flagValidarLocalizacao) {
      Util.snackBar(scaffoldKey.currentState, 'Localizaçao  não validada',
          Colors.red, false);
      print('flagValidarLocalizacao');
    }

    if (this.controllerPonto.flagValidarFoto &&
        this.controllerPonto.flagValidarLocalizacao) {
      print("OK....");
      print(this.controllerPonto.image);

      Util.carregarProgressDialog(context, Constantes.ENVIANDO_RESGISTRO_PONTO);
      bool isInternet = await Util.isInternet();
      if (!isInternet) {
        Util.desativarProgressDialog();
        Util.snackBar(scaffoldKey.currentState, Constantes.MSG_CONEXAO_INTERNET,
            Colors.red, true,
            tempo: 3);
        return;
      }

      Usuario usuario = await Usuario.getAtivo();

      print('antes');
      WebServiceAdapter adapter = await WebServiceDio.getInstance(usuario)
          .salvarRegistroPonto(subSetorAtual);

      print('depois');
      print(adapter.flagResponser);

//      Servidor usuarioLogado = await WebServiceDio.getInstance(usuario).carregarDadosLogin();
      if (adapter.flagResponser == false) {
        Util.desativarProgressDialog();
        if (adapter.mensagemResponser != null) {
          Util.snackBar(scaffoldKey.currentState, adapter.mensagemResponser,
              Colors.red, false);
          return;
        }
      }
    }
  }
}
