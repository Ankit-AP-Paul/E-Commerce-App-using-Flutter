import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({super.key});

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text(
                'Hindol Banerjee',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(
                'hbs69@example.com',
                style: TextStyle(fontSize: 16),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/profile_picture.png'),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text(
                'Home',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text(
                'All Categories',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.shopping_basket),
              title: const Text(
                'My Orders',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text(
                'My Cart',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text(
                'Favorites',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text(
                'About Us',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text(
                'Logout',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
