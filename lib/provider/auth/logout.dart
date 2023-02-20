import 'package:shared_preferences/shared_preferences.dart';

Future<void>Logout()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove("id");
  prefs.remove("username");
  prefs.remove("email");
  prefs.remove("loginStatus");
}