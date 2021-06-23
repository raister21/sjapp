import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrition_app/constants/ui_constants.dart';
import 'package:nutrition_app/data/dark/cubit/dark_cubit.dart';
import 'package:nutrition_app/services/notification_service.dart';
import 'package:nutrition_app/utility/app_bloc_observer.dart';
import 'package:nutrition_app/utility/router.dart';
import 'package:provider/provider.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final defaultVlaues = UiConstants();
  @override
  Widget build(BuildContext context) {
    final RouteGenerator _routeGenerator = RouteGenerator();
    return BlocProvider(
      create: (context) => DarkCubit(),
      child: MultiProvider(
          child: BlocBuilder<DarkCubit, DarkState>(
            builder: (context, state) {
              return MaterialApp(
                title: 'Nutrition',
                theme: ThemeData(
                    primarySwatch: state.color, primaryColor: state.color),
                onGenerateRoute: _routeGenerator.generateRoute,
              );
            },
          ),
          providers: [
            ChangeNotifierProvider(create: (_) => NotificationService())
          ]),
    );
  }
}
