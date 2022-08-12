import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:registro_ponto_mobile/pages/servidorDashBoard/pagePonto/controller/ControllerPonto.dart';
import 'package:registro_ponto_mobile/util/core/Cores.dart';
import 'package:registro_ponto_mobile/util/core/Texto.dart';
import 'package:registro_ponto_mobile/util/Util.dart';

class CameraDados extends StatefulWidget {
  ControllerPonto controllerPonto;

  CameraDados(this.controllerPonto);

  @override
  _CameraDadosState createState() => _CameraDadosState();
}

class _CameraDadosState extends State<CameraDados> {
  File image;
  bool _flagFoto = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 18, right: 10),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.camera,
                size: 30,
                color: _flagFoto ? Cores.primaria : Cores.vermelho,
              ),
              SizedBox(
                width: 50,
              ),
              Expanded(
                child: Center(
                  child: this._flagFoto ? pathImage() : getFotoImage(),
                ),
              ),
              SizedBox(
                width: 50,
              ),
              Icon(
                _flagFoto ? Icons.check_circle : Icons.error,
                color: _flagFoto ? Cores.verde : Cores.vermelho,
              )
            ],
          ),
        ],
      ),
    );
    ;
  }

  Widget getFotoImage() {
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
          Texto.textoBranco("VALIDAR FOTO")
        ],
      ),
      color: Colors.red,
      onPressed: () async {
        File file = await ImagePicker.pickImage(source: ImageSource.camera);
        if (file != null) {
          setState(() {
            this.image = file;
            this._flagFoto = true;
            widget.controllerPonto.validarFotoFile(true, file);
          });
        }
      },
    );
  }

  Widget pathImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image(width: 100, image: FileImage(File(this.image.path))),
        SizedBox(
          width: 5,
        ),
        Expanded(
          child: RaisedButton(
            shape: UtilWidget.shapeBordasAredondadas(Cores.primaria),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.refresh,
                  color: Cores.branco,
                ),
              ],
            ),
            color: Cores.primaria,
            onPressed: () async {
              File file = await ImagePicker.pickImage(source: ImageSource.camera);
              if (file != null) {
                setState(() {
                  this.image = file;
                  this._flagFoto = true;
                  widget.controllerPonto.validarFotoFile(true, file);
                });
              }
            },
          ),
        )
      ],
    );
  }
}
