import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nutrition_app/models/account.dart';
import 'package:nutrition_app/models/dashboard.dart';
import 'package:nutrition_app/models/profile.dart';

class HttpService {
  final String baseUrl = 'http://192.168.1.75:4000/';

  Future<Account> attemptLogin({String username, String password}) async {
    try {
      var response = await http.post(Uri.parse(baseUrl + 'login'),
          body: {'username': username, 'password': password});

      if (response.statusCode == 200) {
        Account acc = Account.fromJson(jsonDecode(response.body));
        return acc;
      } else {
        Account acc = Account();
        return acc;
      }
    } catch (e) {
      print(e);
      Account acc = Account();
      return acc;
    }
  }

  Future<DashBoard> getDailyCalorieStatus({String username}) async {
    try {
      int carbs = 0;
      int proteins = 0;
      int calories = 0;
      int fats = 0;
      int water = 0;

      double carbsRatio = 0;
      double proteinsRatio = 0;
      double fatsRatio = 0;
      double caloriesRatio = 0;
      double waterRatio = 0;

      var dailyResponse = await http.get(
        Uri.parse(baseUrl + 'daily/$username'),
      );
      var dietResponse = await http.get(
        Uri.parse(baseUrl + 'diet/$username'),
      );

      for (var i in jsonDecode(dailyResponse.body)) {
        if (i['carbsIntake'] != null) {
          carbs += i['carbsIntake'];
          calories += i['carbsIntake'];
        }
        if (i['proteinIntake'] != null) {
          proteins += i['proteinIntake'];
          calories += i['proteinIntake'];
        }
        if (i['fatIntake'] != null) {
          fats += i['fatIntake'];
          calories += i['fatIntake'];
        }
        if (i['waterIntake'] != null) {
          water += i['waterIntake'];
        }
      }

      caloriesRatio =
          calories / jsonDecode(dietResponse.body)[0]['dailyCalories'];
      carbsRatio = carbs /
          (jsonDecode(dietResponse.body)[0]['dailyCarbsRatio'] *
              jsonDecode(dietResponse.body)[0]['dailyCalories']);
      proteinsRatio = proteins /
          (jsonDecode(dietResponse.body)[0]['dailyProteinRatio'] *
              jsonDecode(dietResponse.body)[0]['dailyCalories']);
      fatsRatio = fats /
          (jsonDecode(dietResponse.body)[0]['dailyFatRatio'] *
              jsonDecode(dietResponse.body)[0]['dailyCalories']);
      waterRatio = water / jsonDecode(dietResponse.body)[0]['dailyWater'];

      DashBoard dashBoard = DashBoard(
          caloriesDailyValue: caloriesRatio < 1 ? caloriesRatio : 1,
          carbsDailyValue: carbsRatio < 1 ? carbsRatio : 1,
          proteinsDailyValue: proteinsRatio < 1 ? proteinsRatio : 1,
          fatsDailyValue: fatsRatio < 1 ? fatsRatio : 1,
          waterDailyValue: waterRatio < 1 ? waterRatio : 1);

      return dashBoard;
    } catch (e) {
      print("error in getCaloriesHttp");
      print(e);
      return new DashBoard();
    }
  }

  Future<DashBoard> getWeeklyCalorieStatus({String username}) async {
    try {
      int carbs = 0;
      int proteins = 0;
      int calories = 0;
      int fats = 0;
      int water = 0;

      double carbsRatio;
      double proteinsRatio;
      double fatsRatio;
      double caloriesRatio;
      double waterRatio;

      var weeklyResponse = await http.get(
        Uri.parse(baseUrl + 'weekly/$username'),
      );

      var dietResponse = await http.get(
        Uri.parse(baseUrl + 'diet/$username'),
      );

      for (var i in jsonDecode(weeklyResponse.body)) {
        if (i['carbsIntake'] != null) {
          carbs += i['carbsIntake'];
          calories += i['carbsIntake'];
        }
        if (i['proteinIntake'] != null) {
          proteins += i['proteinIntake'];
          calories += i['proteinIntake'];
        }
        if (i['fatIntake'] != null) {
          fats += i['fatIntake'];
          calories += i['fatIntake'];
        }
        if (i['waterIntake'] != null) {
          water += i['waterIntake'];
        }
      }

      caloriesRatio =
          calories / (jsonDecode(dietResponse.body)[0]['dailyCalories'] * 7);
      carbsRatio = carbs /
          (jsonDecode(dietResponse.body)[0]['dailyCarbsRatio'] *
              7 *
              jsonDecode(dietResponse.body)[0]['dailyCalories']);

      proteinsRatio = proteins /
          (jsonDecode(dietResponse.body)[0]['dailyProteinRatio'] *
              7 *
              jsonDecode(dietResponse.body)[0]['dailyCalories']);
      fatsRatio = fats /
          (jsonDecode(dietResponse.body)[0]['dailyFatRatio'] *
              7 *
              jsonDecode(dietResponse.body)[0]['dailyCalories']);
      waterRatio = water / (jsonDecode(dietResponse.body)[0]['dailyWater'] * 7);

      DashBoard dashBoard = DashBoard(
          caloriesDailyValue: caloriesRatio < 1 ? caloriesRatio : 1,
          carbsDailyValue: carbsRatio < 1 ? carbsRatio : 1,
          proteinsDailyValue: proteinsRatio < 1 ? proteinsRatio : 1,
          fatsDailyValue: fatsRatio < 1 ? fatsRatio : 1,
          waterDailyValue: waterRatio < 1 ? waterRatio : 1);

      return dashBoard;
    } catch (e) {
      print("error in getCaloriesHttp");
      print(e);
      return new DashBoard();
    }
  }

  Future<bool> postDailyCalorie(
      {String username, int carbs, int proteins, int fats}) async {
    try {
      var response =
          await http.post(Uri.parse(baseUrl + 'daily/calories'), body: {
        'username': username,
        'carbs': carbs.toString(),
        'proteins': proteins.toString(),
        'fats': fats.toString()
      });

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> postDailyWater({String username, int water}) async {
    try {
      var response = await http.post(Uri.parse(baseUrl + 'daily/water'),
          body: {'username': username, 'water': water.toString()});

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> postUserProfile(
      {String username,
      DateTime dateTime,
      String password,
      String name,
      String gender}) async {
    try {
      print("From post user");
      print(username);
      var response = await http.post(Uri.parse(baseUrl + 'profile'), body: {
        'username': username,
        'dob': dateTime.toString(),
        'password': password,
        'gender': gender,
        'name': name,
      });

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("From here");
      print(e);
      return false;
    }
  }

  Future<bool> postUserDetails(
      {String username, String code, String height, int weight}) async {
    try {
      print("POsting user detail" + username);
      var response =
          await http.post(Uri.parse(baseUrl + 'profile/details'), body: {
        'username': username,
        'code': code,
        'height': height,
        'weight': weight.toString(),
      });

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("From here");
      print("POsting user detail error");
      print(e);
      return false;
    }
  }

  Future<Profile> getUserDetails({String username}) async {
    try {
      var response = await http.get(Uri.parse(baseUrl + 'profile/$username'));
      var jsonObj = json.decode(response.body);

      if (response.statusCode == 200) {
        return Profile(jsonObj['username'], jsonObj['name'], jsonObj['dob'],
            jsonObj['gender']);
      } else {
        return Profile(username, null, null, null);
      }
    } catch (e) {
      print("From here");
      print(e);
      return Profile(username, null, null, null);
    }
  }
}
