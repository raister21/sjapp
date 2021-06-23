import 'package:flutter/material.dart';
import 'package:nutrition_app/constants/ui_constants.dart';
import 'package:nutrition_app/presentation/pages/setup_pages/program_page.dart';
import 'package:nutrition_app/presentation/pages/setup_pages/weight_page.dart';

class SetUpPage extends StatefulWidget {
  static const String routeName = "/setup";
  @override
  _SetUpPageState createState() => _SetUpPageState();
}

class _SetUpPageState extends State<SetUpPage> {
  final defaultUiValues = UiConstants();
  bool isBmiDone = false;

  void _doneWithBmi() {
    setState(() {
      isBmiDone = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: _setUpView()));
  }

  Widget _setUpView() {
    return Column(
      children: [_headerBlock(), _bodyBlock()],
    );
  }

  Widget _bodyBlock() {
    return isBmiDone
        ? ProgramPage()
        : WeightPage(
            bmiDone: _doneWithBmi,
          );
  }

  Widget _headerBlock() {
    return Container(
      padding: EdgeInsets.fromLTRB(
          defaultUiValues.defaultPads, 33, defaultUiValues.defaultPads, 0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(isBmiDone ? "Step 2" : "Step 1",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 36,
                    color: Theme.of(context).primaryColor)),
            Text(
                isBmiDone
                    ? "Which program would you like to choose ?"
                    : "Enter your body weight and height",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
                    color: Theme.of(context).primaryColor)),
          ],
        ),
      ),
    );
  }
}
