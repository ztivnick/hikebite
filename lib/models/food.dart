import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'food.freezed.dart';
part 'food.g.dart';

enum FoodCategory {
  @JsonKey(name: 'breakfast')
  breakfast("Breakfast"),
  @JsonKey(name: 'lunch')
  lunch("Lunch"),
  @JsonKey(name: 'dinner')
  dinner("Dinner"),
  @JsonKey(name: 'snack')
  snack("Snack");

  const FoodCategory(this.categoryName);
  final String categoryName;
}

@freezed
class Food with _$Food {
  const factory Food({
    required String name,
    required double calories,
    required double weight,
    required FoodCategory category,
  }) = _Food;

  factory Food.fromJson(Map<String, Object?> json) => _$FoodFromJson(json);
}
