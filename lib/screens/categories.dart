import 'package:flutter/material.dart';
import '/models/meal.dart';
import '/models/category.dart';
import '/screens/meals.dart';
import '/widgets/category_grid_item.dart';
import '/data/dummy_data.dart';

class CategoriesScreen extends StatefulWidget {
  CategoriesScreen({
    super.key,
    //required this.onToggleFavorie,
    required this.availableMeals,
  });

  //final void Function(Meal meal) onToggleFavorie;
  List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    //final filteredMeals = dummyMeals - now use available meals
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    // Navigator.of(context).push(route);  // Naa=vigator.push(context, route)
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
          //onToggleFavorie: onToggleFavorie,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('Pick your category'),
    //   ),
    //   body: GridView(
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        padding: EdgeInsets.all(24),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        children: [
          // availableCategories.map((category) => CategoryGridItem(category: category)).toList();
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            )
        ],
      ),
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: Offset(0, 0.3),
          end: Offset(0, 0),
        ).animate(
          CurvedAnimation(
              parent: _animationController, curve: Curves.easeInOut),
        ),
        child: child,
      ),
      /*
      builder: (context, child) => SlideTransition(
        position: _animationController.drive(
          Tween(
            begin: Offset(0, 0.3),
            end: Offset(0, 0),
          ),
        ),
        child: child,
      ),
     
      builder: (context, child) => Padding(
        padding: EdgeInsets.only(top: 100 - _animationController.value * 100),
        child: child,
      ),
      */
    );
    // );
  }
}
