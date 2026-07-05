import 'package:animations/core/app_dimens.dart';
import 'package:animations/core/app_images.dart';
import 'package:animations/core/app_palettes.dart';
import 'package:animations/core/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart' as inset;
import 'package:flutter_svg/svg.dart';

class HomeWidget {
  static Widget amountDetails() {
    return Padding(
      padding: const .symmetric(horizontal: 8),
      child: Column(
        spacing: AppDimens.textSpacing,
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text("Total Charged", style: AppStyles.bodyMedium),
              Text("134kWh", style: AppStyles.bodyMedium),
            ],
          ),
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text("Cost/KWh", style: AppStyles.bodyMedium),
              Text("\$0.09 USD", style: AppStyles.bodyMedium),
            ],
          ),
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text("Total Cost", style: AppStyles.bodyLarge),
              Text("\$10.06 USD", style: AppStyles.titleLarge),
            ],
          ),
        ],
      ),
    );
  }

  static Widget container({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: AppPalettes.cardColor,
        borderRadius: BorderRadius.circular(AppDimens.cardRadius),
      ),
      padding: const .symmetric(vertical: 20, horizontal: 16),
      child: child,
    );
  }

  static Widget insetContainer({
    required Widget child,
    required Color bgColor,
    required Color shadowColor,
  }) {
    return Container(
      decoration: inset.BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          inset.BoxShadow(
            color: shadowColor,
            blurRadius: 8,
            offset: Offset(-2, -2),
            inset: true,
          ),
          inset.BoxShadow(
            color: shadowColor,
            blurRadius: 8,
            offset: Offset(2, 2),
            inset: true,
          ),
        ],
      ),
      child: child,
    );
  }

  static Widget profile() {
    return Container(
      decoration: BoxDecoration(
        border: .all(color: Colors.white, width: 1),
        borderRadius: .circular(100),
        image: DecorationImage(image: AssetImage(AppImages.profilePng)),
      ),
      child: Badge(
        smallSize: 8,
        backgroundColor: AppPalettes.secondaryColor,
        child: SizedBox(width: 30, height: 30),
      ),
    );
  }

  static Widget homeHeader() {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Row(
          spacing: 10,
          children: [
            SvgPicture.asset(AppImages.battery, width: 20, height: 20),
            SvgPicture.asset(
              AppImages.icon_3,
              width: 18,
              height: 18,
              colorFilter: ColorFilter.mode(
                AppPalettes.primaryColor,
                BlendMode.srcIn,
              ),
            ),
            Text(
              "225 mi",
              style: AppStyles.bodyLarge.copyWith(
                color: AppPalettes.secondaryColor,
              ),
            ),
          ],
        ),
        Text("10 min remaining", style: AppStyles.bodyMedium),
      ],
    );
  }
}
