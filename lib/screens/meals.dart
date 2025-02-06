import 'package:flutter/material.dart';
import 'package:meals_app/screens/meal_details.dart';
import '/widgets/meal_item.dart';
import '/models/meal.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
    //required this.onToggleFavorie,
  });
  //const MealsScreen({super.key, required this.title, required this.meals});
  //final String title; // scafold hide so new code & required remove in title
  final String? title;
  final List<Meal> meals;
  //final void Function(Meal meal) onToggleFavorie;
  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
          meal: meal,
          // onToggleFavorie: onToggleFavorie,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Uh oh ... nothing here',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Try selecting different category',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          )
        ],
      ),
    );

    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length,
        //itemBuilder: (ctx, index) => Text(meals[index].title), // testing purpose
        //itemBuilder: (ctx, index) => MealItem(meal: meals[index], onSelectMeal: selectMeal,));
        itemBuilder: (ctx, index) => MealItem(
          meal: meals[index],
          onSelectMeal: (context, meal) {
            selectMeal(context, meal);
          },
        ),
      );
    }

    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
