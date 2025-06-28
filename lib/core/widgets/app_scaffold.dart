import 'package:flutter/material.dart';

class SafeAreaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final PreferredSizeWidget appBar;

  const SafeAreaAppBar({super.key, required this.appBar});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: appBar);
  }

  @override
  Size get preferredSize => appBar.preferredSize;
}

class AppScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final bool? resizeToAvoidBottomInset;
  final bool extendBody;
  final bool extendBodyBehindAppBar;

  const AppScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      appBar: appBar != null ? SafeAreaAppBar(appBar: appBar!) : null,
      body: appBar == null ? SafeArea(child: body) : body,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
    );
  }
}
