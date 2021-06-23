import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrition_app/data/authentication/bloc/login_bloc.dart';
import 'package:nutrition_app/data/calorieTracking/bloc/calorietrack_bloc.dart';
import 'package:nutrition_app/data/calorieTrackingWeekly/bloc/calorietrackweek_bloc.dart';
import 'package:nutrition_app/data/registration/bloc/register_bloc.dart';
import 'package:nutrition_app/presentation/additional_pages/add_calories_page.dart';
import 'package:nutrition_app/presentation/additional_pages/add_water_page.dart';
import 'package:nutrition_app/presentation/additional_pages/reminder_page.dart';
import 'package:nutrition_app/presentation/pages/home_pages/home_page.dart';
import 'package:nutrition_app/presentation/pages/login_page.dart';
import 'package:nutrition_app/presentation/pages/register_page.dart';
import 'package:nutrition_app/presentation/pages/setup_pages/setup_page.dart';

class RouteGenerator {
  final LoginBloc _loginBloc = LoginBloc();
  final CalorietrackBloc _calorietrackBloc = CalorietrackBloc();
  final CalorietrackweekBloc _calorietrackweekBloc = CalorietrackweekBloc();
  final RegisterBloc _registerBloc = RegisterBloc();

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _loginBloc,
            child: LoginPage(),
          ),
        );
      case HomePage.routeName:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _loginBloc),
              BlocProvider.value(value: _calorietrackBloc),
              BlocProvider.value(value: _calorietrackweekBloc)
            ],
            child: HomePage(),
          ),
        );
      case AddCaloriePage.routeName:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _loginBloc),
              BlocProvider.value(value: _calorietrackBloc)
            ],
            child: AddCaloriePage(),
          ),
        );
      case AddWaterPage.routeName:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _loginBloc),
              BlocProvider.value(value: _calorietrackBloc)
            ],
            child: AddWaterPage(),
          ),
        );
      case ReminderPage.routeName:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _loginBloc,
            child: ReminderPage(),
          ),
        );
      case RegisterPage.routeName:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _registerBloc,
            child: RegisterPage(),
          ),
        );
      case SetUpPage.routeName:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _registerBloc,
            child: SetUpPage(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _loginBloc,
            child: LoginPage(),
          ),
        );
    }
  }
}
