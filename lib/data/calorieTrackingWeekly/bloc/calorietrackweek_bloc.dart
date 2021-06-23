import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nutrition_app/services/http_service.dart';

part 'calorietrackweek_event.dart';
part 'calorietrackweek_state.dart';

class CalorietrackweekBloc
    extends Bloc<CalorietrackweekEvent, CalorietrackweekState> {
  CalorietrackweekBloc() : super(CalorietrackweekInitial());

  HttpService httpService = HttpService();

  @override
  Stream<CalorietrackweekState> mapEventToState(
    CalorietrackweekEvent event,
  ) async* {
    if (event is GetWeeklyCalorieStatus) {
      var dailyDashboard =
          await httpService.getWeeklyCalorieStatus(username: event.username);
      yield CalorietrackweekInitial(
          carbs: dailyDashboard.carbsDailyValue,
          calories: dailyDashboard.caloriesDailyValue,
          proteins: dailyDashboard.proteinsDailyValue,
          water: dailyDashboard.waterDailyValue,
          fats: dailyDashboard.fatsDailyValue);
    }
  }
}
