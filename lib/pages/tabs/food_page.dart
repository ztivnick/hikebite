import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hikebite/models/food.dart';
import 'package:hikebite/pages/create_food.dart';
import 'package:hikebite/providers/food_provider.dart';

class FoodList extends StatelessWidget {
  final List<Food> foodList;

  const FoodList({Key? key, required this.foodList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: foodList.length,
      itemBuilder: ((context, index) {
        final food = foodList[index];
        return ListTile(
          title: Text(food.name),
          subtitle: Text('${food.calories} calories'),
        );
      }),
    );
  }
}

/// The homepage of our application
class FoodPage extends StatelessWidget {
  const FoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final AsyncValue<List<Food>> foodList = ref.watch(foodListProvider);

        return Center(
          child: foodList.when(
            data: (foodList) => Column(
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateFood()),
                  ),
                  child: const Text("Add New Food"),
                ),
                Expanded(child: FoodList(foodList: foodList))
              ],
            ),
            loading: () => const CircularProgressIndicator(),
            error: (error, stack) =>
                const Text('Oops, something unexpected happened'),
          ),
        );
      },
    );
  }
}
