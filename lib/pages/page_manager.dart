import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hikebite/pages/tabs/account_page.dart';
import 'package:hikebite/pages/auth_page.dart';
import 'package:hikebite/pages/tabs/community_page.dart';
import 'package:hikebite/pages/tabs/food_page.dart';
import 'package:hikebite/pages/tabs/home_page.dart';
import 'package:hikebite/pages/welcome_page.dart';
import 'package:hikebite/utils/auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageManager extends ConsumerStatefulWidget {
  const PageManager({super.key});

  @override
  PageManagerState createState() => PageManagerState();
}

enum Tab { home, food, community, account }

class PageManagerState extends ConsumerState<PageManager> {
  Tab _currentTab = Tab.home;

  @override
  void initState() {
    super.initState();
    // FlutterNativeSplash.remove();
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
    final user = ref.watch(authStateChangesProvider);

    return Scaffold(
      body: SafeArea(
        child: user.when(
          skipLoadingOnRefresh: true,
          skipLoadingOnReload: true,
          data: (user) {
            if (user == null) {
              // NOT logged in
              return const AuthPage();
            } else {
              // user IS logged in
              return _tabsPage();
            }
          },
          error: (e, s) =>const CircularProgressIndicator(),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
      bottomNavigationBar: (user.value == null)
          // NOT logged in
          ? null
          // user IS logged in
          : BottomNavigationBar(
              currentIndex: _currentTab.index,
              onTap: (index) {
                setState(() {
                  _currentTab = Tab.values[index];
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.backpack),
                  label: 'Trips',
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
    );
  }
}
