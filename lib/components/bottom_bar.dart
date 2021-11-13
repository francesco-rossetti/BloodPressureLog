import 'package:bloodpressurelog/add_record.dart';
import 'package:bloodpressurelog/history.dart';
import 'package:bloodpressurelog/home.dart';
import 'package:bloodpressurelog/settings.dart';
import 'package:bloodpressurelog/utils/app_localization.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  static int currentIndex = 0;

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavyBar(
      items: [
        BottomNavyBarItem(
            icon: const Icon(Icons.home),
            title: Text(AppLocalizations.of(context)!.translate("home")!),
            activeColor: Theme.of(context).brightness == Brightness.light
                ? Colors.blue
                : Colors.white),
        BottomNavyBarItem(
            icon: const Icon(Icons.history),
            title: Text(AppLocalizations.of(context)!.translate("history")!),
            activeColor: Theme.of(context).brightness == Brightness.light
                ? Colors.blue
                : Colors.white),
        BottomNavyBarItem(
            icon: const Icon(Icons.add),
            title: Text(AppLocalizations.of(context)!.translate("add")!),
            activeColor: Theme.of(context).brightness == Brightness.light
                ? Colors.blue
                : Colors.white),
        BottomNavyBarItem(
            icon: const Icon(Icons.settings),
            title: Text(AppLocalizations.of(context)!.translate("settings")!),
            activeColor: Theme.of(context).brightness == Brightness.light
                ? Colors.blue
                : Colors.white),
      ],
      selectedIndex: BottomBar.currentIndex,
      onItemSelected: (int i) {
        if (BottomBar.currentIndex != i) {
          BottomBar.currentIndex = i;

          switch (i) {
            case 0:
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => const HomePage()));
              break;

            case 1:
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => const History()));
              break;

            case 2:
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => const AddRecord()));
              break;

            case 3:
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => const Settings()));
              break;
          }
        }
      },
    );
  }
}
