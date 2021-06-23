part of 'calorietrack_bloc.dart';

abstract class CalorietrackEvent extends Equatable {
  const CalorietrackEvent();

  @override
  List<Object> get props => [];
}

class AddCalorie extends CalorietrackEvent {
  final String username;
  final int carbs;
  final int proteins;
  final int fats;

  const AddCalorie({this.username, this.carbs, this.proteins, this.fats});
}

class AddWater extends CalorietrackEvent {
  final String username;
  final int water;

  const AddWater({this.username, this.water});
}

class GetCalorieStatus extends CalorietrackEvent {
  final String username;

  GetCalorieStatus({this.username});
}
