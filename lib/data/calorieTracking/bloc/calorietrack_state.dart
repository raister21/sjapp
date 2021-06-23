part of 'calorietrack_bloc.dart';

abstract class CalorietrackState extends Equatable {
  const CalorietrackState(
      {this.carbs, this.proteins, this.calories, this.fats, this.water});

  final double carbs;
  final double proteins;
  final double calories;
  final double fats;
  final double water;

  @override
  List<Object> get props => [carbs, proteins, calories, fats, water];
}

class CalorietrackInitial extends CalorietrackState {
  final double carbs;
  final double proteins;
  final double calories;
  final double fats;
  final double water;

  CalorietrackInitial(
      {this.carbs, this.proteins, this.calories, this.fats, this.water});
}

class CalorieUpdating extends CalorietrackState {}

class CalorieUpdateFailed extends CalorietrackState {}

class CalorieUpdated extends CalorietrackState {}
