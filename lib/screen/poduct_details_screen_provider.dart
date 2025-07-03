import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrient_details/models/models.dart';

final selectedIndexProvider = StateProvider<int>((ref) => 0);

final productDetailsProvider = Provider<ProductDetails>((ref) {
  return ProductDetails(
    title: 'Kanapka z wege szarpaną kaczką',
    description:
        'Odkryj nowy wymiar smaku z kanapką z wege szarpaną kaczką – idealnym połączeniem soczystej, roślinnej alternatywy i chrupiącego pieczywa. Każdy kęs to harmonia przypraw, świeżych dodatków i zaskakująco autentycznego smaku, który zachwyci nie tylko wegetarian.',
    ingredients: 'Chrupiące pieczywo, wegańska szarpana kaczka, świeża sałata, ogórek, pomidor, sos barbecue wegański',
    allergens: ['Pszenica', 'Gluten', 'Mleko'],
    options: [
      ProductOption(
        sizeName: 'Rozmiar S',
        nutrition: Nutrition(calories: 430, proteins: 45, carbs: 55, fat: 18),
      ),
      ProductOption(
        sizeName: 'Rozmiar M',
        nutrition: Nutrition(calories: 607, proteins: 57, carbs: 68, fat: 27),
      ),
      ProductOption(
        sizeName: 'Rozmiar L',
        nutrition: Nutrition(calories: 730, proteins: 65, carbs: 80, fat: 35),
      ),
    ],
  );
});

const double mealCaloriesMax = 1000.0;
