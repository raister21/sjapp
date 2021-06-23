import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrition_app/constants/ui_constants.dart';
import 'package:nutrition_app/data/registration/bloc/register_bloc.dart';
import 'package:nutrition_app/presentation/pages/setup_pages/setup_page.dart';

class RegisterPage extends StatefulWidget {
  static const String routeName = "/register";

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final defaultUiValues = UiConstants();
  int _genderGroup = -1;
  DateTime dob;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  String getGender() {
    switch (_genderGroup) {
      case 1:
        return 'Male';
      case 2:
        return 'Female';
      case 3:
        return 'Others';
      default:
        return 'Others';
    }
  }

  Future _pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 90),
      lastDate: DateTime.now(),
    );

    if (selectedDate == null) return;

    setState(() {
      dob = selectedDate;
    });
  }

  String _getDateOfBirthString() {
    if (dob == null) {
      return 'Date of birth';
    } else {
      return '${dob.day}/${dob.month}/${dob.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: _registerView(),
    ));
  }

  Widget _registerView() {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          Navigator.pushNamed(context, SetUpPage.routeName);
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
      child: Column(
        children: [
          _goBackButton(),
          _displayMessage(),
        ],
      ),
    );
  }

  Widget _bodyBlock() {
    return Expanded(
      flex: 7,
      child: Container(
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
              _registerForm(),
              _footerMessage(),
            ]),
      ),
    );
  }

  Widget _goBackButton() {
    return Align(
      alignment: Alignment.centerLeft,
      child: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {},
      ),
    );
  }

  Widget _displayMessage() {
    return Container(
      padding: EdgeInsets.fromLTRB(
          defaultUiValues.defaultPads, 33, defaultUiValues.defaultPads, 0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("New to Salmon?",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 36,
                    color: Colors.white)),
            Text("Let us help you track your nutrients",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
                    color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _registerForm() {
    return Padding(
      padding: EdgeInsets.fromLTRB(defaultUiValues.defaultPads, 30,
          defaultUiValues.defaultPads, defaultUiValues.defaultPads),
      child: Column(children: [
        _usernameInput(),
        _dateOfBirthInput(),
        _passwordInput(),
        _confirmPasswordInput(),
        _genderRadio(),
        _submitButton(),
      ]),
    );
  }

  Widget _usernameInput() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: defaultUiValues.defaultSmallPads),
      child: TextFormField(
        controller: _usernameController,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.all(
                    Radius.circular(defaultUiValues.roundedSmallRadius))),
            hintText: 'Username'),
      ),
    );
  }

  Widget _dateOfBirthInput() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: defaultUiValues.defaultSmallPads),
      child: OutlinedButton(
          onPressed: () => _pickDate(context),
          style: ButtonStyle(
              side: MaterialStateProperty.all(
                  BorderSide(width: 1, color: Colors.grey)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      defaultUiValues.roundedSmallRadius))),
              minimumSize: MaterialStateProperty.all(
                Size(MediaQuery.of(context).size.width, 54),
              )),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              _getDateOfBirthString(),
              style: TextStyle(
                  color: Colors.black54, fontFamily: 'Poppins', fontSize: 14),
            ),
          )),
    );
  }

  Widget _passwordInput() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: defaultUiValues.defaultSmallPads),
      child: TextFormField(
        controller: _passwordController,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.all(
                    Radius.circular(defaultUiValues.roundedSmallRadius))),
            hintText: 'Password'),
      ),
    );
  }

  Widget _confirmPasswordInput() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: defaultUiValues.defaultSmallPads),
      child: TextFormField(
        controller: _nameController,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.all(
                    Radius.circular(defaultUiValues.roundedSmallRadius))),
            hintText: 'Name'),
      ),
    );
  }

  Widget _genderRadio() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: defaultUiValues.defaultSmallPads),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: defaultUiValues.defaultPads),
            child: Text(
              "Gender",
              style: TextStyle(
                  color: Colors.black, fontFamily: 'Poppins', fontSize: 14),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _eachRadioButton(title: "Male", value: 1),
              _eachRadioButton(title: "Female", value: 2),
              _eachRadioButton(title: "Others", value: 3),
            ],
          )
        ],
      ),
    );
  }

  Widget _eachRadioButton({String title, int value}) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: _genderGroup,
          onChanged: (value) => setState(
            () {
              _genderGroup = value;
            },
          ),
        ),
        Text(
          title,
          style: TextStyle(
              color: Colors.black, fontFamily: 'Poppins', fontSize: 12),
        ),
      ],
    );
  }

  Widget _submitButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: defaultUiValues.defaultSmallPads),
      child: TextButton(
          onPressed: () {
            print("controllers" + _usernameController.text);
            BlocProvider.of<RegisterBloc>(context).add(RegisterProfile(
              username: _usernameController.text,
              dateTime: dob,
              name: _nameController.text,
              password: _passwordController.text,
              gender: getGender(),
            ));
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
          child: Text(
            "Register",
            style: TextStyle(
                color: Colors.white, fontFamily: 'Poppins', fontSize: 14),
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
