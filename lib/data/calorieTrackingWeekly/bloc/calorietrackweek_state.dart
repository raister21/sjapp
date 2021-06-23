part of 'calorietrackweek_bloc.dart';

abstract class CalorietrackweekState extends Equatable {
  const CalorietrackweekState(
      {this.carbs, this.proteins, this.calories, this.fats, this.water});
  final double carbs;
  final double proteins;
  final double calories;
  final double fats;
  final double water;
  @override
  List<Object> get props => [carbs, proteins, calories, fats, water];
}

class CalorietrackweekInitial extends CalorietrackweekState {
  final double carbs;
  final double proteins;
  final double calories;
  final double fats;
  final double water;

  CalorietrackweekInitial(
      {this.carbs, this.proteins, this.calories, this.fats, this.water});
}

class CalorieWeekUpdating extends CalorietrackweekState {}

class CalorieWeekUpdateFailed extends CalorietrackweekState {}

class CalorieWeekUpdated extends CalorietrackweekState {}
