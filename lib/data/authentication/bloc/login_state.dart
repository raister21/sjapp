part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.username,
    this.password,
    this.account,
  });
  final String username;
  bool get isUsernameValid => (username != null) ? username.length > 4 : false;
  final String password;
  bool get isPasswordValid => (password != null) ? password.length > 6 : false;
  final Account account;

  LoginState copywith({String username, String password}) {
    return LoginState(
        username: username ?? this.username,
        password: password ?? this.password,
        account: account ?? this.account);
  }

  @override
  List<Object> get props => [username, password];
}

class LoginProcessing extends LoginState {
  final String username;
  final String password;
  const LoginProcessing({@required this.username, @required this.password});
}

class LoginSuccess extends LoginState {
  final Account account;

  LoginSuccess({@required this.account});
}

class LoginFailed extends LoginState {
  final String username;
  final String password;

  const LoginFailed({@required this.username, @required this.password});
}
