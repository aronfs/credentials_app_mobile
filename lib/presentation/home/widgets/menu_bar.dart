import 'package:archive_secure/presentation/dashboard/dashboard_page.dart';
import 'package:archive_secure/presentation/profile/profile_page.dart';
import 'package:archive_secure/presentation/screens/category_page.dart';
import 'package:archive_secure/presentation/screens/credential_page.dart';
import 'package:archive_secure/presentation/screens/generate_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final Map<String, Widget> menuWidgets = {
  '/pages/dashboard': const DashboardPage(),
  '/pages/credential': const CredentialPage(),
  '/pages/category': const CategoryPage(),
  '/pages/generate': const GeneratePage(),
  '/pages/profile': const ProfilePage(),
};

final Map<String, FaIconData> iconMap = {
  'dashboard': FontAwesomeIcons.house,
  'credential': FontAwesomeIcons.key,
  'category': FontAwesomeIcons.tags,
  'generate': FontAwesomeIcons.lock,
  'profile': FontAwesomeIcons.user,
};
