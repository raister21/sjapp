part of 'calorietrackweek_bloc.dart';

abstract class CalorietrackweekEvent extends Equatable {
  const CalorietrackweekEvent();

  @override
  List<Object> get props => [];
}

class GetWeeklyCalorieStatus extends CalorietrackweekEvent {
  final String username;

  GetWeeklyCalorieStatus({this.username});
}
