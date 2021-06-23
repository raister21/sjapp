import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrition_app/data/authentication/bloc/login_bloc.dart';
import 'package:nutrition_app/presentation/pages/home_pages/dashboard_page.dart';
import 'package:nutrition_app/presentation/pages/home_pages/notifications_page.dart';
import 'package:nutrition_app/presentation/pages/home_pages/profile_page.dart';
import 'package:nutrition_app/presentation/pages/home_pages/setting_page.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/home";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> _homePages = [
      BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return DashBoardPage(
            username: state.account.username,
          );
        },
      ),
      BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return ProfilePage(
            username: state.account.username,
          );
        },
      ),
      NotificationPage(),
      BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return SettingPage(
            username: state.account.username,
          );
        },
      ),
    ];

    return SafeArea(
      child: Scaffold(
        body: _homePages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: "Reminders",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
            )
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
