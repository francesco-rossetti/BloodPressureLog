import 'package:bloodpressurelog/domain/lang/app_localization.dart';
import 'package:bloodpressurelog/pages/add_record.dart';
import 'package:bloodpressurelog/pages/history.dart';
import 'package:bloodpressurelog/pages/home.dart';
import 'package:bloodpressurelog/pages/settings.dart';
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
                  builder: (BuildContext context) => const HistoryPage()));
              break;

            case 2:
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => const AddRecordPage()));
              break;

            case 3:
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => const SettingsPage()));
              break;
          }
        }
      },
    );
  }
}
