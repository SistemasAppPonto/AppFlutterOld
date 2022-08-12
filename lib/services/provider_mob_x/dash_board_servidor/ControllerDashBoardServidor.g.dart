// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ControllerDashBoardServidor.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ControllerDashBoardServidor on ControllerBase, Store {
  final _$flagValidarRegistroPontoAtom =
      Atom(name: 'ControllerBase.flagValidarRegistroPonto');

  @override
  bool get flagValidarRegistroPonto {
    _$flagValidarRegistroPontoAtom.context
        .enforceReadPolicy(_$flagValidarRegistroPontoAtom);
    _$flagValidarRegistroPontoAtom.reportObserved();
    return super.flagValidarRegistroPonto;
  }

  @override
  set flagValidarRegistroPonto(bool value) {
    _$flagValidarRegistroPontoAtom.context.conditionallyRunInAction(() {
      super.flagValidarRegistroPonto = value;
      _$flagValidarRegistroPontoAtom.reportChanged();
    }, _$flagValidarRegistroPontoAtom,
        name: '${_$flagValidarRegistroPontoAtom.name}_set');
  }

  final _$competenciasAtom = Atom(name: 'ControllerBase.competencias');

  @override
  List<Competencia> get competencias {
    _$competenciasAtom.context.enforceReadPolicy(_$competenciasAtom);
    _$competenciasAtom.reportObserved();
    return super.competencias;
  }

  @override
  set competencias(List<Competencia> value) {
    _$competenciasAtom.context.conditionallyRunInAction(() {
      super.competencias = value;
      _$competenciasAtom.reportChanged();
    }, _$competenciasAtom, name: '${_$competenciasAtom.name}_set');
  }

  final _$subsSetoresAtom = Atom(name: 'ControllerBase.subsSetores');

  @override
  List<SubSetorEmpresaServidor> get subsSetores {
    _$subsSetoresAtom.context.enforceReadPolicy(_$subsSetoresAtom);
    _$subsSetoresAtom.reportObserved();
    return super.subsSetores;
  }

  @override
  set subsSetores(List<SubSetorEmpresaServidor> value) {
    _$subsSetoresAtom.context.conditionallyRunInAction(() {
      super.subsSetores = value;
      _$subsSetoresAtom.reportChanged();
    }, _$subsSetoresAtom, name: '${_$subsSetoresAtom.name}_set');
  }

  final _$escalasAtom = Atom(name: 'ControllerBase.escalas');

  @override
  List<Escala> get escalas {
    _$escalasAtom.context.enforceReadPolicy(_$escalasAtom);
    _$escalasAtom.reportObserved();
    return super.escalas;
  }

  @override
  set escalas(List<Escala> value) {
    _$escalasAtom.context.conditionallyRunInAction(() {
      super.escalas = value;
      _$escalasAtom.reportChanged();
    }, _$escalasAtom, name: '${_$escalasAtom.name}_set');
  }

  final _$registrosPontosAtom = Atom(name: 'ControllerBase.registrosPontos');

  @override
  List<RegistroPonto> get registrosPontos {
    _$registrosPontosAtom.context.enforceReadPolicy(_$registrosPontosAtom);
    _$registrosPontosAtom.reportObserved();
    return super.registrosPontos;
  }

  @override
  set registrosPontos(List<RegistroPonto> value) {
    _$registrosPontosAtom.context.conditionallyRunInAction(() {
      super.registrosPontos = value;
      _$registrosPontosAtom.reportChanged();
    }, _$registrosPontosAtom, name: '${_$registrosPontosAtom.name}_set');
  }

  final _$eventosAtom = Atom(name: 'ControllerBase.eventos');

  @override
  Map<DateTime, List<DiasTrabalhar>> get eventos {
    _$eventosAtom.context.enforceReadPolicy(_$eventosAtom);
    _$eventosAtom.reportObserved();
    return super.eventos;
  }

  @override
  set eventos(Map<DateTime, List<DiasTrabalhar>> value) {
    _$eventosAtom.context.conditionallyRunInAction(() {
      super.eventos = value;
      _$eventosAtom.reportChanged();
    }, _$eventosAtom, name: '${_$eventosAtom.name}_set');
  }

  final _$carregarEscalasPontoServidorAsyncAction =
      AsyncAction('carregarEscalasPontoServidor');

  @override
  Future carregarEscalasPontoServidor(@required bool sincronizao) {
    return _$carregarEscalasPontoServidorAsyncAction
        .run(() => super.carregarEscalasPontoServidor(sincronizao));
  }

  final _$carregarResumoPorEscalaAsyncAction =
      AsyncAction('carregarResumoPorEscala');

  @override
  Future carregarResumoPorEscala(Competencia competencia) {
    return _$carregarResumoPorEscalaAsyncAction
        .run(() => super.carregarResumoPorEscala(competencia));
  }
}
