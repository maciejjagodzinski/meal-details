class ProductOption {
  final String sizeName;
  final Nutrition nutrition;

  ProductOption({
    required this.sizeName,
    required this.nutrition,
  });
}

class Nutrition {
  final int calories;
  final int proteins;
  final int carbs;
  final int fat;

  const Nutrition({
    required this.calories,
    required this.proteins,
    required this.carbs,
    required this.fat,
  });
}

class ProductDetails {
  final String title;
  final String description;
  final List<ProductOption> options;
  final String ingredients;
  final List<String> allergens;

  ProductDetails({
    required this.title,
    required this.description,
    required this.options,
    required this.ingredients,
    required this.allergens,
  });
}

enum NutrientType {
  calories,
  proteins,
  carbs,
  fat,
}

extension NutrientTypeExtension on NutrientType {
  String get label {
    switch (this) {
      case NutrientType.calories:
        return 'Calories';
      case NutrientType.proteins:
        return 'Proteins';
      case NutrientType.carbs:
        return 'Carbs';
      case NutrientType.fat:
        return 'Fat';
    }
  }

  String get unit {
    switch (this) {
      case NutrientType.calories:
        return 'kcal';
      case NutrientType.proteins:
      case NutrientType.carbs:
      case NutrientType.fat:
        return 'g';
    }
  }
}
