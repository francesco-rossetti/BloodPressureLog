import 'package:bloodpressurelog/components/bottom_bar.dart';
import 'package:bloodpressurelog/domain/lang/app_localization.dart';
import 'package:flutter/material.dart';

class Page extends StatefulWidget {
  final String? name;
  final bool showBottomBar;
  final List<Widget>? appBarActions;
  final Widget body;

  const Page(
      {Key? key,
      this.name,
      this.appBarActions,
      required this.showBottomBar,
      required this.body})
      : super(key: key);

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(AppLocalizations.of(context)!
              .translate(widget.name ?? "appName")!),
          actions: widget.appBarActions),
      body: widget.body,
      bottomNavigationBar: widget.showBottomBar ? const BottomBar() : null,
    );
  }
}
