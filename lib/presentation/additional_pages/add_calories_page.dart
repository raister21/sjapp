import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrition_app/constants/ui_constants.dart';
import 'package:nutrition_app/data/authentication/bloc/login_bloc.dart';
import 'package:nutrition_app/data/calorieTracking/bloc/calorietrack_bloc.dart';

class AddCaloriePage extends StatefulWidget {
  static const String routeName = "/addCalorie";
  @override
  _AddCaloriePageState createState() => _AddCaloriePageState();
}

class _AddCaloriePageState extends State<AddCaloriePage> {
  final UiConstants defaultUiValues = UiConstants();
  bool _isItPressed = false;

  TextEditingController _fatsController = TextEditingController();
  TextEditingController _proteinsController = TextEditingController();
  TextEditingController _carbsController = TextEditingController();

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
        "Submit",
        style:
            TextStyle(color: Colors.white, fontFamily: 'Poppins', fontSize: 14),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: _addCaloriesView()));
  }

  Widget _addCaloriesView() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(defaultUiValues.defaultPads),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Add your calories !",
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontSize: 28,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "All values should be in grams ",
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.black, fontFamily: 'Poppins', fontSize: 14),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: defaultUiValues.defaultSmallPads),
            child: TextFormField(
              controller: _fatsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.all(
                          Radius.circular(defaultUiValues.roundedSmallRadius))),
                  hintText: 'Fats'),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: defaultUiValues.defaultPads),
            child: TextFormField(
              controller: _proteinsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.all(
                          Radius.circular(defaultUiValues.roundedSmallRadius))),
                  hintText: 'Proteins'),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: defaultUiValues.defaultPads),
            child: TextFormField(
              controller: _carbsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.all(
                          Radius.circular(defaultUiValues.roundedSmallRadius))),
                  hintText: 'Carbohydrates'),
            ),
          ),
          _submitButton(),
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
                  int fats = 0;
                  int proteins = 0;
                  int carbs = 0;

                  if (_fatsController.text.isNotEmpty) {
                    fats = int.parse(_fatsController.text);
                  }
                  if (_proteinsController.text.isNotEmpty) {
                    proteins = int.parse(_proteinsController.text);
                  }
                  if (_carbsController.text.isNotEmpty) {
                    carbs = int.parse(_carbsController.text);
                  }
                  BlocProvider.of<CalorietrackBloc>(context).add(AddCalorie(
                      username: state.account.username,
                      carbs: carbs,
                      proteins: proteins,
                      fats: fats));
                  setState(() {
                    _isItPressed = false;
                  });
                  Navigator.pop(context);
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
