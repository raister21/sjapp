import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrition_app/constants/ui_constants.dart';
import 'package:nutrition_app/data/registration/bloc/register_bloc.dart';
import 'package:nutrition_app/models/height.dart';
import 'package:nutrition_app/models/weight.dart';
import 'package:nutrition_app/services/http_service.dart';

class WeightPage extends StatefulWidget {
  final Function bmiDone;
  WeightPage({this.bmiDone});
  @override
  _WeightPageState createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  final defaultUiValues = UiConstants();
  HttpService httpService = HttpService();
  int weightSelected;
  String heightSelected;
  List<Weight> weightList;
  List<Height> heightList;

  @override
  void initState() {
    weightList = _getWeightList();
    heightList = _getHeightList();
    super.initState();
  }

  List<Weight> _getWeightList() {
    List<Weight> output = [];
    int start = 30;
    while (start < 150) {
      output.add(Weight(weight: start));
      start += 1;
    }
    return output;
  }

  List<Height> _getHeightList() {
    List<Height> output = [];
    int foot = 5;
    int inch = 0;
    while (foot < 7) {
      output.add(Height(heightFoot: foot, heightInch: inch));
      if (inch == 12) {
        inch = 0;
        foot += 1;
      } else {
        inch += 1;
      }
    }
    return output;
  }

  void _resetWeightList() {
    for (Weight weight in weightList) {
      weight.isItSelected = false;
    }
  }

  void _resetHeightList() {
    for (Height height in heightList) {
      height.isSelected = false;
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

  Widget _displayDisclaimer({String disclaimer}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: defaultUiValues.defaultPads),
      child: Text(
        disclaimer,
        style:
            TextStyle(color: Colors.black, fontFamily: 'Poppins', fontSize: 14),
      ),
    );
  }

  Widget _bodyForm() {
    return Column(
      children: [
        _weightList(),
        _displayDisclaimer(disclaimer: "Enter your weight"),
        _heightList(),
        _displayDisclaimer(disclaimer: "Enter your height"),
      ],
    );
  }

  Widget _weightList() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: defaultUiValues.defaultSmallPads),
      child: SizedBox(
          height: MediaQuery.of(context).size.height / 5,
          width: MediaQuery.of(context).size.width / 2,
          child: ListView.builder(
              itemCount: weightList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    weightList[index].displayableWeight,
                    textAlign: TextAlign.center,
                  ),
                  selected: weightList[index].isItSelected,
                  onTap: () {
                    _resetWeightList();
                    setState(() {
                      weightSelected = weightList[index].weight;
                      weightList[index].isItSelected = true;
                    });
                  },
                );
              })),
    );
  }

  Widget _heightList() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: defaultUiValues.defaultSmallPads),
      child: SizedBox(
          height: MediaQuery.of(context).size.height / 5,
          width: MediaQuery.of(context).size.width / 2,
          child: ListView.builder(
              itemCount: heightList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    heightList[index].displayableHeight,
                    textAlign: TextAlign.center,
                  ),
                  selected: heightList[index].isSelected,
                  onTap: () {
                    _resetHeightList();
                    setState(() {
                      heightSelected = heightList[index].displayableHeight;
                      heightList[index].isSelected = true;
                    });
                  },
                );
              })),
    );
  }

  Widget _nextButton() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: defaultUiValues.defaultPads,
          horizontal: defaultUiValues.defaultPads),
      child: TextButton(
          onPressed: () {
            if (weightSelected != null && heightSelected != null) {
              BlocProvider.of<RegisterBloc>(context).add(AddWeightHeight(
                  height: heightSelected, weight: weightSelected));
              widget.bmiDone();
            }
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
            "Next",
            style: TextStyle(
                color: Colors.white, fontFamily: 'Poppins', fontSize: 12),
          )),
    );
  }
}
