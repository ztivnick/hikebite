import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hikebite/pages/account_page.dart';
import 'package:hikebite/pages/community_page.dart';
import 'package:hikebite/pages/food_page.dart';
import 'package:hikebite/pages/home_page.dart';
import 'package:hikebite/pages/welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageManager extends StatefulWidget {
  const PageManager({super.key});

  @override
  State<PageManager> createState() => _PageManagerState();
}

enum Tab { home, food, community, account }

class _PageManagerState extends State<PageManager> {
  Tab _currentTab = Tab.home;
  bool _showWelcomePage = true;

  @override
  void initState() {
    super.initState();
    _checkFirstTimeOpen();
    FlutterNativeSplash.remove();
  }

  void _checkFirstTimeOpen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool showWelcomePage = prefs.getBool('showWelcomePage') ?? true;

    setState(() {
      _showWelcomePage = showWelcomePage;
    });
  }

  Widget _tabsPage() {
    switch (_currentTab) {
      case Tab.home:
        return HomePage();
      case Tab.food:
        return FoodPage();
      case Tab.community:
        return CommunityPage();
      case Tab.account:
        return AccountPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
        body: _showWelcomePage
            ? WelcomePage(
                popWelcomePage: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setBool('showWelcomePage', false);
                  setState(() {
                    _showWelcomePage = false;
                  });
                },
              )
            : _tabsPage(),
        bottomNavigationBar: _showWelcomePage
            ? const SizedBox.shrink()
            : BottomNavigationBar(
                currentIndex: _currentTab.index,
                onTap: (index) {
                  setState(() {
                    _currentTab = Tab.values[index];
                  });
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.dining),
                    label: 'Food',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.people),
                    label: 'Community',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle_rounded),
                    label: 'Account',
                  ),
                ],
                selectedItemColor: colorScheme.tertiary,
                unselectedItemColor: colorScheme.tertiary,
              ),
        backgroundColor: colorScheme.background);
  }
}
