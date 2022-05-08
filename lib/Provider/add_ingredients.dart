import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temp1/utility/common_function.dart';

class AddIngredients extends ChangeNotifier {
  final ingredients = <String>[];

  void printAll() {
    print(ingredients);
  }

  void clear() {
    ingredients.clear();
    notifyListeners();
  }

  void addIngredients(String ingredient) {
    if (ingredients.isEmpty) {
      ingredients.add(ingredient);
      notifyListeners();
    } else {
      for (int i = 0; i < ingredients.length; i++) {
        if (ingredients[i] == ingredient) {
          showToast("Already added");
          return;
        }
      }
      ingredients.add(ingredient);
      showToast("Added");
      notifyListeners();
    }
  }

  void removeIngredients(String ingredient) {
    ingredients.remove(ingredient);
    notifyListeners();
  }
}

final addIngredientProvider = ChangeNotifierProvider<AddIngredients>((ref) {
  return AddIngredients();
});
