import 'package:flutter/material.dart';
import 'package:nutrition_app/constants/ui_constants.dart';

import 'package:nutrition_app/models/reminder.dart';
import 'package:nutrition_app/presentation/additional_pages/reminder_page.dart';
import 'package:nutrition_app/services/notification_service.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  UiConstants defaultUiValues = UiConstants();
  TextEditingController _secondsController = TextEditingController();
  TextEditingController _minutesController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _reminderController = TextEditingController();

  // Test notification
  List<Reminder> reminders = [];

  @override
  void initState() {
    Provider.of<NotificationService>(context, listen: false).initialize();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _notficiationPageView();
  }

  Widget _notficiationPageView() {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Container(
          padding: EdgeInsets.all(defaultUiValues.defaultPads),
          child: Consumer<NotificationService>(
            builder: (context, model, _) => Container(
              child: _notifcationBoard(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _notifcationBoard() {
    return Container(
      height: MediaQuery.of(context).size.height - 200,
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
        children: [_notificationList(), _addNotificationButton()],
      ),
    );
  }

  Widget _notificationList() {
    return Expanded(
      flex: 6,
      child: _addReminder(),
    );
  }

  Widget _addReminder() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(defaultUiValues.defaultPads),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Add your Reminder!",
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontSize: 28,
                fontWeight: FontWeight.bold),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: defaultUiValues.defaultSmallPads),
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(
                              defaultUiValues.roundedSmallRadius))),
                      hintText: 'Title'),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 12)),
                TextFormField(
                  controller: _reminderController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(
                              defaultUiValues.roundedSmallRadius))),
                      hintText: 'Reminder'),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 12)),
                TextFormField(
                  controller: _minutesController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(
                              defaultUiValues.roundedSmallRadius))),
                      hintText: 'Minutes'),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 12)),
                TextFormField(
                  controller: _secondsController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.all(Radius.circular(
                              defaultUiValues.roundedSmallRadius))),
                      hintText: 'Seconds'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _addNotificationButton() {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: defaultUiValues.defaultPads,
            horizontal: defaultUiValues.defaultPads),
        child: TextButton(
            onPressed: () {
              int minutes = 0;
              int seconds = 0;
              if (_minutesController.text.isNotEmpty) {
                minutes = int.parse(_minutesController.text);
              }
              if (_secondsController.text.isNotEmpty) {
                seconds = int.parse(_secondsController.text);
              }
              Provider.of<NotificationService>(context, listen: false)
                  .scheduledNotification(
                      title: _titleController.text ?? "Title",
                      body: _reminderController.text ?? "Empty body",
                      minutes: minutes,
                      seconds: seconds);
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
              "Reminder",
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Poppins', fontSize: 14),
            )),
      ),
    );
  }
}
