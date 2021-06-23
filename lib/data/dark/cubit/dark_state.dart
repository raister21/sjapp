part of 'dark_cubit.dart';

abstract class DarkState extends Equatable {
  final MaterialColor color;
  const DarkState(this.color);

  @override
  List<Object> get props => [];
}

class DarkInitial extends DarkState {
  final MaterialColor color;

  DarkInitial(this.color) : super(color);
}

class WhiteState extends DarkState {
  final MaterialColor color;
  WhiteState(this.color) : super(color);
}
