import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'base_url.dart';

extension StringExtension on String {
  String get assetImage => BaseUrl.assetImage + this;

  String get assetsFonts => BaseUrl.assetFonts + this;

  String get assetsEnv => BaseUrl.assetEnv;
}

extension AnimationExtension on AnimationController {
  Animation<T> curvedTweenAnimation<T>({T? begin, T? end}) {
    return Tween<T>(begin: begin, end: end).animate(CurvedAnimation(parent: this, curve: Curves.easeOut));
  }
}

extension ContextExtension on BuildContext {
  void showModalBottom(Widget child) {
    showModalBottomSheet(context: this, builder: (context) => child);
  }

  void showModalDialog(Widget child){
    showDialog(context: this, builder: (context) => child);
  }

  Size get screenSize => MediaQuery.of(this).size;

  double? get iconSize => IconTheme.of(this).size;

  EdgeInsets get padding => MediaQuery.of(this).padding;
}
