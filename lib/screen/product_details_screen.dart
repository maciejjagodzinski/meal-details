import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrient_details/screen/widgets/meal_details_info.dart';
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
