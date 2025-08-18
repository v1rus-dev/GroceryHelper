import 'package:basket_icon_kit/basket_icon_kit.dart';
import 'package:design/design.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'create_busket_event.dart';
part 'create_busket_state.dart';

class CreateBusketBloc extends Bloc<CreateBusketEvent, CreateBusketState> {
  CreateBusketBloc()
    : super(CreateBusketState(selectedIcon: DefaultIconSet.bag, selectedColor: BasketColor.colors.first, tags: [])) {
    on<ChangeIconEvent>(_onChangeBusketIcon);
    on<ChangeColorEvent>(_onChangeBusketColor);
  }

  void _onChangeBusketIcon(ChangeIconEvent event, Emitter<CreateBusketState> emit) {
    emit(state.copyWith(selectedIcon: event.icon));
  }

  void _onChangeBusketColor(ChangeColorEvent event, Emitter<CreateBusketState> emit) {
    emit(state.copyWith(selectedColor: event.color));
  }
}
