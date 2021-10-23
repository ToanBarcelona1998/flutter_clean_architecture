import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/config/config.dart' show Navigate;
import 'package:flutter_clean_architecture/utils/utils.dart' show Message , ContextExtension;

///[WidgetDialog]

///[WidgetDialog.showHozDialog]
///WidgetDialog.showHozDialog(context ,
/// title : 'example dialog' ,
/// content : 'example content' ,
/// onOk : () => null)


//////[WidgetDialog.showVerticalDialog]
///WidgetDialog.showVerticalDialog(context ,
///title : 'example dialog' ,
/// content : 'example content' ,
/// onOk : () => null)

class WidgetDialog extends StatelessWidget {
  const WidgetDialog(
      {Key? key, required String title, required String content, bool isShowHorizontal = true, VoidCallback? onOk})
      : _title = title,
        _content = content,
        _isShowHorizontal = isShowHorizontal,
        _onOk = onOk,
        super(key: key);

  final String _title;
  final String _content;
  final bool _isShowHorizontal;
  final VoidCallback? _onOk;

  static showHozDialog(BuildContext context, {required String title, required String content, VoidCallback? onOk}) {
    context.showModalDialog(
      child: WidgetDialog(
        title: title,
        content: content,
        isShowHorizontal: true,
        onOk: onOk,
      ),
    );
  }

  static showVerticalDialog(BuildContext context, {required String title, required String content, VoidCallback? onOk}) {
    context.showModalDialog(
      child: WidgetDialog(
        title: title,
        content: content,
        isShowHorizontal: false,
        onOk: onOk,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      titlePadding: const EdgeInsets.fromLTRB(16, 16, 16, 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: Text(
        _title,
        style: Theme.of(context).textTheme.caption,
        textAlign: TextAlign.start,
      ),
      children: [
        Text(
          _content,
          style: Theme.of(context).textTheme.subtitle1,
          textAlign: TextAlign.start,
        ),
        const SizedBox(
          height: 8,
        ),
        _isShowHorizontal
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _onOk != null
                      ? Padding(
                          padding: const EdgeInsets.only(right: 80),
                          child: GestureDetector(
                            onTap: _onOk,
                            child: const Text(Message.ok),
                          ),
                        )
                      : const SizedBox(),
                  GestureDetector(
                    onTap: () => Navigate.goBack(),
                    child: Text(Message.cancel ,style: Theme.of(context).textTheme.button,),
                  )
                ],
              )
            : Align(
                alignment: Alignment.centerRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _onOk != null
                        ? GestureDetector(
                            onTap: _onOk,
                            child: const Text(Message.ok),
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 12,
                    ),
                    GestureDetector(
                      onTap: () => Navigate.goBack(),
                      child: const Text(Message.cancel),
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
