import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrition_app/constants/ui_constants.dart';
import 'package:nutrition_app/data/dark/cubit/dark_cubit.dart';
import 'package:nutrition_app/models/profile.dart';
import 'package:nutrition_app/services/http_service.dart';

class SettingPage extends StatefulWidget {
  final String username;

  const SettingPage({Key key, this.username}) : super(key: key);
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  UiConstants defaultUiValues = UiConstants();
  HttpService httpService = HttpService();
  bool _darkMode = false;
  int _currentIndex = 0;
  Profile profile;

  @override
  void initState() {
    getProfileDetail();
    super.initState();
  }

  getProfileDetail() async {
    profile = await httpService.getUserDetails(username: widget.username);
  }

  @override
  Widget build(BuildContext context) {
    return _settingPageView();
  }

  Widget _settingPageView() {
    return Container(
      child: Row(
        children: [_sideBar(), _settingBoard()],
      ),
    );
  }

  Widget _getSettingsTab() {
    if (_currentIndex == 0) {
      return _applicationTab();
    } else if (_currentIndex == 1) {
      return _profileTab();
    } else if (_currentIndex == 2) {
      return _moreInfoTab();
    } else {
      return _applicationTab();
    }
  }

  Widget _moreInfoTab() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 18),
            child: Text(
              "More info",
              style: TextStyle(
                  color: Colors.black54, fontFamily: 'Poppins', fontSize: 18),
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 18, horizontal: 18)),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
                "This is an application to help you record your health by tracking your calories intake.",
                style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins',
                    fontSize: 18)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                "The Home tab is where you can see and add your calories in a daily basis.",
                style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins',
                    fontSize: 18)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                "The Profile tab is where you can see and add your calories in a weekly basis.",
                style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins',
                    fontSize: 18)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("The Reminders tab is where you can add reminders.",
                style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins',
                    fontSize: 18)),
          )
        ],
      ),
    );
  }

  Widget _profileTab() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 18),
            child: Text(
              "Profile settings",
              style: TextStyle(
                  color: Colors.black54, fontFamily: 'Poppins', fontSize: 18),
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 18, horizontal: 18)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(profile.username ?? "Failed to get",
                style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins',
                    fontSize: 18)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(profile.name ?? "Failed to get",
                style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins',
                    fontSize: 18)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(profile.dob ?? "Failed to get",
                style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins',
                    fontSize: 18)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(profile.gender ?? "Failed to get",
                style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Poppins',
                    fontSize: 18)),
          ),
        ],
      ),
    );
  }

  Widget _applicationTab() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 18),
            child: Text(
              "Application settings",
              style: TextStyle(
                  color: Colors.black54, fontFamily: 'Poppins', fontSize: 18),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: SwitchListTile(
              contentPadding: EdgeInsets.zero,
              onChanged: (bool value) {
                setState(() {
                  _darkMode = value;
                  if (_darkMode) {
                    BlocProvider.of<DarkCubit>(context).changeState();
                  } else {
                    BlocProvider.of<DarkCubit>(context).changeStateBack();
                  }
                });
              },
              value: _darkMode,
              title: Text("Dark Mode",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _settingBoard() {
    return Expanded(
      flex: 2,
      child: Container(
        child: _getSettingsTab(),
      ),
    );
  }

  Widget _sideBar() {
    return Expanded(
      flex: 1,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: defaultUiValues.defaultPads,
            horizontal: defaultUiValues.defaultSmallPads),
        decoration: BoxDecoration(
          border: Border(
              right:
                  BorderSide(color: Color.fromARGB(60, 19, 19, 19), width: 1)),
        ),
        child: Column(
          children: [
            BlocBuilder<DarkCubit, DarkState>(
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: defaultUiValues.defaultPads),
                  child: Icon(
                    Icons.settings,
                    color: state.color,
                    size: 50,
                  ),
                );
              },
            ),
            _appSettingButton(),
            _profileSettingButton(),
            _infoButton(),
            Spacer(),
            _logOutButton()
          ],
        ),
      ),
    );
  }

  Widget _appSettingButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          _currentIndex = 0;
        });
      },
      child: Text(
        "Application",
        style: TextStyle(
            color: Colors.black54, fontFamily: 'Poppins', fontSize: 14),
      ),
    );
  }

  Widget _profileSettingButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          _currentIndex = 1;
        });
      },
      child: Text(
        "Profile",
        style: TextStyle(
            color: Colors.black54, fontFamily: 'Poppins', fontSize: 14),
      ),
    );
  }

  Widget _infoButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          _currentIndex = 2;
        });
      },
      child: Row(
        children: [
          Icon(Icons.info),
          Text(
            "More info",
            style: TextStyle(
                color: Colors.black54, fontFamily: 'Poppins', fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _logOutButton() {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(
        "Log Out",
        style: TextStyle(
            color: Colors.black54, fontFamily: 'Poppins', fontSize: 14),
      ),
    );
  }
}
