import 'package:flutter/material.dart';

import '../screens/settings_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 80,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(20),
            child: Text(
              'Heading',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Icon(
              Icons.restaurant,
              size: 24,
            ),
            onTap: () => Navigator.of(context).pushReplacementNamed('/'),
            title: Text('Recipes'),
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              size: 24,
            ),
            onTap: () => Navigator.of(context).pushReplacementNamed(
              SettingsScreen.routeName,
            ),
            title: Text('Settings'),
          ),
        ],
      ),
    );
  }
}
