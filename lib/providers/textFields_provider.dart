import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider for ingredient text fields
class IngredientProvider extends Notifier<List<TextEditingController>> {
  @override
  List<TextEditingController> build() {
    return [TextEditingController()];
  }

  void addContoller(TextEditingController newController) {
    state = [...state, newController];
  }
}

var ingredientNotifierProvider =
    NotifierProvider<IngredientProvider, List<TextEditingController>>(
        IngredientProvider.new);

// Provider for step text fields
class StepProvider extends Notifier<List<TextEditingController>> {
  @override
  List<TextEditingController> build() {
    return [TextEditingController()];
  }

  void addContoller(TextEditingController newController) {
    state = [...state, newController];
  }
}

var stepNotifierProvider =
    NotifierProvider<StepProvider, List<TextEditingController>>(
        StepProvider.new);
