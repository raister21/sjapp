part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterProfile extends RegisterEvent {
  final String username;
  final DateTime dateTime;
  final String password;
  final String name;
  final String gender;

  const RegisterProfile(
      {@required this.username,
      @required this.dateTime,
      @required this.password,
      @required this.name,
      @required this.gender});
}

class AddWeightHeight extends RegisterEvent {
  final String height;
  final int weight;

  AddWeightHeight({this.height, this.weight});
}

class AddProgram extends RegisterEvent {
  final String programCode;

  AddProgram({this.programCode});
}
