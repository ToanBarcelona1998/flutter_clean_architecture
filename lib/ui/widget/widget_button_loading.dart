import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/config/config.dart';
import 'package:flutter_clean_architecture/ui/ui.dart';

enum LoadingValue { none, start, done }

late _WidgetButtonLoadingState _state;

// ignore: must_be_immutable
class WidgetButtonLoading extends StatefulWidget {
  final String _title;
  double? _width;
  final LoadingValue _value;

  WidgetButtonLoading({required String title, double? width, LoadingValue value = LoadingValue.none, Key? key})
      : _title = title,
        _width = width,
        _value = value,
        super(key: key);

  static _WidgetButtonLoadingState? of(BuildContext context) => context.findAncestorRenderObjectOfType();

  static void startLoading() {
    return _state._startLoading();
  }

  static void deactivateLoading(){
    return _state._deactivateLoading();
  }

  @override
  _WidgetButtonLoadingState createState() => _WidgetButtonLoadingState();
}

class _WidgetButtonLoadingState extends State<WidgetButtonLoading> with SingleTickerProviderStateMixin {
  final _buttonKey = GlobalKey<ScaffoldState>();

  late AnimationController _controller;

  double _initWidth = 0.0;


  @override
  void initState() {
    super.initState();
    widget._width ??= double.maxFinite;
    _controller = AnimationController(vsync: this)..addListener(_listen);
  }

  @override
  void dispose() {
    _controller.removeListener(_listen);
    _controller.dispose();
    super.dispose();
  }

  void _listen() {
    widget._width = _initWidth - (_initWidth - 50) * _controller.value;
    setState(() {});
  }

  void _startLoading() {
    if (mounted) {
      final renderBox = _buttonKey.currentContext?.findAncestorRenderObjectOfType() as RenderBox;
      _initWidth = renderBox.size.width;
      setState(() {});
      _controller.forward();
    }
  }

  void _deactivateLoading(){
    if(mounted){
      _controller.reverse();

      _initWidth = 0.0;

      widget._width = double.maxFinite;
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WidgetButton(
      width: widget._width,
      child: widget._value == LoadingValue.none
          ? Text(widget._title)
          : widget._value == LoadingValue.start
              ? const CircularProgressIndicator(
                  color: AppTheme.unCheckColor,
                  strokeWidth: 2,
                )
              : const Icon(Icons.check),
      key: _buttonKey,
    );
  }
}
