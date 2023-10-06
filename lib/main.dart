import 'package:flutter/material.dart';
import './view/home_page.dart';
import './constant.dart';
import './model/note_data.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(context)=>NoteData(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: Color.fromARGB(255, 249, 230, 236),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: backgroundColor,
              selectedItemColor: buttonColor,
              unselectedItemColor: buttonColor,
            ),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            primarySwatch: Colors.pink,
            buttonTheme: ButtonThemeData(buttonColor: buttonColor)),
        home: HomePage(),
      ),
    );
  }
}
