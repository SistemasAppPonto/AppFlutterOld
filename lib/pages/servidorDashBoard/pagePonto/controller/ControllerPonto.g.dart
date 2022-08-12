// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ControllerPonto.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ControllerPonto on ControllerBase, Store {
  final _$flagValidarLocalizacaoAtom =
      Atom(name: 'ControllerBase.flagValidarLocalizacao');

  @override
  bool get flagValidarLocalizacao {
    _$flagValidarLocalizacaoAtom.context
        .enforceReadPolicy(_$flagValidarLocalizacaoAtom);
    _$flagValidarLocalizacaoAtom.reportObserved();
    return super.flagValidarLocalizacao;
  }

  @override
  set flagValidarLocalizacao(bool value) {
    _$flagValidarLocalizacaoAtom.context.conditionallyRunInAction(() {
      super.flagValidarLocalizacao = value;
      _$flagValidarLocalizacaoAtom.reportChanged();
    }, _$flagValidarLocalizacaoAtom,
        name: '${_$flagValidarLocalizacaoAtom.name}_set');
  }

  final _$flagValidarFotoAtom = Atom(name: 'ControllerBase.flagValidarFoto');

  @override
  bool get flagValidarFoto {
    _$flagValidarFotoAtom.context.enforceReadPolicy(_$flagValidarFotoAtom);
    _$flagValidarFotoAtom.reportObserved();
    return super.flagValidarFoto;
  }

  @override
  set flagValidarFoto(bool value) {
    _$flagValidarFotoAtom.context.conditionallyRunInAction(() {
      super.flagValidarFoto = value;
      _$flagValidarFotoAtom.reportChanged();
    }, _$flagValidarFotoAtom, name: '${_$flagValidarFotoAtom.name}_set');
  }

  final _$ControllerBaseActionController =
      ActionController(name: 'ControllerBase');

  @override
  dynamic validarLocalizacao(bool flag) {
    final _$actionInfo = _$ControllerBaseActionController.startAction();
    try {
      return super.validarLocalizacao(flag);
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }
}
