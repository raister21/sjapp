import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nutrition_app/services/http_service.dart';

part 'calorietrack_event.dart';
part 'calorietrack_state.dart';

class CalorietrackBloc extends Bloc<CalorietrackEvent, CalorietrackState> {
  CalorietrackBloc() : super(CalorietrackInitial());

  HttpService httpService = HttpService();

  @override
  Stream<CalorietrackState> mapEventToState(
    CalorietrackEvent event,
  ) async* {
    if (event is GetCalorieStatus) {
      var dailyDashboard =
          await httpService.getDailyCalorieStatus(username: event.username);
      yield CalorietrackInitial(
          carbs: dailyDashboard.carbsDailyValue,
          calories: dailyDashboard.caloriesDailyValue,
          proteins: dailyDashboard.proteinsDailyValue,
          water: dailyDashboard.waterDailyValue,
          fats: dailyDashboard.fatsDailyValue);
    } else if (event is AddCalorie) {
      yield CalorieUpdating();
      try {
        bool response = await httpService.postDailyCalorie(
            username: event.username,
            carbs: event.carbs,
            proteins: event.proteins,
            fats: event.fats);

        if (response) {
          yield CalorieUpdated();
        } else {
          yield CalorieUpdateFailed();
        }
      } catch (e) {
        print(e);
      }
    } else if (event is AddWater) {
      yield CalorieUpdating();
      print("adding water");
      try {
        bool response = await httpService.postDailyWater(
            username: event.username, water: event.water);

        if (response) {
          yield CalorieUpdated();
        } else {
          yield CalorieUpdateFailed();
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
