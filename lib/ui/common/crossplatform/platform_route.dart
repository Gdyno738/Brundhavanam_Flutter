import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';



Route platformRoute(BuildContext context, Widget screen) {
  final platform = Theme.of(context).platform;

  if (platform == TargetPlatform.iOS) {
    return CupertinoPageRoute(builder: (_) => screen);
  }

  return MaterialPageRoute(builder: (_) => screen);
}

