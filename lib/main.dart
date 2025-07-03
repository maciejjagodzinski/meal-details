import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrient_details/screen/product_details_screen.dart';

void main() => runApp(const ProviderScope(
        child: MaterialApp(
      home: ProductDetailsScreen(),
      debugShowCheckedModeBanner: false,
    )));
