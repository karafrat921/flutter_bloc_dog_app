import 'package:dog_test/core/extension/screen_size.dart';
import 'package:flutter/material.dart';
import '../../core/enums/tab_item.dart';
import '../widget/are_you_sure_exit_popup.dart';
import 'bottom_navigation.dart';
import 'tab_navigator.dart';

class App extends StatefulWidget {
  static const String id = "app_screen";
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  var _currentTab = TabItem.home;
  final _navigatorKeys = {
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.settings: GlobalKey<NavigatorState>(),
  };

  void _selectTab(TabItem tabItem) {
    if (tabItem == _currentTab) {
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab = !await _navigatorKeys[_currentTab]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentTab != TabItem.home) {
            _selectTab(TabItem.home);
            return false;
          }
        }
        return isFirstRouteInCurrentTab;
      },
      child: AreYouSureExitPopup(
        child: SafeArea(
          top: false,
          child: Scaffold(
            extendBody: true,

            bottomNavigationBar: BottomNavigation(
              currentTab: _currentTab,
              onSelectTab: _selectTab,
            ),
            body: Stack(
              children: <Widget>[
                _buildOffstageNavigator(TabItem.home),
                _buildOffstageNavigator(TabItem.settings),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(TabItem tabItem) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: _currentTab == TabItem.settings ? Curves.easeInOut : Curves.easeOut,
        transform: Matrix4.translationValues(
          0.0,
          _currentTab == tabItem ? 0.0 : (_currentTab == TabItem.settings ? -context.screenHeight : context.screenHeight),
          0.0,
        ),
        child: TabNavigator(
          navigatorKey: _navigatorKeys[tabItem],
          onSelectTab: _selectTab,
          tabItem: tabItem,
        ),
      ),
    );
  }

}
