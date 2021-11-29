import 'package:app/src/design/theme/theme_data.dart';
import 'package:app/src/design/widgets/drawer.dart';
import 'package:app/src/design/components/text_century.dart';
import 'package:app/src/routes/local_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AdvancedDrawerController drawerCtrl = AdvancedDrawerController();
  late PageController pageCtrl;

  late Size media;

  String title = LocalData.list_menu[0];

  @override
  void initState() {
    pageCtrl = PageController(initialPage: 0)
      ..addListener(() {
        int val = pageCtrl.page!.toInt();
        setState(() {
          title = LocalData.list_menu[val];
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: Colored.primary,
      controller: drawerCtrl,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: NavDrawer(pageCtrl, drawerCtrl),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            backgroundColor: Colored.dark,
            title: Container(
              width: Window(context).w(100),
              height: 30,
              child: TCentury(
                title,
                aling: TextAlign.left,
              ),
            ),
            leading: IconButton(
              onPressed: _handleHomePageButtonPressed,
              icon: ValueListenableBuilder<AdvancedDrawerValue>(
                valueListenable: drawerCtrl,
                builder: (_, value, __) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: Icon(
                      value.visible ? Icons.clear : Icons.menu,
                      key: ValueKey<bool>(value.visible),
                    ),
                  );
                },
              ),
            )),
        body: PageView.builder(
            scrollDirection: Axis.horizontal,
            controller: pageCtrl,
            itemCount: LocalData.list_menu.length,
            itemBuilder: (context, i) {
              return LocalData.widget[i];
            }),
      ),
    );
  }

  void _handleHomePageButtonPressed() {
    drawerCtrl.showDrawer();
  }
}
