import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';

class BaseScreen extends StatelessWidget {
  final Widget child;
  final Color statusBarColor;
  final Brightness statusBarIconBrightness;

  const BaseScreen({
    super.key,
    required this.child,
    this.statusBarColor = Colors.transparent,
    this.statusBarIconBrightness = Brightness.dark,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        statusBarIconBrightness: statusBarIconBrightness,
        statusBarBrightness: statusBarIconBrightness == Brightness.light
            ? Brightness.dark
            : Brightness.light,
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent, // IMPORTANT
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFB2CDDD),
                Color(0xFFFDF7FD),
                Color(0xFFE7F6FF),
                Color(0xFFF8F4FE),
              ],
              stops: [0.0, 0.35, 0.7, 1.0],
            ),
          ),
          child: SafeArea(
            top: false,
            bottom: true,
            child: child,
          ),


        ),

      ),
    );
  }
}
