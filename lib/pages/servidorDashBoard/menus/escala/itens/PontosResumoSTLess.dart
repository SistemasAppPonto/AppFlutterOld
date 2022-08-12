import 'package:flutter/material.dart';
import 'package:registro_ponto_mobile/models/DiasTrabalhar.dart';
import 'package:registro_ponto_mobile/models/RegistroPonto.dart';

class PontosResumoLess extends StatelessWidget {
  List<RegistroPonto> registrosSelecionado;

  PontosResumoLess(this.registrosSelecionado);

  @override
  Widget build(BuildContext context) {
    try {
      List<Widget> lista = registrosSelecionado.map((RegistroPonto registro) {
        String local = registro.local;
        String dataEntrada = registro.dataEntrada;
        String dataSaida = registro.dataSaida;
        String horaEntrada = registro.horaEntrada;
        String horaSaida = registro.horaSaida;

        List<Widget> lista = [];

        if (dataEntrada == dataSaida) {
          lista.add(
            Text(
              "Data: $dataEntrada",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        }

        lista.addAll([
          Divider(
            color: Colors.black,
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.location_on,
                color: Colors.cyan,
              ),
              Expanded(
                child: Text(
                  "LOCAL: $local",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              registro.horas == '---'
                  ? Icon(
//                                  Icons.check_circle,
                      Icons.error,
                      color: Colors.red,
                    )
                  : Icon(
//                                  Icons.check_circle,
                      Icons.check_box,
                      color: Colors.green,
                    ),
              Icon(
                Icons.access_time,
//                          Icons.fingerprint,
                color: Colors.cyan,
              )
            ],
          ),
          Divider(),
        ]);

        if (dataEntrada == dataSaida) {
          lista.add(Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text("Entrada"),
              Text(
                horaEntrada,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("Saida"),
              Text(
                horaSaida,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ));
        } else {
          lista.add(Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Entrada:"),
              Text(
                dataEntrada,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("Hora:"),
              Text(
                horaEntrada,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ));

          lista.add(Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Saida:    "),
              Text(
                dataSaida != null ? dataSaida : '---',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("Hora:"),
              Text(
                horaSaida != null ? horaSaida : '---',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ));
        }

        lista.add(
          Divider(
            color: Colors.black,
            height: 10,
          ),
        );
        lista.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("TOTAL:"),
            Text(
              registro.horas,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ));

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
                    children: lista,
                  ),
                ),
              ],
            ),
//                        subtitle: Text("ENTRADA"),
            onTap: () => print('event tapped!'),
          ),
        );
      }).toList();

      lista.add(Container(
        child: SizedBox(
          height: 40,
        ),
      ));

      return ListView(
        children: lista,
      );
    } catch (e, s) {
      print(e);
      print(s);
    }
  }
}
