import 'package:bloodpressurelog/components/bottom_bar.dart';
import 'package:bloodpressurelog/pages/add_record.dart';
import 'package:bloodpressurelog/pages/history.dart';
import 'package:bloodpressurelog/pages/settings.dart';
import 'package:bloodpressurelog/domain/lang/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:quick_actions/quick_actions.dart';

class QuickActionsManager extends StatefulWidget {
  final Widget child;
  const QuickActionsManager({Key? key, required this.child}) : super(key: key);

  @override
  QuickActionsManagerState createState() => QuickActionsManagerState();
}

class QuickActionsManagerState extends State<QuickActionsManager> {
  final QuickActions quickActions = const QuickActions();

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
          localizedTitle: AppLocalizations.of(context)!.translate("home")!,
          icon: 'splash'),
      ShortcutItem(
          type: 'action_history',
          localizedTitle:
              AppLocalizations.of(context)!.translate("historyValues")!,
          icon: 'splash'),
      ShortcutItem(
          type: 'action_add_measurement',
          localizedTitle: AppLocalizations.of(context)!.translate("addValue")!,
          icon: 'splash'),
      ShortcutItem(
          type: 'action_settings',
          localizedTitle: AppLocalizations.of(context)!.translate("settings")!,
          icon: 'splash'),
    ]);
  }

  void _handleQuickActions() {
    quickActions.initialize((String shortcutType) {
      BottomBar.currentIndex = 2;

      if (shortcutType == 'action_add_measurement') {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const AddRecordPage()));
      } else if (shortcutType == 'action_history') {
        BottomBar.currentIndex = 1;

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HistoryPage()));
      } else if (shortcutType == 'action_settings') {
        BottomBar.currentIndex = 3;

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const SettingsPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
