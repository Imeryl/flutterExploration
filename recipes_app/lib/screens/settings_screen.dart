import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _vegan = false;
  bool _vegetarian = false;

  SwitchListTile _buildSwitch(
      bool value, String text, Function(bool) updateValue) {
    return SwitchListTile(
      onChanged: updateValue,
      title: Text(text),
      value: value,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Padding(
            child: Text('Adjust your meal selection.'),
            padding: EdgeInsets.all(20),
          ),
          Expanded(
            child: ListView(children: <Widget>[
              _buildSwitch(_glutenFree, 'Gluten free',
                  (newValue) => setState(() => _glutenFree = newValue)),
              _buildSwitch(_lactoseFree, 'Lactose free',
                  (newValue) => setState(() => _lactoseFree = newValue)),
              _buildSwitch(_vegan, 'Vegan',
                  (newValue) => setState(() => _vegan = newValue)),
              _buildSwitch(_vegetarian, 'Vegetarian',
                  (newValue) => setState(() => _vegetarian = newValue)),
            ]),
          ),
        ],
      ),
    );
  }
}
