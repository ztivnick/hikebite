import 'dart:convert';
import 'package:hikebite/models/food.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hikebite/utils/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'food_provider.g.dart';

@riverpod
Future<List<Food>> foodList(FoodListRef ref) async {
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
