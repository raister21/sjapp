import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrition_app/constants/ui_constants.dart';
import 'package:nutrition_app/data/authentication/bloc/login_bloc.dart';
import 'package:nutrition_app/data/calorieTracking/bloc/calorietrack_bloc.dart';
import 'package:nutrition_app/presentation/additional_pages/add_calories_page.dart';
import 'package:nutrition_app/presentation/additional_pages/add_water_page.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DashBoardPage extends StatefulWidget {
  String username;
  DashBoardPage({this.username});
  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  UiConstants defaultUiValues = UiConstants();

  @override
  void initState() {
    BlocProvider.of<CalorietrackBloc>(context)
        .add(GetCalorieStatus(username: widget.username));
    super.initState();
  }

  String getPercent(double percentValue) {
    if (percentValue == null) {
      return "0%";
    } else {
      return (percentValue * 100).toStringAsFixed(0) + "%";
    }
  }

  @override
  Widget build(BuildContext context) {
    return _dashboardPageView();
  }

  Widget _dashboardPageView() {
    return BlocListener<CalorietrackBloc, CalorietrackState>(
      listener: (context, state) {
        if (state is CalorieUpdated) {
          BlocProvider.of<CalorietrackBloc>(context)
              .add(GetCalorieStatus(username: widget.username));
        }
      },
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
        child: Container(
          height: MediaQuery.of(context).size.height - 95,
          padding: EdgeInsets.all(defaultUiValues.defaultPads),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _caloriesBoard(),
              _caloriesInputBoard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _caloriesBoard() {
    return Container(
      height: MediaQuery.of(context).size.height / 3.5,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.all(Radius.circular(defaultUiValues.roundedRadius)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0),
              blurRadius: 6.0,
            ),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _carbIndicator(),
                _proteinIndicator(),
              ],
            ),
          ),
          Expanded(child: _caloriesIndicator()),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _fatIndicator(),
                _waterIndicator(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _carbIndicator() {
    return BlocBuilder<CalorietrackBloc, CalorietrackState>(
      builder: (context, state) {
        return Column(
          children: [
            CircularPercentIndicator(
              radius: defaultUiValues.circleIndicatorSmall,
              lineWidth: 5.0,
              percent: state.carbs ?? 0,
              center: new Text(getPercent(state.carbs)),
              progressColor: Colors.green,
            ),
            Text(
              "Carbohydrates",
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                  color: Colors.green),
            )
          ],
        );
      },
    );
  }

  Widget _proteinIndicator() {
    return BlocBuilder<CalorietrackBloc, CalorietrackState>(
      builder: (context, state) {
        return Column(
          children: [
            CircularPercentIndicator(
              radius: defaultUiValues.circleIndicatorSmall,
              lineWidth: 5.0,
              percent: state.proteins ?? 0,
              center: new Text(getPercent(state.proteins)),
              progressColor: Colors.red,
            ),
            Text(
              "Proteins",
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                  color: Colors.red),
            )
          ],
        );
      },
    );
  }

  Widget _waterIndicator() {
    return BlocBuilder<CalorietrackBloc, CalorietrackState>(
      builder: (context, state) {
        return Column(
          children: [
            CircularPercentIndicator(
              radius: defaultUiValues.circleIndicatorSmall,
              lineWidth: 5.0,
              percent: state.water ?? 0,
              center: new Text(getPercent(state.water)),
              progressColor: Colors.blue,
            ),
            Text(
              "Water",
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                  color: Colors.blue),
            )
          ],
        );
      },
    );
  }

  Widget _fatIndicator() {
    return BlocBuilder<CalorietrackBloc, CalorietrackState>(
      builder: (context, state) {
        return Column(
          children: [
            CircularPercentIndicator(
              radius: defaultUiValues.circleIndicatorSmall,
              lineWidth: 5.0,
              percent: state.fats ?? 0,
              center: new Text(getPercent(state.fats)),
              progressColor: Colors.yellow,
            ),
            Text(
              "Fats",
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                  color: Colors.yellow),
            )
          ],
        );
      },
    );
  }

  Widget _caloriesIndicator() {
    return BlocBuilder<CalorietrackBloc, CalorietrackState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularPercentIndicator(
              radius: defaultUiValues.circleIndicatorBig,
              lineWidth: 5.0,
              percent: state.calories ?? 0,
              center: new Text(getPercent(state.calories)),
              progressColor: Colors.deepPurple,
            ),
            Text(
              "Calories",
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                  color: Colors.deepPurple),
            )
          ],
        );
      },
    );
  }

  Widget _caloriesInputBoard() {
    return Container(
      height: MediaQuery.of(context).size.height / 3.5,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.all(Radius.circular(defaultUiValues.roundedRadius)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0),
              blurRadius: 6.0,
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: defaultUiValues.defaultPads),
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return Text(
                  "Good morning ${state.account.name}",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 18),
                );
              },
            ),
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: defaultUiValues.defaultPads),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _addActionButton(
                    actionName: "calories", iconData: Icons.restaurant),
                _addActionButton(
                    actionName: "water", iconData: Icons.local_drink),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _addActionButton({String actionName, IconData iconData}) {
    return Column(
      children: [
        IconButton(
          icon: Icon(
            iconData,
            size: 100,
          ),
          onPressed: () {
            if (actionName == 'calories') {
              Navigator.pushNamed(context, AddCaloriePage.routeName);
            } else if (actionName == 'water') {
              Navigator.pushNamed(context, AddWaterPage.routeName);
            }
          },
          iconSize: 100,
        ),
        Text(
          actionName,
          style: TextStyle(
              fontFamily: 'Poppins', fontWeight: FontWeight.w300, fontSize: 12),
        ),
      ],
    );
  }
}
