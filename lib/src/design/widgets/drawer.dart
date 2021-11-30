import 'package:app/src/design/theme/theme_data.dart';
import 'package:app/src/routes/local_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

import 'components.dart';

class NavDrawer extends StatefulWidget {
  final PageController pageCtrl;
  final AdvancedDrawerController drawerCtrl;
  const NavDrawer(this.pageCtrl, this.drawerCtrl, {Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  late PageController pageCtrl;
  int val = 0;
  @override
  void initState() {
    pageCtrl = widget.pageCtrl;
    pageCtrl.addListener(() {
      setState(() {
        val = pageCtrl.page!.toInt();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: Window(context).w(50),
          ),
          Container(
            width: double.infinity,
            height: Window(context).w(100),
            child: ListView.builder(
                itemCount: LocalData.list_menu.length,
                itemBuilder: (context, i) {
                  return ListTile(
                      tileColor: val == i ? Colored.dark : Colored.primary,
                      title: TCentury(LocalData.list_menu[i]),
                      leading: Icon(Icons.home, color: Colors.white),
                      onTap: () => goPage(i));
                }),
          ),
        ],
      ),
    );
  }

  void goPage(index) {
    widget.drawerCtrl.hideDrawer();
    widget.pageCtrl.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}
