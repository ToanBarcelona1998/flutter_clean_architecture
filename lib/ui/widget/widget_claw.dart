import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/config/config.dart';
import 'package:flutter_clean_architecture/utils/utils.dart';

class WidgetClaw extends StatefulWidget {
  final Widget _child;
  final double? _height, _width;
  final int _itemCount, _index;
  final List<VoidCallback> _listCallBack;
  final List<Color> _listItemColor;
  final List<IconData> _icons;

  const WidgetClaw(
      {required Widget child,
      double? height,
      double? width,
      required int itemCount,
      required int index,
      required List<VoidCallback> callBacks,
      required List<Color> listColor,
      required List<IconData> icons,
      Key? key})
      : _child = child,
        _height = height,
        _width = width,
        _itemCount = itemCount,
        _index = index,
        _listCallBack = callBacks,
        _listItemColor = listColor,
        _icons = icons,
        super(key: key);

  @override
  _WidgetClawState createState() => _WidgetClawState();
}

class _WidgetClawState extends State<WidgetClaw> {
  int _indexItemSelect = -1;

  bool _decisionShow = false, _isShow = false;

  double _offsetItem = 0.0, _offsetStart = 0.0, _offsetUpdate = 0.0 , _positItemTile = 0.0;
  final double  _widthItem = 80.0 ;

  late List<Widget> _listItem;

  @override
  void initState() {
    super.initState();
    _listItem = List.empty(growable: true);
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < widget._itemCount; i++) {
      Positioned positioned = Positioned(
          right: i *  _widthItem,
          child: GestureDetector(
            onTap: widget._listCallBack[i],
            child: Container(
              width: widget._width?? _widthItem,
              height: widget._height ?? context.screenSize.width / 2.2,
              decoration: BoxDecoration(
                color: widget._listItemColor[i],
              ),
              child: Icon(
                widget._icons[i],
              ),
            ),
          ));
      _listItem.add(positioned);
    }
    GestureDetector gestureDetector = GestureDetector(
      onHorizontalDragStart: (details) {
        _offsetStart = details.localPosition.dx;
        if (_indexItemSelect != widget._index) {
          _isShow = false;
          _offsetItem = 0;
          _positItemTile = 0;
        }
        _indexItemSelect = widget._index;
        setState(() {});
      },
      onHorizontalDragUpdate: (details) {
        _offsetUpdate = details.localPosition.dx;
        if (_offsetStart - _offsetUpdate > 0 && _offsetStart - _offsetUpdate <  widget._itemCount * _widthItem && !_isShow) {
          _offsetItem = _offsetUpdate - _offsetStart;
        } else if (_isShow && _offsetStart - _offsetUpdate < 0 && _offsetStart - _offsetUpdate > widget._itemCount * _widthItem) {
          _offsetItem = - widget._itemCount *_widthItem + (_offsetUpdate - _offsetStart);
        }
        if (_offsetStart - _offsetUpdate > widget._itemCount * _widthItem && !_isShow) {
          _positItemTile = _offsetUpdate - _offsetStart + widget._itemCount * _widthItem;
        }
        if (_offsetStart - _offsetUpdate > 0 && _isShow) {
          _positItemTile = _offsetUpdate - _offsetStart;
        }
        _decisionShow = (details.primaryDelta! < 0);
        setState(() {});
      },
      onHorizontalDragEnd: (details) {
        _offsetItem = _decisionShow ? - widget._itemCount* _widthItem : 0.0;
        _positItemTile =0;
        _isShow = _decisionShow;
        setState(() {});
      },
      child: Transform.translate(
        offset: Offset(
            _indexItemSelect == widget._index
                ? _offsetItem
                : (_decisionShow && _indexItemSelect == widget._index ? -  _widthItem : 0.0),
            0.0),
        child: Container(
          color: AppTheme.whiteColor,
          child: Transform.translate(offset: Offset(_indexItemSelect == widget._index ? _positItemTile : 0.0, 0),child: widget._child),
        ),
      ),
    );
    _listItem.add(gestureDetector);
    return Container(
      padding: const EdgeInsetsDirectional.only(start: 14, end: 14, bottom: 7, top: 7),
      color: AppTheme.transparentColor,
      height: widget._height ?? context.screenSize.width / 2.2,
      child: Stack(
        children: _listItem,
      ),
    );
  }
}
