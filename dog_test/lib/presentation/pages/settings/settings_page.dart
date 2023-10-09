import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/assets.dart';
import '../../../core/enums/tab_item.dart';

class SettingPage extends StatelessWidget {
  final ValueChanged<TabItem> onSelectTab;

  const SettingPage({super.key, required this.onSelectTab});

  String getVersion() {
    if (Platform.isAndroid) {
      return Platform.version;
    } else if (Platform.isIOS) {
      return Platform.operatingSystemVersion;
    } else {
      return 'Bu platform desteklenmiyor.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onVerticalDragUpdate:(details) => onSelectTab(TabItem.home),
              child: Container(
                margin: EdgeInsets.all(20),
                height: 4,
                width: 32,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(229, 229, 234, 1),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: SvgPicture.asset(
                      data[index].leadingPath,
                      height: 32,
                      color: Colors.black,
                    ),
                    trailing: data[index].isIcon == true
                        ? SvgPicture.asset(
                            data[index].trailingData,
                            height: 9.5,
                            color: Color(0xffC7C7CC),
                          )
                        : Text(getVersion()),
                    title: Text(
                      data[index].title,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Container(
                  height: 2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(0xffE5E5EA),
                  ),
                ),
                itemCount: data.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SettingsData {
  final String title;
  final String leadingPath;
  final String trailingData;
  final bool? isIcon;

  SettingsData({
    required this.title,
    required this.leadingPath,
    required this.trailingData,
    this.isIcon = true,
  });
}

List<SettingsData> data = [
  SettingsData(
    title: "Help",
    leadingPath: Assets.helpIcon,
    trailingData: Assets.arrowIcon,
  ),
  SettingsData(
    title: "Rate Us",
    leadingPath: Assets.rateUsIcon,
    trailingData: Assets.arrowIcon,
  ),
  SettingsData(
    title: "Share with Friends",
    leadingPath: Assets.shareIcon,
    trailingData: Assets.arrowIcon,
  ),
  SettingsData(
    title: "Terms of Use",
    leadingPath: Assets.termsIcon,
    trailingData: Assets.arrowIcon,
  ),
  SettingsData(
    title: "Privacy Policy",
    leadingPath: Assets.privacyIcon,
    trailingData: Assets.arrowIcon,
  ),
  SettingsData(
    title: "OS Version",
    leadingPath: Assets.osIcon,
    trailingData: Assets.arrowIcon,
    isIcon: false,
  ),
];
