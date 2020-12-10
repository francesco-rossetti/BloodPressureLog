import 'package:bloodpressurelog/addRecord.dart';
import 'package:bloodpressurelog/components/bottomBar.dart';
import 'package:bloodpressurelog/history.dart';
import 'package:bloodpressurelog/utils/AppLocalization.dart';
import 'package:flutter/material.dart';
import 'package:quick_actions/quick_actions.dart';

class QuickActionsManager extends StatefulWidget {
  final Widget child;
  QuickActionsManager({Key key, this.child}) : super(key: key);

  _QuickActionsManagerState createState() => _QuickActionsManagerState();
}

class _QuickActionsManagerState extends State<QuickActionsManager> {
  final QuickActions quickActions = QuickActions();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _setupQuickActions();
    _handleQuickActions();
  }

  void _setupQuickActions() {
    quickActions.setShortcutItems(<ShortcutItem>[
      ShortcutItem(
          type: 'action_home',
          localizedTitle: AppLocalizations.of(context).translate("home"),
          icon: 'splash'),
      ShortcutItem(
          type: 'action_history',
          localizedTitle:
              AppLocalizations.of(context).translate("historyValues"),
          icon: 'splash'),
      ShortcutItem(
          type: 'action_add_measurement',
          localizedTitle: AppLocalizations.of(context).translate("addValue"),
          icon: 'splash'),
      ShortcutItem(
          type: 'action_settings',
          localizedTitle: AppLocalizations.of(context).translate("settings"),
          icon: 'splash'),
    ]);
  }

  void _handleQuickActions() {
    quickActions.initialize((String shortcutType) {
      BottomBar.currentIndex = 2;

      if (shortcutType == 'action_add_measurement') {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => AddRecord()));
      } else if (shortcutType == 'action_history') {
        BottomBar.currentIndex = 1;

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => History()));
      } else if (shortcutType == 'action_settings') {
        BottomBar.currentIndex = 3;

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => History()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
