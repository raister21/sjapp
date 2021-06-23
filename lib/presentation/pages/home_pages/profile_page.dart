import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrition_app/constants/ui_constants.dart';
import 'package:nutrition_app/data/authentication/bloc/login_bloc.dart';
import 'package:nutrition_app/data/calorieTracking/bloc/calorietrack_bloc.dart';
import 'package:nutrition_app/data/calorieTrackingWeekly/bloc/calorietrackweek_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProfilePage extends StatefulWidget {
  final String username;

  const ProfilePage({Key key, this.username}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UiConstants defaultUiValues = UiConstants();

  @override
  void initState() {
    BlocProvider.of<CalorietrackweekBloc>(context)
        .add(GetWeeklyCalorieStatus(username: widget.username));
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
    return _profilePageView();
  }

  Widget _profilePageView() {
    return Container(
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
      child: Padding(
        padding: EdgeInsets.all(defaultUiValues.defaultPads),
        child: Column(
          children: [
            _profilePic(),
            _personalTrack(),
          ],
        ),
      ),
    );
  }

  Widget _profilePic() {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: defaultUiValues.defaultPads),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: CircleAvatar(
            backgroundColor: Colors.red,
            backgroundImage: AssetImage('assets/demo_profile.png'),
            radius: 60,
          ),
        ),
      ),
    );
  }

  Widget _personalTrack() {
    return Expanded(
      flex: 2,
      child: Container(
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
                Radius.circular(defaultUiValues.roundedRadius)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0),
                blurRadius: 6.0,
              ),
            ]),
        child: Column(
          children: [
            _caloriesBoard(),
            _weeklyProgressIndicator(),
            Text(
              "Weekly progress",
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget _weeklyProgressIndicator() {
    return BlocBuilder<CalorietrackweekBloc, CalorietrackweekState>(
      builder: (context, state) {
        return Padding(
          padding:
              EdgeInsets.symmetric(vertical: defaultUiValues.defaultSmallPads),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LinearPercentIndicator(
                width: MediaQuery.of(context).size.width / 1.5,
                lineHeight: 8.0,
                percent: state.calories ?? 0,
                progressColor: Colors.blue,
              )
            ],
          ),
        );
      },
    );
  }

  Widget _caloriesBoard() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: defaultUiValues.defaultPads),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _carbIndicator(),
              _proteinIndicator(),
            ],
          ),
          _caloriesIndicator(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _fatIndicator(),
              _waterIndicator(),
            ],
          )
        ],
      ),
    );
  }

  Widget _carbIndicator() {
    return BlocBuilder<CalorietrackweekBloc, CalorietrackweekState>(
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
    return BlocBuilder<CalorietrackweekBloc, CalorietrackweekState>(
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
    return BlocBuilder<CalorietrackweekBloc, CalorietrackweekState>(
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
    return BlocBuilder<CalorietrackweekBloc, CalorietrackweekState>(
      builder: (context, state) {
        return Column(
          children: [
            CircularPercentIndicator(
              radius: defaultUiValues.circleIndicatorSmall,
              lineWidth: 5.0,
              percent: state.fats ?? 0,
              center: new Text(getPercent(state.proteins)),
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
    return BlocBuilder<CalorietrackweekBloc, CalorietrackweekState>(
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
}
