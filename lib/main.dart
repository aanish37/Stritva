import 'package:flutter/material.dart';
import 'package:stritva/view/coming_soon.dart';
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
      create: (context) => NoteData(),
      child: MaterialApp(
        title: 'Strtiva',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'Ubuntu',
            textTheme: TextTheme(
              bodyMedium: TextStyle(
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.w400,
              ),
              titleLarge: TextStyle(
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.bold,
              ),
              titleMedium: TextStyle(
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.bold,
              ),
              titleSmall: TextStyle(
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.bold,
              ),
            ),
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
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: backgroundColor,
              centerTitle: true,
              leading: Padding(
                padding: EdgeInsets.only(right: 10),
                child: IconButton(
                  icon: Icon(
                    Icons.notifications_none_outlined,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return const ComingSoon();
                      }),
                    );
                  },
                  color: buttonColor,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    height: 30,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset('asset/images/profile.png'),
                    ),
                  ),
                ),
              ],
              title: Text(
                'Stritva',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: buttonColor,
                    fontSize: 28),
              ),
            ),
            body: HomePage()),
      ),
    );
  }
}
