import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/bloc/bloc.dart';
import 'package:flutter_clean_architecture/ui/ui.dart';
import 'package:flutter_clean_architecture/utils/utils.dart';
import 'package:formz/formz.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(margin),
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(
                  height: 100,
                ),
                WidgetTextField(
                  hintText: Message.userName,
                  onChanged: (value) => _loginBloc.add(OnChangeUserNameEvent(value)),
                  errorText: state.userValidate.valid ? null : Message.errUserName,
                ),
                const SizedBox(
                  height: 20,
                ),
                WidgetTextField(
                  hintText: Message.passWord,
                  onChanged: (value) => _loginBloc.add(OnChangePassWordEvent(value)),
                  errorText: state.passValidate.valid ? null : Message.errPassWord,
                ),
                const SizedBox(
                  height: 40,
                ),
                WidgetButtonLoading(
                  title: Message.login,
                  voidCallback: state.status == FormzStatus.valid
                      ? () async {
                          WidgetButtonLoading.startLoading();
                          //_loginBloc.add(const OnSubmitLoginEvent());
                        }
                      : null,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
