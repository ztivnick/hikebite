import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hikebite/models/food.dart';
import 'package:hikebite/providers/food_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateFood extends ConsumerStatefulWidget {
  const CreateFood({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateFoodState();
}

class _CreateFoodState extends ConsumerState<CreateFood> {
  Future<void>? _pendingAddFood;

  final _formKey = GlobalKey<FormState>();
  final foodNameController = TextEditingController();
  final foodCaloriesController = TextEditingController();
  final foodWeightController = TextEditingController();

  @override
  void dispose() {
    foodNameController.dispose();
    foodCaloriesController.dispose();
    foodWeightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: _pendingAddFood,
          builder: (context, snapshot) {
            final isErrored = snapshot.hasError &&
                snapshot.connectionState != ConnectionState.waiting;

            return Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: foodNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter a food name';
                        }
                        return null;
                      },
                    ),
                    (snapshot.connectionState == ConnectionState.waiting)
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                isErrored ? Colors.red : null,
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final future = ref
                                    .read(foodListProvider.notifier)
                                    .addFood(
                                      Food(
                                        name: foodNameController.text,
                                        calories: 1,
                                        weight: 1,
                                        category: FoodCategory.breakfast,
                                      ),
                                    )
                                    .then((_) => Navigator.pop(context));

                                setState(() {
                                  _pendingAddFood = future;
                                });
                              }
                            },
                            child: const Text('Add Food'),
                          ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
