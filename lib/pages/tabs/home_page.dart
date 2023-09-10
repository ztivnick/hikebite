import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hikebite/models/food.dart';
import 'package:hikebite/utils/auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authStateChangesProvider);

    return Center(
      child: user.when(
        data: (user) {
          return Column(children: [
            Text('Welcome ${user!.email!}'),
            ElevatedButton(
              onPressed: () async {
                // Test fetching existing food setups
                FirebaseFirestore foodSetupsCollection =
                    FirebaseFirestore.instance;
                await foodSetupsCollection
                    .collection("users")
                    .doc(user.uid)
                    .collection("foodSetups")
                    .get()
                    .then((event) {
                  for (var doc in event.docs) {
                    print("doc ${doc.id} + user ${user.uid} => ${doc.data()}");
                  }
                });

                // Test setting new food
                const appleFood = Food(
                  name: "Apple",
                  calories: 95,
                  weight: 4,
                  category: FoodCategory.snack,
                );

                final collection = FirebaseFirestore.instance
                    .collection("users")
                    .doc(user.uid)
                    .collection("food")
                    .withConverter(
                      fromFirestore: (snapshot, _) =>
                          Food.fromJson(snapshot.data()!),
                      toFirestore: (food, _) => food.toJson(),
                    );

                await collection
                    .where("name", isEqualTo: "Apple")
                    .get()
                    .then((apples) {
                  for (var apple in apples.docs) {
                    collection.doc(apple.id).delete();
                  }
                });

                collection.add(appleFood);
                collection.get().then((event) {
                  for (var doc in event.docs) {
                    print("doc ${doc.id} + user ${user.uid} => ${doc.data()}");
                  }
                });
              },
              child: const Text("firestore test"),
            )
          ]);
        },
        error: (e, s) => Text('Error $e with sign in'),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}
