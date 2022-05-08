import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:temp1/utility/common_function.dart';

class AddIngredients extends ChangeNotifier {
  final ingredients = <int>[];
  void addIngredients(int index) {
    for (int i = 0; i < ingredients.length; i++) {
      if (ingredients[i] == index) {
        showToast("Already added");
      } else {
        ingredients.add(index);
        showToast("Added");
      }
    }
  }

  void removeIngredients(int index) {
    ingredients.remove(index);
    notifyListeners();
  }
}

final todosProvider = ChangeNotifierProvider<AddIngredients>((ref) {
  return AddIngredients();
});
