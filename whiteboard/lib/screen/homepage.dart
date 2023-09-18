import 'package:flutter/services.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';

import '../rwd/responsive.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with Responsive {
  final data = [1, 2, 3, 4, 5, 6];
  late Responsive responsive;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    Widget buildItem(String text) {
      return Card(
        key: ValueKey(text),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Text(text),
      );
    }

    return Scaffold(
        drawer: drawerWidget(context),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            //  Positioned(
            //   top: 20.0,
            //   left: isMobile(context) ? width/ : 50.0,
            //   child: const Text("Drag and drop to reorder the list"),
            // ),
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Center(
                    child: Text('Whiteboard notes',
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.bold)),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 20.0),
                    child: ReorderableGridView.count(
                      onDragStart: (dragIndex) => print("drag start$dragIndex"),
                      dragEnabled: true,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: Responsive.isMobile(context) ? 2 : 3,
                      onReorder: (oldIndex, newIndex) {
                        setState(() {
                          final element = data.removeAt(oldIndex);
                          data.insert(newIndex, element);
                        });
                      },
                      // footer: const [
                      //   Card(
                      //     child: Center(
                      //       child: Icon(Icons.add),
                      //     ),
                      //   ),
                      // ],
                      children: data.map((e) => buildItem("$e")).toList(),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 16.0,
              right: 16.0,
              child:
                  // FloatingActionButton(
                  //   onPressed: () {
                  //     setState(() {
                  //       data.add(data.length + 1);
                  //     });
                  //   },
                  //   child: const Icon(Icons.add),
                  // ),
                  FloatingActionButton(
                onPressed: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => EditPage(
                  //           onNoteCreated: onNoteCreated,
                  //         )));
                },
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ));
  }

  drawerWidget(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.height * 1;
    return Drawer(
      width: 275,
      elevation: 30,
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(right: Radius.circular(40))),
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.horizontal(right: Radius.circular(40)),
            boxShadow: [
              BoxShadow(
                  color: Color(0x3D000000), spreadRadius: 30, blurRadius: 20)
            ]),
        child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: drawerContent(context)),
      ),
    );
  }
}

drawerContent(BuildContext context) {
  return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios),
              color: const Color.fromARGB(255, 29, 33, 52),
              iconSize: 20,
            ),
            const SizedBox(
              width: 56,
            ),
            const Text(
              'whiteboard',
              style: TextStyle(
                  color: Color.fromARGB(255, 29, 33, 52),
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          children: const [
            UserAvatar(
              filename: 'google.png',
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              'account',
              style: TextStyle(
                  color: Color.fromARGB(255, 29, 33, 52), fontSize: 18),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'name',
              style: TextStyle(
                  color: Color.fromARGB(255, 29, 33, 52), fontSize: 18),
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        const Divider(
          height: 35,
          color: Color.fromARGB(255, 29, 33, 52),
          thickness: 1.5,
        ),
        const SizedBox(
          height: 15,
        ),
        const DrawerItem(
          title: '帳號',
          icon: Icons.key,
        ),
        DrawerItem(
          title: '關於此APP',
          icon: Icons.help_outline,
          onTap: () {
            // showDialogBox(context,
            //     '');
          },
        ),
        DrawerItem(
          title: '聯絡開發者',
          icon: Icons.help,
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    insetPadding: const EdgeInsets.all(5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    title: SafeArea(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Center(
                              child: Text(
                                '聯絡作者(點擊)',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Clipboard.setData(
                                        const ClipboardData(
                                            text: 'XNORGATE#3514'),
                                      );
                                    },
                                    icon:
                                        const FaIcon(FontAwesomeIcons.discord),
                                  ),
                                  const Text('Discord: XNORGATE#3514'),
                                ]),
                            Row(children: [
                              IconButton(
                                onPressed: () {
                                  Clipboard.setData(
                                    const ClipboardData(
                                        text: 'tsaidarius@gmail.com'),
                                  );
                                },
                                icon: const FaIcon(FontAwesomeIcons.envelope),
                              ),
                              const Text('Gmail: tsaidarius@gmail.com'),
                            ]),
                          ]),
                    )
                    // content:
                    );
              },
            );
          },
        ),
      ],
    ),
    DrawerItem(
      title: '登出',
      icon: Icons.logout,
      onTap: () async {
        final confirmed = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: const Text(
              '登出',
              style: TextStyle(color: Colors.black),
            ),
            content: const Text('確定要登出 ?'),
            actions: [
              NeumorphicButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('取消'),
              ),
              NeumorphicButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('確認'),
              ),
            ],
          ),
        );
        if (confirmed == true) {
          // // Navigate to login page
          //                     // ignore: use_build_context_synchronously
          //                     Navigator.pushNamedAndRemoveUntil(
          //                         context, LoginPage.routeName, (route) => false);
        }
      },
    ),
  ]);
}

class DrawerItem extends StatelessWidget {
  final Function()? onTap;

  final String title;
  final IconData icon;
  const DrawerItem({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color.fromARGB(255, 29, 33, 52),
              size: 20,
            ),
            const SizedBox(
              width: 40,
            ),
            Text(
              title,
              style: const TextStyle(
                  color: Color.fromARGB(255, 29, 33, 52),
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class UserAvatar extends StatelessWidget {
  final String filename;
  const UserAvatar({
    super.key,
    required this.filename,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 32,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: 29,
        backgroundImage: Image.asset('assets/$filename').image,
      ),
    );
  }
}
