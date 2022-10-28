import 'package:flutter/material.dart';

import '../models/recipe.dart';
import '../widgets/main_drawer.dart';
import 'categories_screen.dart';
import 'favourites_screen.dart';

class TabsScreen extends StatefulWidget {
  final List<Recipe> favouriteRecipes;
  const TabsScreen(this.favouriteRecipes);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages = [];
  int _selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pages = [
      {
        'page': CategoriesScreen(),
        'title': Text('Categories'),
      },
      {
        'page': FavouritesScreen(widget.favouriteRecipes),
        'title': Text('Favourites'),
      },
    ];
  }

  void _selectPage(int index) {
    setState(() => _selectedPageIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _pages[_selectedPageIndex]['title'] as Widget,
      ),
      drawer: MainDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.category,
            ),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star,
            ),
            label: 'Favourites',
          ),
        ],
      ),
      body: _pages[_selectedPageIndex]['page'] as Widget,
    );
  }
}
