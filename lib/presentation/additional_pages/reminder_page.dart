import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrition_app/constants/ui_constants.dart';
import 'package:nutrition_app/data/authentication/bloc/login_bloc.dart';
import 'package:nutrition_app/data/calorieTracking/bloc/calorietrack_bloc.dart';

class ReminderPage extends StatefulWidget {
  static const String routeName = "/reminderPage";
  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  final UiConstants defaultUiValues = UiConstants();

  bool _isItPressed = false;

  TextEditingController _waterController = TextEditingController();

  Widget _variableButtonContent(bool _isItPressed) {
    if (_isItPressed) {
      return CircularProgressIndicator(
        strokeWidth: 2,
        backgroundColor: Colors.white,
      );
    } else {
      return Text(
        "Add Reminder",
        style:
            TextStyle(color: Colors.white, fontFamily: 'Poppins', fontSize: 14),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: _addReminder()));
  }

  Widget _addReminder() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(defaultUiValues.defaultPads),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Add your Reminder!",
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontSize: 28,
                fontWeight: FontWeight.bold),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: defaultUiValues.defaultSmallPads),
            child: Column(
              children: [
                TextFormField(
                  controller: _waterController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(
                              defaultUiValues.roundedSmallRadius))),
                      hintText: 'Hours'),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 12)),
                TextFormField(
                  controller: _waterController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(
                              defaultUiValues.roundedSmallRadius))),
                      hintText: 'Minutes'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return Padding(
        padding:
            EdgeInsets.symmetric(vertical: defaultUiValues.defaultSmallPads),
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return TextButton(
                onPressed: () {
                  // int water = 0;

                  // if (_waterController.text.isNotEmpty) {
                  //   water = int.parse(_waterController.text);
                  // }

                  // BlocProvider.of<CalorietrackBloc>(context).add(
                  //     AddWater(username: state.account.username, water: water));
                  // setState(() {
                  //   _isItPressed = false;
                  // });
                  // Navigator.pop(context);
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
                child: _variableButtonContent(_isItPressed));
          },
        ));
  }
}
