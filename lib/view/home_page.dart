import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant.dart';
import 'package:provider/provider.dart';
import '../model/user_data.dart';
import 'coming_soon.dart';

class HomePage extends StatefulWidget {
  static String id = 'HomePage';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> setBool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('seen', true);

    // ignore: use_build_context_synchronously
    Provider.of<UserData>(context, listen: false).getUserFromPrefs();
  }

  @override
  void initState() {
    super.initState();
    setBool();
  }

  int _index = 0;

  void _onItemTapped(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Strtiva',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Ubuntu',
          textTheme: const TextTheme(
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
          scaffoldBackgroundColor: backgroundColor,
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
          resizeToAvoidBottomInset: false,
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: backgroundColor,
            centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: const Icon(
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
                child: SizedBox(
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
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: backgroundColor,
            selectedItemColor: buttonColor,
            elevation: 5,
            items: [
              BottomNavigationBarItem(
                  icon: _index == 0
                      ? const Icon(Icons.dashboard_rounded)
                      : const Icon(Icons.dashboard_outlined),
                  label: 'dashboard'),
              BottomNavigationBarItem(
                  icon: _index == 1
                      ? const Icon(Icons.calendar_month_sharp)
                      : const Icon(Icons.calendar_month_outlined),
                  label: 'calendar'),
              BottomNavigationBarItem(
                  icon: _index == 2
                      ? const Icon(Icons.tips_and_updates_sharp)
                      : const Icon(Icons.tips_and_updates_outlined),
                  label: 'info'),
              BottomNavigationBarItem(
                  icon: _index == 3
                      ? const Icon(Icons.manage_accounts_rounded)
                      : const Icon(Icons.manage_accounts_outlined),
                  label: 'Profile')
            ],
            currentIndex: _index,
            onTap: _onItemTapped,
          ),
          body: pages[_index]),
    );
  }
}
