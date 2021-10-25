import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/config/config.dart';

class WidgetButton extends StatelessWidget {
  const WidgetButton(
      {required Widget child,
      double? width,
      Color? color,
      EdgeInsetsGeometry? margin,
      EdgeInsetsGeometry? padding,
      VoidCallback? onTap,
      required GlobalKey<ScaffoldState> globalKey,
      Key? key})
      : _child = child,
        _width = width,
        _color = color,
        _margin = margin,
        _padding = padding,
        _onTap = onTap,
        _globalKey = globalKey,
        super(key: key);

  final Widget _child;
  final double? _width;
  final Color? _color;
  final EdgeInsetsGeometry? _margin;
  final EdgeInsetsGeometry? _padding;
  final VoidCallback? _onTap;
  final GlobalKey<ScaffoldState> _globalKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _globalKey,
      margin: _margin ?? const EdgeInsets.all(0),
      padding: _padding ?? const EdgeInsets.all(0),
      width: _width ?? double.maxFinite,
      height: 50,
      child: ElevatedButton(
        onPressed: _onTap,
        child: _child,
        style: ElevatedButton.styleFrom(
            primary: _color ?? AppTheme.buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            )),
      ),
    );
  }
}
