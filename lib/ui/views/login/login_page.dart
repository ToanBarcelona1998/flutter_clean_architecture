import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/ui/ui.dart';
import 'package:flutter_clean_architecture/utils/utils.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key ?key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(margin),
        alignment: Alignment.center,
        child: WidgetButtonLoading(title: Message.login),
      ),
    );
  }
}
