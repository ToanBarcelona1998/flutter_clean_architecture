import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/config/config.dart';
import 'package:flutter_clean_architecture/ui/ui.dart';

enum LoadingValue { none, start, done }

late _WidgetButtonLoadingState _state;

// ignore: must_be_immutable
class WidgetButtonLoading extends StatefulWidget {
  final String _title;
  double _width;
  VoidCallback? _voidCallBack;
  static LoadingValue _value = LoadingValue.none;

  WidgetButtonLoading(
      {required String title, double? width, VoidCallback? voidCallback, Key? key})
      : _title = title,
        _width = width??= double.infinity,
        _voidCallBack = voidCallback,
        super(key: key);
  static _WidgetButtonLoadingState? of(BuildContext context) => context.findAncestorRenderObjectOfType();

  static void startLoading() {
    return  _state._startLoading();
  }

  static void deactivateLoading() {
    return _state._deactivateLoading();
  }

  static void loadingDone(){
    return _state._loadingDone();
  }
  @override
  _WidgetButtonLoadingState createState() => _WidgetButtonLoadingState();
}

class _WidgetButtonLoadingState extends State<WidgetButtonLoading> with SingleTickerProviderStateMixin {
  final _buttonKey = GlobalKey<ScaffoldState>();

  late AnimationController _controller;

  double _initWidth = 0.0;

  final double _minWidth = 80;


  @override
  void initState() {
    super.initState();
    _state = this;
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))..addListener(_listen);
  }

  @override
  void dispose() {
    _controller.removeListener(_listen);
    _controller.dispose();
    super.dispose();
  }

  void _listen() {
    widget._width = _initWidth - (_initWidth - _minWidth) * _controller.value;
    setState(() {});
  }

  void _startLoading() {
    if (mounted) {
      final renderBox = _buttonKey.currentContext?.findAncestorRenderObjectOfType() as RenderBox;
      _initWidth = renderBox.size.width;
      WidgetButtonLoading._value = LoadingValue.start;
      setState(() {});
      _controller.forward();
    }
  }

  void _loadingDone() async {
    if (mounted) {
      WidgetButtonLoading._value = LoadingValue.done;
      setState(() {});
    }
  }

  void _deactivateLoading() {
    if (mounted) {
      _controller.reverse();

      _initWidth = 0.0;

      widget._width = double.maxFinite;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      WidgetButton(
      width: widget._width,
      child: WidgetButtonLoading._value == LoadingValue.none
          ? Text(widget._title)
          : WidgetButtonLoading._value == LoadingValue.start
              ? const CircularProgressIndicator(
                  color: AppTheme.unCheckColor,
                  strokeWidth: 2,
                )
              : const Icon(Icons.check),
      onTap: widget._voidCallBack,
      globalKey: _buttonKey,
    );
  }
}
