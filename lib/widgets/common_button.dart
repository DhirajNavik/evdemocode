import 'dart:math';
import 'package:animations/core/app_dimens.dart';
import 'package:animations/core/app_palettes.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatefulWidget {
  final Function()? onTap;
  final String? text;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final bool? enableScaleAnimation;
  final double? radius;

  const CommonButton({
    this.onTap,
    this.text,
    this.padding,
    this.height,
    this.enableScaleAnimation = true,
    this.radius,
    super.key,
  });

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton>
    with TickerProviderStateMixin {
  double _scale = 1.0;
  late AnimationController _gradientController;
  late AnimationController _controller;


  @override
  void initState() {
    _controller =
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 50),
          lowerBound: 0.0,
          upperBound: 0.1,
        )..addListener(() {
          _scale = 1 - _controller.value;
        });

    _gradientController =
        AnimationController(vsync: this, duration: Duration(seconds: 6))
          ..forward()
          ..repeat();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _gradientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (details) {
        _controller.forward();
      },
      onPointerUp: (details) {
        _controller.reverse();
      },
      child: AnimatedBuilder(
        animation: Listenable.merge([_gradientController, _controller]),
        builder: (context, _) {
          return Transform.scale(scale: _scale, child: buildButton());
        },
      ),
    );
  }

  Widget buildButton() {
    return InkWell(
      onTap: widget.onTap ?? () {},
      overlayColor: WidgetStatePropertyAll(AppPalettes.transparentColor),
      child: Container(
        width: double.infinity,
        height: (widget.height ?? AppDimens.buttonHeight),
        margin: .zero,
        padding: .symmetric(
          horizontal: AppDimens.buttonPadding,
          vertical: AppDimens.buttonPadding,
        ),

        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppPalettes.primaryColor, AppPalettes.secondaryColor],
            transform: GradientRotation(_gradientController.value * 2 * pi),
          ),
          borderRadius: BorderRadius.circular(
            widget.radius ?? AppDimens.buttonRadius,
          ),
          border: Border.all(
            color: AppPalettes.whiteColor.withOpacityExt(0.2),
            width: 1.4,
          ),
        ),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Text(
            widget.text ?? "",
            style: TextStyle().copyWith(
              fontWeight: FontWeight.w900,
              color: AppPalettes.backgroundColor,
            ),
          ),
        ),
      ),
    );
  }
}
