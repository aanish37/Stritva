import 'package:flutter/material.dart';
import './view/calendar_page.dart';
import './view/dashboard_page.dart';
import './view/info_page.dart';
import './view/profile_page.dart';


const backgroundColor = (Colors.pinkAccent);

var buttonColor = Color.fromARGB(255,179, 255, 236	);

const borderColor = Color.fromARGB(255, 150, 211, 242);

//FIREBASE

const pages = [
  DashboardPage(),
  CalendarPage(),
  InfoPage(),
  ProfilePage(),

];
