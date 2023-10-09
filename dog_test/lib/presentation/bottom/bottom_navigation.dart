import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/enums/tab_item.dart';
import '../widget/custom_bottom_widget.dart';
import 'tab_item.dart';

class BottomNavigation extends StatelessWidget {
   BottomNavigation({
    Key? key,
    required this.currentTab,
    required this.onSelectTab,
  }) : super(key: key);
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(MediaQuery.of(context).size.width, (MediaQuery.of(context).size.width * 0.26).toDouble()),
      painter: RPSCustomPainter(),
      child: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,

        height: currentTab==TabItem.home?98:0,
        padding: EdgeInsets.zero,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildItem(TabItem.home, context),
            Container(
              decoration: BoxDecoration(
                color: Color(0xffD1D1D6),
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(2),
                  left: Radius.circular(2),
                ),
              ),
              width: 2,
              height: 24,
            ),
            _buildItem(TabItem.settings, context),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(TabItem tabItem, context) {
    Map<TabItem, String> tabName = {
      TabItem.home: "Home",
      TabItem.settings: "Settings",
    };

    return Expanded(
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        onTap: () => onSelectTab(
          TabItem.values[tabItem == TabItem.home ? 0 : 1],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SvgPicture.asset(
              tabIconPath[tabItem]!,
              color: _colorTabMatching(tabItem),
            ),
            Text(
              tabName[tabItem]!,
              style: customTextStyle(tabItem),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle customTextStyle(TabItem item) {
    Color color = _colorTabMatching(item);

    TextStyle selectedTextStyle = TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: color);
    TextStyle unSelectedTextStyle = TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: color,
    );
    return currentTab == item ? selectedTextStyle : unSelectedTextStyle;
  }

  Color _colorTabMatching(TabItem item) {
    return currentTab == item ? Color(0xff0055D3) : Colors.black;
  }
}
