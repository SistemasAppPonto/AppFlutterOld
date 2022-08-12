import 'package:flutter/material.dart';
import 'package:registro_ponto_mobile/models/interfaces/TextFilter.dart';

class AlertDialogCompetenciaFilter<T extends TextFilterAdapter> extends StatefulWidget {
  List<T> lista;
  T elementoAtual;

  AlertDialogCompetenciaFilter(this.lista, this.elementoAtual);

  @override
  _AlertDialogCompetenciaFilterState createState() => _AlertDialogCompetenciaFilterState<T>();
}

class _AlertDialogCompetenciaFilterState<T extends TextFilterAdapter> extends State<AlertDialogCompetenciaFilter> {
  TextEditingController _searchTextController = new TextEditingController();

  List<T> empresas;
  List<T> empresasFilter;
  T empresaAtual;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    empresas = widget.lista;
    empresasFilter = empresas;
    empresaAtual = empresas[0];

    _searchTextController.addListener(() {
      List<T> listFilter = List();
      String filter = _searchTextController.text;

      if (filter.length == 0) {
        listFilter = empresas;
      } else {
        for (T e in empresas) {
          if (e.texFilterPrint().contains(filter.toUpperCase())) {
            listFilter.add(e);
          }
        }
      }
      try {
        setState(() {
          empresasFilter = listFilter;
        });
      } catch (e, s) {
        print(s);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Container(
            width: double.maxFinite,
            child: new Column(children: <Widget>[
              new Padding(
                padding: new EdgeInsets.only(top: 20.0),
              ),
              new TextField(
                autofocus: true,
                decoration: new InputDecoration(labelText: "Digite o Nome da Empresa"),
                controller: _searchTextController,
              ),
              new Expanded(
                child: new ListView.builder(
                  itemCount: empresasFilter.length,
                  itemBuilder: (BuildContext context, int index) {
                    empresaAtual = empresasFilter[index];
                    String listTileText = empresaAtual.texFilterPrint();
                    return ListTile(
                        onTap: () {
                          empresaAtual = empresasFilter[index];
                          Navigator.pop(context);
                          setState(() {
                            widget.elementoAtual = empresaAtual;
                          });
                        },
                        title: Text(listTileText));
                  },
                ),
              )
            ])));
  }
}
