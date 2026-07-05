import 'dart:async';
import 'package:animations/widgets/animated_progress.dart';
import 'package:animations/core/app_dimens.dart';
import 'package:animations/core/app_images.dart';
import 'package:animations/core/app_palettes.dart';
import 'package:animations/core/app_styles.dart';
import 'package:animations/widgets/card_neumophic_widget.dart';
import 'package:animations/widgets/common_button.dart';
import 'package:animations/widgets/home_appbar.dart';
import 'package:animations/widgets/home_widget.dart';
import 'package:animations/presentation/tesla_charging_view.dart';
import 'package:animations/core/app_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late AnimationController _progressController;
  late AnimationController _wireController;
  final ValueNotifier<int> percentage = ValueNotifier(20);
  final ValueNotifier<String> status = ValueNotifier("Stop Charging");
  late Timer _timer;

  @override
  void initState() {
    _wireController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..forward();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
    _timer = createTimer();

    super.initState();
  }

  @override
  void dispose() {
    _progressController.dispose();
    _wireController.dispose();
    _timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalettes.backgroundColor,
      appBar: homeAppbar(title: "Model 3", action: [HomeWidget.profile()]),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
        ).copyWith(bottom: 18),
        child: Column(
          crossAxisAlignment: .start,
          spacing: AppDimens.spacing,
          children: [
            HomeWidget.homeHeader(),

            Stack(
              alignment: .topRight,
              children: [
                TeslaChargingView(controller: _wireController),
                ListenableBuilder(
                  listenable: percentage,
                  builder: (context, _) {
                    return AnimatedSwitcher(
                      switchInCurve: Curves.fastOutSlowIn,
                      switchOutCurve: Curves.easeIn,
                      duration: Duration(milliseconds: 100),
                      transitionBuilder: (child, animation) {
                        final custom = Tween<double>(
                          begin: 0.2,
                          end: 0.9,
                        ).animate(animation);
                        return FadeTransition(opacity: custom, child: child);
                      },
                      child: Text(
                        '${percentage.value}%',
                        key: ValueKey(percentage.value),
                        style: AppStyles.headlineMedium,
                      ),
                    );
                  },
                ),
              ],
            ),

            GridView.builder(
              padding: .symmetric(vertical: 8),
              itemCount: AppData.icons.length,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 20,
                childAspectRatio: 1 / 0.5,
              ),
              itemBuilder: (_, index) {
                final data = AppData.icons[index];
                return Center(
                  child: SvgPicture.asset(
                    data.name,
                    colorFilter: ColorFilter.mode(data.color, BlendMode.srcIn),
                    width: 28,
                    height: 28,
                  ),
                );
              },
            ),

            HomeWidget.container(
              child: Column(
                spacing: AppDimens.widgetSpacing,
                children: [
                  HomeWidget.insetContainer(
                    bgColor: AppPalettes.loadingBgColor,
                    shadowColor: AppPalettes.loadingShadowColor,
                    child: Align(
                      alignment: .centerLeft,
                      child: HomeWidget.insetContainer(
                        bgColor: AppPalettes.secondaryColor,
                        shadowColor: AppPalettes.primaryColor,
                        child: AnimatedProgress(
                          controller: _progressController,
                          progress: percentage,
                        ),
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: .spaceBetween,
                    spacing: AppDimens.spacing,
                    children: [
                      Expanded(
                        child: CardNeumophicWidget(
                          image: AppImages.icon_3,
                          title: "Charging Speed",
                          body: "12 kW",
                        ),
                      ),

                      Expanded(
                        child: CardNeumophicWidget(
                          image: AppImages.battery,
                          title: "Remaining",
                          body: "0h 58 min",
                          size: 14,
                          angle: 1.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            HomeWidget.container(
              child: Column(
                spacing: AppDimens.widgetSpacing,
                children: [
                  HomeWidget.amountDetails(),
                  ValueListenableBuilder(
                    valueListenable: status,
                    builder: (_, _, child) {
                      return CommonButton(text: status.value, onTap: onTap);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onTap() {
    final isCharging = status.value.toLowerCase().contains("stop");
    if (isCharging) {
      _wireController.animateBack(
        0,
        duration: const Duration(milliseconds: 200),
      );

      status.value = "Start";
      _timer.cancel();
    } else {
      if (percentage.value == 100) {
        percentage.value = 0;
      }
      _wireController.forward();
      status.value = "Stop charging";
      _timer = createTimer();
    }
  }

  Timer createTimer() {
    return Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (percentage.value < 75) {
        percentage.value++;
        return;
      }

      timer.cancel();

      _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
        if (percentage.value < 100) {
          percentage.value++;
        } else {
          timer.cancel();
        }
      });
    });
  }
}
