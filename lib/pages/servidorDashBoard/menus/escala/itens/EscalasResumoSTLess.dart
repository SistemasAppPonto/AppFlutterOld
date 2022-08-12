import 'package:flutter/material.dart';
import 'package:registro_ponto_mobile/models/DiasTrabalhar.dart';

class EscalasResumoLess extends StatelessWidget {
  List<DiasTrabalhar> eventoSelecionado;

  EscalasResumoLess(this.eventoSelecionado);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: eventoSelecionado.map((DiasTrabalhar diaTrabalho) {
        var localTrabalho = diaTrabalho.localTrabalho;
        var data = diaTrabalho.diaEntrada;


        List<Widget> lista = [];

        if (diaTrabalho.tipo_da_escala == '24H' || diaTrabalho.tipo_da_escala == '12H') {
          lista.add(Expanded(
              child: Column(
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Entrada"),
                  Text(
                    diaTrabalho.diaEntrada,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("Saida"),
                  Text(
                    diaTrabalho.horaEntrada1,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Entrada"),
                  Text(
                    diaTrabalho.diaSaida,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("Saida"),
                  Text(
                    diaTrabalho.horaSaida1,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Divider(
                color: Colors.black,
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("TOTAL:"),
                  Text(
                    diaTrabalho.totalHoras,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          )));
        } else {
          if (diaTrabalho.horaEntrada1 != null) {
            lista.add(Text(diaTrabalho.diaEntrada));
            lista.add(Text(
              "Ent:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ));
            lista.add(Text(
              diaTrabalho.horaEntrada1,
            ));
            lista.add(SizedBox(
              width: 10,
            ));
            lista.add(Text(
              "Sai:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ));
            lista.add(Text(
              diaTrabalho.horaSaida1,
            ));

//          lista.add(Text(
//            "H:",
//            style: TextStyle(fontWeight: FontWeight.bold),
//          ));
//          lista.add(Text(
//            diaTrabalho.totalHoas.toString(),
//          ));
          }

          if (diaTrabalho.horaEntrada2 != null) {
            lista.add(Text(diaTrabalho.diaEntrada));
            lista.add(Text(
              "Ent:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ));
            lista.add(Text(
              diaTrabalho.horaEntrada2,
            ));
            lista.add(SizedBox(
              width: 10,
            ));
            lista.add(Text(
              "Sai::",
              style: TextStyle(fontWeight: FontWeight.bold),
            ));
            lista.add(Text(
              diaTrabalho.horaSaida2,
            ));
          }

          if (diaTrabalho.horaEntrada3 != null) {
            lista.add(Text(diaTrabalho.diaEntrada));
            lista.add(Text(
              "Ent:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ));
            lista.add(Text(
              diaTrabalho.horaEntrada3,
            ));
            lista.add(SizedBox(
              width: 10,
            ));
            lista.add(Text(
              "Sai::",
              style: TextStyle(fontWeight: FontWeight.bold),
            ));
            lista.add(Text(
              diaTrabalho.horaSaida3,
            ));
          }
        }

        Icon icon;
        if (diaTrabalho.verificarJustificativa == 1) {
          icon = Icon(
//                                  Icons.check_circle,
            Icons.check_box,
            color: Colors.green,
          );
        } else if (diaTrabalho.verificarJustificativa == 2) {
          icon = Icon(
//                                  Icons.check_circle,
            Icons.error,
            color: Colors.red,
          );
        } else {
          icon = Icon(
//                                  Icons.check_circle,
            Icons.error,
            color: Colors.red,
          );
        }

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 0.8),
            borderRadius: BorderRadius.circular(12.0),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: ListTile(
            title: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Divider(
                        color: Colors.black,
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(
                            Icons.date_range,
                            color: Colors.cyan,
                          ),
                          Text(
                            "LOCAL: $localTrabalho",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          icon
                        ],
                      ),
                      Divider(
                        color: Colors.black,
                        height: 10,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: lista,
                      )
                    ],
                  ),
                ),
              ],
            ),
//                        subtitle: Text("ENTRADA"),
            onTap: () {
              print('tapped');
              print(diaTrabalho);
            },
          ),
        );
      }).toList(),
    );
  }
}
