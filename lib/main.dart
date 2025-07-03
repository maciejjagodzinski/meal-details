import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrient_details/screens/product_details_screen.dart';

void main() => runApp(const ProviderScope(child: MaterialApp(home: ProductDetailsScreen())));
