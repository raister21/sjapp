import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_app/services/http_service.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial());
  HttpService httpService = HttpService();

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is RegisterProfile) {
      try {
        bool response = await httpService.postUserProfile(
            username: event.username,
            dateTime: event.dateTime,
            password: event.password,
            name: event.name,
            gender: event.gender);
        print("B4 " + event.username);
        if (response) {
          yield RegisterSuccess(username: event.username);
          print("state username is " + state.username);
          print("event username is " + event.username);
        } else {
          yield RegisterFailed();
        }
      } catch (e) {
        print(e);
      }
    }
    if (event is AddWeightHeight) {
      yield WeightHeightAdded(
          username: state.username, height: event.height, weight: event.weight);
    }
    if (event is AddProgram) {
      try {
        yield DietProgramAdded(
            username: state.username,
            weight: state.weight,
            height: state.height,
            programCode: event.programCode);

        bool response = await httpService.postUserDetails(
            username: state.username,
            code: state.programCode,
            height: state.height,
            weight: state.weight);

        if (response) {
          yield RegisterInitial();
        } else {
          yield RegisterFailed();
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
