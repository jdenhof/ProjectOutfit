import 'package:flutter/material.dart';
import 'package:ootd/app/constants/keys.dart';
import 'package:ootd/app/constants/strings.dart';

enum TabItem { history, home }

class TabItemData {
  const TabItemData(
      {required this.key, required this.title, required this.icon});

  final String key;
  final String title;
  final IconData icon;

  static const Map<TabItem, TabItemData> allTabs = {
    TabItem.history: TabItemData(
      key: Keys.historyTab,
      title: Strings.history,
      icon: Icons.history,
    ),
    TabItem.home: TabItemData(
      key: Keys.homeTab,
      title: Strings.homePage,
      icon: Icons.home_outlined,
    ),
  };
}
