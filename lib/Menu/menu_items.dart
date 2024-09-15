import 'package:flutter/material.dart';
import 'package:flutter_desktop_sql/Menu/menu_details.dart';
import 'package:flutter_desktop_sql/Menu/pages/accounts.dart';
import 'package:flutter_desktop_sql/Menu/pages/dashboard.dart';
import 'package:flutter_desktop_sql/Menu/pages/notifications.dart';
import 'package:flutter_desktop_sql/Menu/pages/reports.dart';
import 'package:flutter_desktop_sql/Menu/pages/settings.dart';

class MenuItems {
  List<MenuDetails> items = [
    MenuDetails(icon: Icons.home, page: Dashboard(), title: 'Dashboard'),
    MenuDetails(
        icon: Icons.account_circle_rounded,
        page: Accounts(),
        title: 'Accounts'),
    MenuDetails(
        icon: Icons.notification_important_rounded,
        page: Notifications(),
        title: 'Notifications'),
    MenuDetails(icon: Icons.add_chart, page: Reports(), title: 'Reports'),
    MenuDetails(icon: Icons.settings, page: Settings(), title: 'Settings'),
  ];
}
