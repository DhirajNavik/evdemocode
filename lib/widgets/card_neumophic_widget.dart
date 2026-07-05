import 'dart:math';

import 'package:animations/core/app_dimens.dart';
import 'package:animations/core/app_palettes.dart';
import 'package:animations/core/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart' as inset;
import 'package:flutter_svg/flutter_svg.dart';

class CardNeumophicWidget extends StatelessWidget {
  final String title;
  final String body;
  final String image;
  final double size;
  final double angle;
  const CardNeumophicWidget({
    super.key,
    required this.title,
    required this.body,
    required this.image,
    this.size = 22,
    this.angle = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .symmetric(horizontal: 18, vertical: 12),
      decoration: inset.BoxDecoration(
        color: AppPalettes.cardColor,
        borderRadius: BorderRadius.circular(AppDimens.cardRadius),
        boxShadow: [
          inset.BoxShadow(
            color: AppPalettes.cardInsetShadowOne,
            blurRadius: 8,
            offset: Offset(-2, -2),
            inset: true,
          ),
          inset.BoxShadow(
            color: AppPalettes.cardInsetShadowTwo,
            blurRadius: 12,
            offset: Offset(2, 2),
            inset: true,
          ),
        ],
      ),

      child: Row(
        spacing: AppDimens.spacing,
        children: [
          Transform.rotate(
            angle: pi * angle,
            child: SvgPicture.asset(
              image,
              width: size,
              height: size,
              colorFilter: ColorFilter.mode(
                AppPalettes.primaryColor,
                BlendMode.srcIn,
              ),
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                FittedBox(
                  fit: .scaleDown,
                  child: Text(title, style: AppStyles.bodySmall),
                ),
                FittedBox(
                  fit: .scaleDown,
                  child: Text(body, style: AppStyles.bodyLarge),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
