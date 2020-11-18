import 'package:bloodpressurelog/addRecord.dart';
import 'package:bloodpressurelog/history.dart';
import 'package:bloodpressurelog/home.dart';
import 'package:bloodpressurelog/settings.dart';
import 'package:bloodpressurelog/utils/AppLocalization.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  static int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      items: [
        TabItem(
            icon: Icons.home,
            title: AppLocalizations.of(context).translate("home")),
        TabItem(
            icon: Icons.history,
            title: AppLocalizations.of(context).translate("history")),
        TabItem(
            icon: Icons.add,
            title: AppLocalizations.of(context).translate("add")),
        TabItem(
            icon: Icons.settings,
            title: AppLocalizations.of(context).translate("settings")),
      ],
      initialActiveIndex: currentIndex,
      onTap: (int i) {
        if (currentIndex != i) {
          currentIndex = i;

          switch (i) {
            case 0:
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => HomePage()));
              break;

            case 1:
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => History()));
              break;

            case 2:
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => AddRecord()));
              break;

            case 3:
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => Settings()));
              break;
          }
        }
      },
    );
  }
}
