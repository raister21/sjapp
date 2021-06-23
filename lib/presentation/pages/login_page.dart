import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrition_app/constants/ui_constants.dart';
import 'package:nutrition_app/data/authentication/bloc/login_bloc.dart';
import 'package:nutrition_app/presentation/pages/home_pages/home_page.dart';
import 'package:nutrition_app/presentation/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = "/login";
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final defaultUiValues = UiConstants();
  bool _isItPressed = false;
  bool _visiblePassword = true;

  @override
  void initState() {
    _isItPressed = false;
    super.initState();
  }

  Widget _variableButtonContent(bool _isItPressed) {
    if (_isItPressed) {
      return CircularProgressIndicator(
        strokeWidth: 2,
        backgroundColor: Colors.white,
      );
    } else {
      return Text(
        "Login",
        style:
            TextStyle(color: Colors.white, fontFamily: 'Poppins', fontSize: 14),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: _loginView()));
  }

  Widget _loginView() {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          setState(() {
            _isItPressed = false;
          });
          Navigator.pushNamed(context, HomePage.routeName);
        } else if (state is LoginFailed) {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    title: Text("Incorrect Password"),
                    content: Text(
                        "The password you entered is incorrect. Please Try again."),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        child: Text("Try again"),
                      )
                    ],
                  ));
          setState(() {
            _isItPressed = false;
          });
        }
      },
      child: LayoutBuilder(
        builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: <Color>[
                      Theme.of(context).primaryColor,
                      defaultUiValues.primaryDarkGradient,
                    ],
                    stops: [
                      0.0,
                      1.0,
                    ],
                  ),
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [_headerBlock(), _bodyBlock()],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _headerBlock() {
    return Expanded(
      flex: 3,
      child: Container(
        child: _displayMessage(),
      ),
    );
  }

  Widget _bodyBlock() {
    return Expanded(
      flex: 7,
      child: Container(
        padding: EdgeInsets.fromLTRB(
            defaultUiValues.defaultPads, 50, defaultUiValues.defaultPads, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(defaultUiValues.roundedRadius),
            topRight: Radius.circular(defaultUiValues.roundedRadius),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _loginForm(),
            _footerMessage(),
          ],
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Column(
      children: [
        _userIdInput(),
        _userPasswordInput(),
        _loginButton(),
        _createNewAccount(),
      ],
    );
  }

  Widget _displayMessage() {
    return Container(
      margin: EdgeInsets.fromLTRB(
          defaultUiValues.defaultPads, 24.0, defaultUiValues.defaultPads, 26.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Hello, \nWelcome Back!",
          style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w900,
              fontSize: 42,
              color: Colors.white),
        ),
      ),
    );
  }

  Widget _userIdInput() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Container(
          padding:
              EdgeInsets.symmetric(vertical: defaultUiValues.defaultSmallPads),
          child: TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.all(
                        Radius.circular(defaultUiValues.roundedSmallRadius))),
                hintText: 'username'),
            onChanged: (value) => {
              BlocProvider.of<LoginBloc>(context)
                  .add(LoginUsernameChanged(username: value))
            },
          ),
        );
      },
    );
  }

  Widget _userPasswordInput() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Container(
          padding:
              EdgeInsets.fromLTRB(0, defaultUiValues.defaultSmallPads, 0, 0),
          child: TextFormField(
            obscureText: _visiblePassword,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.all(
                      Radius.circular(defaultUiValues.roundedSmallRadius))),
              hintText: 'Password',
            ),
            onChanged: (value) => {
              BlocProvider.of<LoginBloc>(context)
                  .add(LoginPasswordChanged(password: value))
            },
          ),
        );
      },
    );
  }

  Widget _forgotPassowrd() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: Text(
          'Forgot Password?',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }

  Widget _loginButton() {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginProcessing) {
          setState(() {
            _isItPressed = true;
          });
        }
      },
      builder: (context, state) {
        return Padding(
          padding:
              EdgeInsets.symmetric(vertical: defaultUiValues.defaultSmallPads),
          child: TextButton(
              onPressed: () {
                BlocProvider.of<LoginBloc>(context).add(LoginSubmitted());
              },
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all<Color>(
                    defaultUiValues.primaryDarkGradient,
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).primaryColor),
                  minimumSize: MaterialStateProperty.all(
                    Size(MediaQuery.of(context).size.width, 48),
                  )),
              child: _variableButtonContent(_isItPressed)),
        );
      },
    );
  }

  Widget _createNewAccount() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0),
      child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, RegisterPage.routeName);
          },
          child: Text(
            'Create new account ?',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w300,
            ),
          )),
    );
  }

  Widget _footerMessage() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: defaultUiValues.defaultPads),
      child: Text(
        "2021 \u00a9 Srijung Rai",
        style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
      ),
    );
  }
}
