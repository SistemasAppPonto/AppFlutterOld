
import 'dart:io';

import 'package:mobx/mobx.dart';
import 'package:registro_ponto_mobile/services/ServiceLocation.dart';

part 'ControllerPonto.g.dart';

class ControllerPonto = ControllerBase with _$ControllerPonto;

abstract class ControllerBase with Store {
  LocationService locationService;
  File image;

  ControllerBase() {
    locationService = LocationService.getInstance();
  }
  @observable
  bool flagValidarLocalizacao = false;

  @observable
  bool flagValidarFoto = false;

  @action
  validarLocalizacao(bool flag) {
    this.flagValidarLocalizacao = flag;
  }

  validarFotoFile(bool flag, File file) {
    this.flagValidarFoto = flag;
    this.image = file;
  }

  Future<bool> carregarLocalizacao() async {
    return await locationService.location.serviceEnabled();
  }
}
