import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nutrient_details/models/models.dart';
import 'package:nutrient_details/screens/poduct_details_screen_provider.dart';
import 'package:nutrient_details/theme/app_colors.dart';
import 'package:nutrient_details/theme/app_text_styles.dart';
import 'package:soft_edge_blur/soft_edge_blur.dart';

class ProductDetailsScreen extends ConsumerWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Szczegóły posiłku',
            style: AppTextStyles.medium12.copyWith(
              color: AppColors.primaryWhite,
            )),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryWhite),
          onPressed: () {},
        ),
      ),
      body: SafeArea(
        top: false,
        child: Stack(children: [
          HeroImage(),
          MealDetailsInfo(),
        ]),
      ),
    );
  }
}

class MealDetailsInfo extends ConsumerWidget {
  const MealDetailsInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(productDetailsProvider);
    final selectedIndex = ref.watch(selectedIndexProvider);
    final selectedOption = product.options[selectedIndex];
    final totalNutrients =
        selectedOption.nutrition.proteins + selectedOption.nutrition.carbs + selectedOption.nutrition.fat;
    final proteinsRatio = selectedOption.nutrition.proteins / totalNutrients;
    final carbsRatio = selectedOption.nutrition.carbs / totalNutrients;
    final fatsRatio = selectedOption.nutrition.fat / totalNutrients;

    return Align(
      alignment: Alignment.bottomCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.65,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 32, sigmaY: 32),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.72),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 20,
                    spreadRadius: -10,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.title, style: AppTextStyles.headlineSemiBold),
                      const SizedBox(height: 12),
                      Text(product.description,
                          style: AppTextStyles.bodyRegular.copyWith(color: AppColors.textSecondary)),
                      const SizedBox(height: 32),
                      Row(
                        spacing: 8,
                        children: List.generate(product.options.length, (i) {
                          final option = product.options[i];
                          return _SizeChip(
                            label: option.sizeName,
                            selected: i == selectedIndex,
                            onSelected: (_) {
                              ref.read(selectedIndexProvider.notifier).state = i;
                            },
                          );
                        }),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        spacing: 8,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: _NutrientWidget(
                                nutrientColor: AppColors.primaryBlack,
                                label: NutrientType.calories.label,
                                value: '${selectedOption.nutrition.calories} ${NutrientType.calories.unit}',
                                nutrientHeight: min(selectedOption.nutrition.calories / mealCaloriesMax * 112, 90)),
                          ),
                          Expanded(
                            child: _NutrientWidget(
                                nutrientColor: Color(0xFF2EA6D9),
                                label: NutrientType.proteins.label,
                                value: '${selectedOption.nutrition.proteins} ${NutrientType.proteins.unit}',
                                nutrientHeight: proteinsRatio * 112),
                          ),
                          Expanded(
                            child: _NutrientWidget(
                                nutrientColor: Color(0xFFE79A42),
                                label: NutrientType.carbs.label,
                                value: '${selectedOption.nutrition.carbs} ${NutrientType.carbs.unit}',
                                nutrientHeight: carbsRatio * 112),
                          ),
                          Expanded(
                            child: _NutrientWidget(
                                nutrientColor: Color(0xFFE7C747),
                                label: NutrientType.fat.label,
                                value: '${selectedOption.nutrition.fat} ${NutrientType.fat.unit}',
                                nutrientHeight: fatsRatio * 112),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Text('Składniki',
                          style: AppTextStyles.headlineSemiBold.copyWith(
                            height: 1.3,
                          )),
                      const SizedBox(height: 8),
                      Text(product.ingredients,
                          style: AppTextStyles.regular14.copyWith(
                            height: 1.5,
                            letterSpacing: 0.01,
                          )),
                      const SizedBox(height: 32),
                      Text('Alergeny',
                          style: AppTextStyles.headlineSemiBold.copyWith(
                            height: 1.3,
                          )),
                      const SizedBox(height: 12),
                      Row(
                        spacing: 8,
                        children: product.allergens.map((e) => AllergenWidget(allergen: e)).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AllergenWidget extends StatelessWidget {
  const AllergenWidget({super.key, required this.allergen});
  final String allergen;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4,
      children: [
        _buildAllergenIcon(allergen),
        Text(allergen, style: AppTextStyles.medium14),
      ],
    );
  }

  Widget _buildAllergenIcon(String allergen) {
    switch (allergen) {
      case 'Gluten':
        return SvgPicture.asset('assets/icons/gluten_icon.svg', width: 16, height: 16);
      case 'Mleko':
        return SvgPicture.asset('assets/icons/milk_icon.svg', width: 16, height: 16);
      case 'Pszenica':
        return SvgPicture.asset('assets/icons/grain_icon.svg', width: 16, height: 16);
      default:
        return SvgPicture.asset('assets/icons/grain_icon.svg', width: 16, height: 16);
    }
  }
}

class _SizeChip extends StatefulWidget {
  const _SizeChip({required this.label, required this.selected, required this.onSelected});
  final String label;
  final bool selected;
  final Function(bool) onSelected;

  @override
  State<_SizeChip> createState() => _SizeChipState();
}

class _SizeChipState extends State<_SizeChip> {
  double _scale = 1.0;
  double _elevation = 0.0;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _scale = 0.8;
      _elevation = 8.0;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _scale = 1.0;
      _elevation = 0.0;
    });
  }

  void _onTapCancel() {
    setState(() {
      _scale = 1.0;
      _elevation = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onSelected(true),
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        child: AnimatedPhysicalModel(
          duration: const Duration(milliseconds: 100),
          shape: BoxShape.rectangle,
          elevation: _elevation,
          color: Colors.transparent,
          shadowColor: Colors.black,
          borderRadius: BorderRadius.circular(20),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              splashColor: AppColors.primaryBlack.withValues(alpha: 0.1),
              highlightColor: AppColors.primaryBlack.withValues(alpha: 0.1),
              onTap: () => widget.onSelected(true),
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Color(0xFFDDDDDD), width: 1),
                  color: widget.selected ? null : AppColors.primaryWhite,
                  gradient: widget.selected
                      ? const LinearGradient(
                          colors: [
                            Color(0xFFADC057),
                            Color(0xFF8BBD60),
                            Color(0xFF7EBC49),
                            Color(0xFF6CA936),
                            Color(0xFF5F9F26),
                          ],
                          stops: [0.0, 0.25, 0.5, 0.75, 1.0],
                        )
                      : null,
                ),
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.center,
                  child: Text(
                    widget.label,
                    style: AppTextStyles.medium14.copyWith(
                      color: widget.selected ? AppColors.primaryWhite : AppColors.primaryBlack,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HeroImage extends StatelessWidget {
  const HeroImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SoftEdgeBlur(
        edges: [
          EdgeBlur(
            type: EdgeType.topEdge,
            size: 100,
            sigma: 10,
            controlPoints: [
              ControlPoint(position: 0.0, type: ControlPointType.visible),
              ControlPoint(position: 0.8, type: ControlPointType.visible),
              ControlPoint(position: 1.0, type: ControlPointType.transparent),
            ],
          ),
        ],
        child: ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF5D5D5D),
                Color(0x005D5D5D),
              ],
              stops: [0.0, 0.25],
            ).createShader(rect);
          },
          blendMode: BlendMode.multiply,
          child: SizedBox(
            width: double.infinity,
            child: Image.asset(
              'assets/images/header_hero.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class _NutrientWidget extends StatelessWidget {
  final String label;
  final String value;
  final Color nutrientColor;
  final double nutrientHeight;

  const _NutrientWidget({
    required this.label,
    required this.value,
    required this.nutrientColor,
    required this.nutrientHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112,
      padding: const EdgeInsets.fromLTRB(3, 16, 3, 3),
      decoration: BoxDecoration(
        color: AppColors.primaryWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Center(
            child: Column(
              children: [
                Text(label, style: AppTextStyles.medium12.copyWith(height: 16 / 12)),
                const Spacer(),
                Text(
                  value,
                  style: AppTextStyles.medium12.copyWith(
                    height: 16 / 12,
                    letterSpacing: 0.03,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 550),
              curve: Curves.ease,
              height: nutrientHeight,
              decoration: BoxDecoration(
                gradient: AppColors.nutrientGradientFromColor(nutrientColor),
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MacroElementsGradientBar extends StatelessWidget {
  const MacroElementsGradientBar({
    required this.color,
    super.key,
    this.height = 40,
  });

  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: height,
          decoration: BoxDecoration(
            gradient: AppColors.nutrientGradientFromColor(color),
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ],
    );
  }
}
