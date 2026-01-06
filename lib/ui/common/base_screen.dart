import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';

class BaseScreen extends StatelessWidget {
  final Widget child;
  final Color statusBarColor;
  final Brightness statusBarIconBrightness;
  final Color backgroundColor;

  const BaseScreen({
    super.key,
    required this.child,
    this.statusBarColor = AppColors.primary,
    this.statusBarIconBrightness = Brightness.light,
    this.backgroundColor = AppColors.scaffoldBackground,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        statusBarIconBrightness: statusBarIconBrightness,
        statusBarBrightness: statusBarIconBrightness == Brightness.light
            ? Brightness.dark
            : Brightness.light, // iOS
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true, // 🔥 NORMALIZED
        backgroundColor: backgroundColor,
        body: child,
      ),
    );
  }
}
