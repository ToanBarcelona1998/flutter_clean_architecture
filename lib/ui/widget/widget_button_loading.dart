import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/config/config.dart';
import 'package:flutter_clean_architecture/ui/ui.dart';

enum LoadingValue { none, start, done }

late _WidgetButtonLoadingState _state;

// ignore: must_be_immutable
class WidgetButtonLoading extends StatefulWidget {
  final String _title;
  double? _width;
  VoidCallback? _voidCallBack;
  LoadingValue _value;

  WidgetButtonLoading(
      {required String title, double? width, VoidCallback? voidCallback, LoadingValue value = LoadingValue.none, Key? key})
      : _title = title,
        _width = width,
        _voidCallBack = voidCallback,
        _value = value,
        super(key: key);
  static _WidgetButtonLoadingState? of(BuildContext context) => context.findAncestorRenderObjectOfType();

  static void startLoading() async {
    return await _state._startLoading();
  }

  static void deactivateLoading() {
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
    _state = this;
    widget._width ??= double.maxFinite;
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..addListener(_listen);
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

  Future<void> _startLoading() async {
    if (mounted) {
      final renderBox = _buttonKey.currentContext?.findAncestorRenderObjectOfType() as RenderBox;
      _initWidth = renderBox.size.width;
      widget._value = LoadingValue.start;
      setState(() {});
      _controller.forward();
    }
  }

  Future<void> _loadingDone() async {
    if (mounted) {
      widget._value = LoadingValue.done;
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
      onTap: widget._voidCallBack,
      globalKey: _buttonKey,
    );
  }
}
