import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'dark_state.dart';

class DarkCubit extends Cubit<DarkState> {
  DarkCubit()
      : super(
          DarkInitial(
            MaterialColor(0xFFE87068, {
              50: Color.fromRGBO(232, 112, 104, .1),
              100: Color.fromRGBO(232, 112, 104, .2),
              200: Color.fromRGBO(232, 112, 104, .3),
              300: Color.fromRGBO(232, 112, 104, .4),
              400: Color.fromRGBO(232, 112, 104, .5),
              500: Color.fromRGBO(232, 112, 104, .6),
              600: Color.fromRGBO(232, 112, 104, .7),
              700: Color.fromRGBO(232, 112, 104, .8),
              800: Color.fromRGBO(232, 112, 104, .9),
              900: Color.fromRGBO(232, 112, 104, 1),
            }),
          ),
        );

  void changeState() async => emit(WhiteState(MaterialColor(0xFF373490, {
        50: Color.fromRGBO(55, 52, 144, .1),
        100: Color.fromRGBO(55, 52, 144, .2),
        200: Color.fromRGBO(55, 52, 144, .3),
        300: Color.fromRGBO(55, 52, 144, .4),
        400: Color.fromRGBO(55, 52, 144, .5),
        500: Color.fromRGBO(55, 52, 144, .6),
        600: Color.fromRGBO(55, 52, 144, .7),
        700: Color.fromRGBO(55, 52, 144, .8),
        800: Color.fromRGBO(55, 52, 144, .9),
        900: Color.fromRGBO(55, 52, 144, 1),
      })));

  void changeStateBack() async => emit(DarkInitial(
        MaterialColor(0xFFE87068, {
          50: Color.fromRGBO(232, 112, 104, .1),
          100: Color.fromRGBO(232, 112, 104, .2),
          200: Color.fromRGBO(232, 112, 104, .3),
          300: Color.fromRGBO(232, 112, 104, .4),
          400: Color.fromRGBO(232, 112, 104, .5),
          500: Color.fromRGBO(232, 112, 104, .6),
          600: Color.fromRGBO(232, 112, 104, .7),
          700: Color.fromRGBO(232, 112, 104, .8),
          800: Color.fromRGBO(232, 112, 104, .9),
          900: Color.fromRGBO(232, 112, 104, 1),
        }),
      ));
}
