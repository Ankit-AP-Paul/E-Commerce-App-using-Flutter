import 'package:e_commerce_app/drawerMenu.dart';
import 'package:e_commerce_app/swipeUpWidget.dart';
import 'package:flutter/material.dart';
import 'bottomNavigationBar.dart';
// import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

ValueNotifier<int> navIndex = ValueNotifier<int>(0);

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text(
          'MyStore.com',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      drawer: const DrawerMenu(),
      body: Stack(children: [
        ListView(
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
          children: const [
            Text(
              'Sales !!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SwipeUpContainer()
      ]),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
