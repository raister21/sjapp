part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  final String username;
  final int weight;
  final String height;
  final String programCode;
  const RegisterState(
      {this.programCode, this.weight, this.height, this.username});

  @override
  List<Object> get props => [username, weight, height];
}

class RegisterInitial extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final String username;

  const RegisterSuccess({@required this.username});
}

class RegisterFailed extends RegisterState {}

class WeightHeightAdded extends RegisterState {
  final String username;
  final int weight;
  final String height;

  const WeightHeightAdded({this.username, this.weight, this.height});
}

class DietProgramAdded extends RegisterState {
  final String username;
  final int weight;
  final String height;
  final String programCode;

  const DietProgramAdded(
      {this.username, this.weight, this.height, this.programCode});
}
