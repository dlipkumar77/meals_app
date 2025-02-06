// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/providers/filters_provider.dart';
import '/providers/favorites_provider.dart';
import '/providers/meals_provider.dart';
//import '/data/dummy_data.dart';
import '/screens/filters.dart';
import '/widgets/main_drawer.dart';
//import '/models/meal.dart';
import '/screens/categories.dart';
import '/screens/meals.dart';

/*

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};
*/
class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});
  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int selectPageIndex = 0;
  //final List<Meal> _favoriteMeals = [];

  //Map<Filter, bool> _selectedFilters = kInitialFilters;
/*
  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  

  void _toggleMealFavoriteStatus(Meal meal) {
    var isExisting = _favoriteMeals.contains(meal);

    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showInfoMessage('Meal is no longer favorite.');
    } else {
      setState(() {
        _favoriteMeals.add(meal);
        _showInfoMessage('Marked as a favorite');
      });
    }
  }

  */

  void _selectPage(index) {
    setState(() {
      selectPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context)
        .pop(); // back button press  drawer open so this way solve that bug
    if (identifier == 'filters') {
      //pushReplacement is avoid back press
      // after fliter enum push is future value get
      //final result = await Navigator.of(context).push<Map<Filter, bool>>(
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
              //currentFilter: _selectedFilters,
              ),
        ),
      );

      /*
      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });

      */

      // print(result);
    }
    //  else {
    //   Navigator.of(context).pop();
    // }
  }

  @override
  Widget build(BuildContext context) {
    final avilabelMeals = ref.watch(fiteredMealsProvider);

    Widget activePage = CategoriesScreen(
      // onToggleFavorie: _toggleMealFavoriteStatus,
      availableMeals: avilabelMeals,
    );
    var activePageTitle = 'Categories';
    if (selectPageIndex == 1) {
      final favoritesMeal = ref.watch(favoriteMealProvider);
      activePage = MealsScreen(
        // title: 'Favorites', not set title because scaffold two times uses avoid home page
        meals: favoritesMeal,
        //onToggleFavorie: _toggleMealFavoriteStatus,
      );
      activePageTitle = 'Your Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        //onTap: (index) {},
        onTap: _selectPage,
        currentIndex: selectPageIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
