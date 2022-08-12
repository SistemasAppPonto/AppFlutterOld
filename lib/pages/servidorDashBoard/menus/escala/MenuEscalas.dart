import 'dart:async';
import 'package:flutter/material.dart';
import 'package:registro_ponto_mobile/models/DiasTrabalhar.dart';
import 'package:registro_ponto_mobile/models/RegistroPonto.dart';
import 'package:registro_ponto_mobile/services/provider_mob_x/dash_board_servidor/ControllerDashBoardServidor.dart';
import 'package:registro_ponto_mobile/pages/util/MyBuilds.dart';
import 'package:registro_ponto_mobile/util/Util.dart';
import 'package:registro_ponto_mobile/util/core/Cores.dart';
import 'package:table_calendar/table_calendar.dart';

class MenuEscalas extends StatefulWidget {
  ControllerDashBoardServidor controllerDashBoardServidor;

  MenuEscalas(this.controllerDashBoardServidor);

  @override
  _MenuEscalasState createState() {
    return _MenuEscalasState();
  }
}

class _MenuEscalasState extends State<MenuEscalas> with TickerProviderStateMixin {
  Map<DateTime, List<DiasTrabalhar>> _eventos;

  // Example holidays
  Map<DateTime, List<RegistroPonto>> _holidays;

  List<DiasTrabalhar> _eventoSelecionado;
  List<RegistroPonto> _registrosPontos;
  List<RegistroPonto> _registrosSelecionado;
  DateTime _dataSelecionado;
  AnimationController _animationController;
  CalendarController _calendarController;
  int mes;
  TabController _controller;

  ControllerDashBoardServidor _controllerDashBoardServidor;

  @override
  void initState() {
    super.initState();
    this._controllerDashBoardServidor = widget.controllerDashBoardServidor;
    this._calendarController = CalendarController();
    this._animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    this._animationController.forward();
    this._controller = new TabController(length: 2, vsync: this);
    final _selectedDay = DateTime.now();
    this.mes = _selectedDay.month;

//    _eventos = {
//      _selectedDay.subtract(Duration(days: 30)): ['Event A0', 'Event B0', 'Event C0'],
//      _selectedDay.subtract(Duration(days: 27)): ['Event A1'],
//      _selectedDay.subtract(Duration(days: 20)): ['Event A2', 'Event B2', 'Event C2', 'Event D2'],
//      _selectedDay.subtract(Duration(days: 16)): ['Event A3', 'Event B3'],
//      _selectedDay.subtract(Duration(days: 10)): ['Event A4', 'Event B4', 'Event C4'],
//      _selectedDay.subtract(Duration(days: 4)): ['Event A5', 'Event B5', 'Event C5'],
//      _selectedDay.subtract(Duration(days: 2)): ['Event A6', 'Event B6'],
//      _selectedDay: ['Event A7', 'Event B7', 'Event C7', 'Event D7', 'Event A7', 'Event A7', 'Event A7'],
//      _selectedDay.add(Duration(days: 1)): ['Event A8', 'Event B8', 'Event C8', 'Event D8'],
//      _selectedDay.add(Duration(days: 3)): Set.from(['Event A9', 'Event A9', 'Event B9']).toList(),
//      _selectedDay.add(Duration(days: 7)): ['Event A10', 'Event B10', 'Event C10'],
//      _selectedDay.add(Duration(days: 11)): ['Event A11', 'Event B11'],
//      _selectedDay.add(Duration(days: 17)): ['Event A12', 'Event B12', 'Event C12', 'Event D12'],
//      _selectedDay.add(Duration(days: 22)): ['Event A13', 'Event B13'],
//      _selectedDay.add(Duration(days: 26)): ['Event A14', 'Event B14', 'Event C14'],
//    };
//
//
    _eventos = this._controllerDashBoardServidor.eventos;
    _holidays = this._controllerDashBoardServidor.holidays;

    _eventoSelecionado = _eventos[_selectedDay] ?? [];

    _registrosPontos = this._controllerDashBoardServidor.registrosPontos;

    _registrosSelecionado = carregarPontos(_selectedDay);
  }

  List<RegistroPonto> carregarPontos(DateTime date) {
    List<RegistroPonto> lista = [];

    for (RegistroPonto registro in _registrosPontos) {
      if (UtilFormat.getStringToDateTime(date, UtilFormat.FORMAT_DD_MM_YYYY) == registro.dataEntrada) {
        lista.add(registro);
      }
    }
    return lista;
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  carregarEventosHoje() {}

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');

    setState(() {
      if (events.length > 0) {
        _eventoSelecionado = events;
      }
      _dataSelecionado = day;
      _calendarController.setCalendarFormat(CalendarFormat.week);
      _registrosSelecionado = carregarPontos(day);
    });
    this._controllerDashBoardServidor.dateAtual = day;
  }

  Future<void> _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) async {
    print('CALLBACK: _onVisibleDaysChanged');
    this._controllerDashBoardServidor.inicializarDados();
    if (first.month == last.month) {
      this._controllerDashBoardServidor.dateAtual = first;
      await this._controllerDashBoardServidor.carregarEscalasPontoServidor(false);
    } else {
      this._controllerDashBoardServidor.dateAtual = first;
      await this._controllerDashBoardServidor.carregarEscalasPontoServidor(false);

      this._controllerDashBoardServidor.dateAtual = last;
      await this._controllerDashBoardServidor.carregarEscalasPontoServidor(false);
    }

    setState(() {
      _eventos = this._controllerDashBoardServidor.eventos;
      _holidays = this._controllerDashBoardServidor.holidays;
      _registrosPontos = this._controllerDashBoardServidor.registrosPontos;
    });
  }

  bool flagTeste = true;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("AAAAAAAAAAAAAAAAAAAAA");
      if(this.flagTeste){
        this.flagTeste = false; setState(() {
          _eventoSelecionado = this._controllerDashBoardServidor.eventosHoje;
        });

      }

    });
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        _buildTableCalendarWithBuilders(),
        const SizedBox(
          height: 8,
        ),
//        MyBuilds.buildButtons(_eventos, _calendarController, this._controllerDashBoardServidor),
        const Divider(
          color: Colors.black,
        ),
        Expanded(
            child: MyBuilds.buildEventList(_controller, _eventoSelecionado, _dataSelecionado, _registrosSelecionado)),
      ],
    );
  }

  // More advanced TableCalendar configuration (using Builders & Styles)
  Widget _buildTableCalendarWithBuilders() {
    return TableCalendar(
      initialSelectedDay: this._controllerDashBoardServidor.dateAtual,
      locale: 'pt_BR',
      calendarController: _calendarController,
      events: _eventos,
      holidays: _holidays,
      initialCalendarFormat: CalendarFormat.week,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.monday,
      availableCalendarFormats: const {
        CalendarFormat.month: 'Mês',
        CalendarFormat.week: 'Semana',
//        CalendarFormat.twoWeeks: '2 Semanas',
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        weekdayStyle: TextStyle().copyWith(color: Colors.black),
        weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
        holidayStyle: TextStyle().copyWith(color: Colors.red),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
        weekdayStyle: TextStyle().copyWith(color: Colors.black),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonTextStyle: TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Cores.destaqueColor,
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              color: Cores.primaria,
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style: TextStyle(color: Colors.white).copyWith(fontSize: 16.0),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            color: Colors.amber[400],
            width: 100,
            height: 100,
            child: Text(
              '${date.day}',
              style: TextStyle().copyWith(fontSize: 16.0),
            ),
          );
        },
        markersBuilder: (context, date, events, pontos) {
          final children = <Widget>[];

          if (pontos.isNotEmpty) {
            children.add(
              Positioned(
                right: 1,
                bottom: 1,
                child: MyBuilds.buildHolidaysMarker(date, pontos, _calendarController),
              ),
            );
          }

          if (events.isNotEmpty) {
            children.add(
              Positioned(
                left: 1,
                bottom: 1,
                child: MyBuilds.buildEventsMarker(date, events, _calendarController),
              ),
            );
          }

          return children;
        },
      ),
      onDaySelected: (date, events) {
        _onDaySelected(date, events);
        _animationController.forward(from: 0.0);
      },
      onVisibleDaysChanged: _onVisibleDaysChanged,
    );
  }
}
