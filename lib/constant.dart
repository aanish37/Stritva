import 'package:flutter/material.dart';
import './view/calendar_page.dart';
import './view/dashboard_page.dart';
import './view/info_page.dart';
import './view/profile_page.dart';

const backgroundColor = Color.fromARGB(255, 249, 230, 236);

var buttonColor = Colors.pinkAccent[400];
var unselectedButtonColor = Colors.pink[200];
var textColor = Colors.pinkAccent[700];

const borderColor = Colors.deepPurple;


//FIREBASE

const pages = [
  DashboardPage(),
  CalendarPage(),
  InfoPage(),
  ProfilePage(),
];
