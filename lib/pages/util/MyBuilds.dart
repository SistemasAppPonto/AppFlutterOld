import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:registro_ponto_mobile/models/Competencia.dart';
import 'package:registro_ponto_mobile/models/DiasTrabalhar.dart';
import 'package:registro_ponto_mobile/models/RegistroPonto.dart';
import 'package:registro_ponto_mobile/pages/servidorDashBoard/menus/escala/itens/EscalasResumoSTLess.dart';
import 'package:registro_ponto_mobile/pages/servidorDashBoard/menus/escala/itens/PontosResumoSTLess.dart';
import 'package:registro_ponto_mobile/services/provider_mob_x/dash_board_servidor/ControllerDashBoardServidor.dart';
import 'package:registro_ponto_mobile/util/core/Cores.dart';
import 'package:table_calendar/table_calendar.dart';

class MyBuilds {
  static Widget buildEventsMarker(DateTime date, List events, CalendarController calendarController) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: calendarController.isSelected(date)
            ? Colors.brown[500]
            : calendarController.isToday(date) ? Colors.brown[300] : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  static Widget buildHolidaysMarker(DateTime date, List holids, CalendarController calendarController) {
//    return Icon(Icons.add_box, size: 20.0, color: Colors.blueGrey[800]);

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: calendarController.isSelected(date)
               ? Colors.brown[500]
               : calendarController.isToday(date) ? Colors.brown[300] : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${holids.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );

  }

  static Widget buildButtons(CalendarController calendarController,
      ControllerDashBoardServidor controller) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
//          RaisedButton(
//            child: Text('Set day ${dateTime.day}-${dateTime.month}-${dateTime.year}'),
//            onPressed: () {
//              calendarController.setSelectedDay(
//                DateTime(dateTime.year, dateTime.month, dateTime.day),
//                runCallback: true,
//              );
//            },
//          ),
        ],
      ),
    );
  }

  static Widget buildEventList(TabController controller, List<DiasTrabalhar> eventoSelecionado,
      DateTime dataSelecionado, List<RegistroPonto> registrosSelecionado) {

    List<Widget> lista = [];
    lista.add(Container(
      decoration: BoxDecoration(color: Cores.inativeColor, borderRadius: BorderRadius.circular(50)),
      child: TabBar(
        unselectedLabelColor: Colors.black,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          gradient: LinearGradient(colors: [Cores.primaria, Cores.primaria]),
          borderRadius: BorderRadius.circular(50),
        ),
        controller: controller,
        tabs: [
          new Tab(
            text: 'Escalas',
          ),
          new Tab(
            text: 'Pontos',
          ),
        ],
      ),
    ));
    lista.add(Expanded(
        child: Container(
      color: Colors.grey[100],
      child: TabBarView(
        controller: controller,
        children: <Widget>[
          EscalasResumoLess(eventoSelecionado),
          PontosResumoLess(registrosSelecionado),
        ],
      ),
    )));


    return Column(children: lista);
  }
}

class MyAlertDialogsBuilds {
  static Widget menuCompetencia(BuildContext context, Competencia objetoFilter, Function() _onTextPressEmpresa) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border.all(color: Cores.primaria, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          width: MediaQuery.of(context).size.width,
          height: 65,
          padding: EdgeInsets.all(10),
          child: GestureDetector(
            child: Center(
              child: Text(
                objetoFilter.texFilterPrint(),
                style: TextStyle(fontSize: 20),
              ),
            ),
            onTap: _onTextPressEmpresa,
          )),
    );
  }
}
