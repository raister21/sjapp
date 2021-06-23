import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:nutrition_app/models/account.dart';
import 'package:nutrition_app/services/http_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState());

  HttpService httpService = HttpService();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginUsernameChanged) {
      yield state.copywith(username: event.username);
    } else if (event is LoginPasswordChanged) {
      yield state.copywith(password: event.password);
    } else if (event is LoginSubmitted) {
      yield LoginProcessing(username: state.username, password: state.password);
      try {
        Account account = await httpService.attemptLogin(
            username: state.username, password: state.password);
        if (account.username != null) {
          yield LoginSuccess(account: account);
        } else {
          yield LoginFailed(username: state.username, password: state.password);
        }
      } catch (e) {
        yield LoginState();
      }
    }
  }
}
