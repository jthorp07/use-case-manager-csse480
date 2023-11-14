import 'package:flutter/material.dart';
import 'package:use_case_manager/components/color_scheme.dart';
import 'package:use_case_manager/components/ucm_appbar.dart';
import 'package:use_case_manager/components/ucm_drawer.dart';
import 'package:use_case_manager/managers/auth_manager.dart';

class PageOutline extends StatefulWidget {
  final Widget child;
  const PageOutline({super.key, required this.child});

  @override
  State<PageOutline> createState() => _PageOutlineState();
}

class _PageOutlineState extends State<PageOutline> {
  UniqueKey? _loginUniqueKey;
  UniqueKey? _logoutUniqueKey;
  @override
  void initState() {
    super.initState();
    _loginUniqueKey = AuthManager.instance.addLoginObserver(() {
      debugPrint("Called my login observer");
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.of(context).popAndPushNamed("landing/chooseLogin");
    });
    _logoutUniqueKey = AuthManager.instance.addLogoutObserver(() {
      debugPrint("Called my logout observer");
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.of(context).popAndPushNamed("landing/chooseLogin");
    });
  }

  @override
  void dispose() {
    AuthManager.instance.removeObserver(_loginUniqueKey);
    AuthManager.instance.removeObserver(_logoutUniqueKey);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ucmAppBar(MediaQuery.of(context).size.width -
          MediaQuery.of(context).viewPadding.horizontal),
      body: SizedBox(
        width: MediaQuery.of(context).size.width -
            MediaQuery.of(context).viewPadding.horizontal,
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).viewPadding.top,
        child: widget.child,
      ),
      backgroundColor: UCMColorScheme.lightGray,
      drawer: UCMDrawer(navigateHome: () {}, navigateToProject: () {}),
    );
  }
}
