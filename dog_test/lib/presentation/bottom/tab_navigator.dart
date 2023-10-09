import 'package:dog_test/presentation/pages/home/home_page.dart';
import 'package:dog_test/presentation/pages/settings/settings_page.dart';
import 'package:flutter/material.dart';
import '../../core/enums/tab_item.dart';

class TabNavigator extends StatefulWidget {
  const TabNavigator({
    Key? key,
    required this.navigatorKey,
    required this.tabItem,
    required this.onSelectTab
  }) : super(key: key);
  final GlobalKey<NavigatorState>? navigatorKey;
  final TabItem tabItem;
  final ValueChanged<TabItem> onSelectTab;

  @override
  State<TabNavigator> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  @override
  Widget build(BuildContext context) {
    Widget child;
    if (widget.tabItem == TabItem.home) {
      child = HomePage();
    } else if (widget.tabItem == TabItem.settings) {
      setState(() {

      });
      child = SettingPage(onSelectTab: widget.onSelectTab,);
    } else {
      child = Container();
    }
    return Navigator(
      key: widget.navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => child,
        );
      },
    );
  }
}
