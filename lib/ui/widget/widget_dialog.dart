import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/core/core.dart' show ContextExtension;
class WidgetDialog extends StatelessWidget {
  const WidgetDialog({Key ?key}) : super(key: key);


  static showHozDialog(BuildContext context){
    context.showModalDialog(child: const WidgetDialog());
  }
  static showVerticalDialog(BuildContext context){
    context.showModalDialog(child: const WidgetDialog());
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
