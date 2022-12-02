import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*Future<bool> admincheck() async {
  SharedPreferences.setMockInitialValues({});
  print("1");
  final prefs = await SharedPreferences.getInstance();
  print("2");
  final bool? admin = prefs.getBool('admin');
  print("3");
  return admin ?? false;
}*/

Future adminset() async {
  //SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('admin', true);
  return true;
}

Future adminsetfalse() async {
  //SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('admin', false);
  return true;
}

Future<bool?> adminget() async {
  final prefs = await SharedPreferences.getInstance();
  var data = prefs.getBool('admin');
  debugPrint(data.toString());
  return data;
}
