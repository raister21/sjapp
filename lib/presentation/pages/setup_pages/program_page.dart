import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrition_app/constants/ui_constants.dart';
import 'package:nutrition_app/data/registration/bloc/register_bloc.dart';
import 'package:nutrition_app/models/program.dart';

class ProgramPage extends StatefulWidget {
  @override
  _ProgramPageState createState() => _ProgramPageState();
}

class _ProgramPageState extends State<ProgramPage> {
  final defaultUiValues = UiConstants();
  String programName = "";
  List<Program> programList = [
    Program(
        programName: "Weight Loss",
        programIcon: Icon(Icons.arrow_circle_down),
        programIconEnabled: Icon(
          Icons.arrow_circle_down,
          color: Color.fromARGB(255, 253, 171, 159),
        )),
    Program(
        programName: "Weight Maintain",
        programIcon: Icon(Icons.add_circle),
        programIconEnabled: Icon(
          Icons.add_circle,
          color: Color.fromARGB(255, 253, 171, 159),
        )),
    Program(
        programName: "Weight Gain",
        programIcon: Icon(Icons.arrow_circle_up),
        programIconEnabled: Icon(
          Icons.arrow_circle_up,
          color: Color.fromARGB(255, 253, 171, 159),
        ))
  ];

  String getProgramCode() {
    for (int i = 0; i < programList.length; i++) {
      if (programList[i].isSelected) {
        if (programList[i].programName == "Weight Loss") {
          return "d100";
        }
        if (programList[i].programName == "Weight Maintain") {
          return "d200";
        }
        if (programList[i].programName == "Weight Gain") {
          return "d300";
        } else
          return "d100";
      }
    }
  }

  void _unselectAllPrograms() {
    for (Program program in programList) {
      program.isSelected = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _bodyBlock();
  }

  Widget _bodyBlock() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: defaultUiValues.defaultPads),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [_bodyForm(), _nextButton()],
        ),
      ),
    );
  }

  Widget _bodyForm() {
    return Expanded(
      child: ListView(
        children: [
          ListTile(
            leading: programList[0].isSelected
                ? programList[0].programIconEnabled
                : programList[0].programIcon,
            title: Text(programList[0].programName,
                style: programList[0].isSelected
                    ? TextStyle(color: Theme.of(context).primaryColor)
                    : null),
            onTap: () {
              setState(() {
                _unselectAllPrograms();
                programList[0].isSelected = true;
                programName = programList[0].programName;
              });
            },
          ),
          ListTile(
            leading: programList[1].isSelected
                ? programList[1].programIconEnabled
                : programList[1].programIcon,
            title: Text(programList[1].programName,
                style: programList[1].isSelected
                    ? TextStyle(color: Theme.of(context).primaryColor)
                    : null),
            onTap: () {
              setState(() {
                _unselectAllPrograms();
                programList[1].isSelected = true;
                programName = programList[1].programName;
              });
            },
          ),
          ListTile(
            leading: programList[2].isSelected
                ? programList[2].programIconEnabled
                : programList[2].programIcon,
            title: Text(programList[2].programName,
                style: programList[2].isSelected
                    ? TextStyle(color: Theme.of(context).primaryColor)
                    : null),
            onTap: () {
              setState(() {
                _unselectAllPrograms();
                programList[2].isSelected = true;
                programName = programList[2].programName;
              });
            },
          ),
        ],
      ),
    );
  }

  // Widget _programItem(
  //     {String progarmName, IconData iconData, int programNumber}) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //     children: [
  //       IconButton(
  //         iconSize: 100,
  //         icon: Icon(
  //           iconData,
  //         ),
  //         onPressed: () {
  //           setState(() {
  //             programNumber = programNumber;
  //           });
  //         },
  //       ),
  //       _displayDisclaimer(disclaimer: progarmName),
  //     ],
  //   );
  // }

  // Widget _displayDisclaimer({String disclaimer}) {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(vertical: defaultUiValues.defaultPads),
  //     child: Text(
  //       disclaimer,
  //       style:
  //           TextStyle(color: Colors.black, fontFamily: 'Poppins', fontSize: 14),
  //     ),
  //   );
  // }

  Widget _nextButton() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: defaultUiValues.defaultPads,
          horizontal: defaultUiValues.defaultPads),
      child: TextButton(
          onPressed: () {
            print(getProgramCode());
            BlocProvider.of<RegisterBloc>(context)
                .add(AddProgram(programCode: getProgramCode()));
            Navigator.popUntil(context, (route) => route.isFirst);
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
            "Finished",
            style: TextStyle(
                color: Colors.white, fontFamily: 'Poppins', fontSize: 12),
          )),
    );
  }
}
