import 'dart:convert';
import 'package:hikebite/models/food.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hikebite/utils/auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'food_provider.g.dart';

@riverpod
class FoodList extends _$FoodList {
  @override
  Future<List<Food>> build() async {
    final firebaseAuth = ref.watch(firebaseAuthProvider);
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    final food = await firestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("food")
        .withConverter(
          fromFirestore: (snapshot, _) => Food.fromJson(snapshot.data()!),
          toFirestore: (food, _) => food.toJson(),
        )
        .get();

    List<Food> foodList = List.empty(growable: true);
    for (var f in food.docs) {
      foodList.add(f.data());
    }

    return foodList;
  }

  Future<void> addFood(Food food) async {
    final firebaseAuth = ref.watch(firebaseAuthProvider);
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    await firestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("food")
        .withConverter(
          fromFirestore: (snapshot, _) => Food.fromJson(snapshot.data()!),
          toFirestore: (food, _) => food.toJson(),
        )
        .add(food);

    ref.invalidateSelf();

    await future;
  }
}
