import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/bloc/bloc.dart';
import 'package:flutter_clean_architecture/utils/utils.dart' show StringExtension, logo , Navigate;

class AnimatedSplash extends AnimatedWidget {
  const AnimatedSplash({Key? key, required Animation animation}) : super(key: key, listenable: animation);
  static final Tween<double> _opacityTween = Tween<double>(begin: 1, end: 0);
  static final Tween<double> _sizeTween = Tween<double>(begin: 0.0, end: 300.0);

  @override
  Widget build(BuildContext context) {
    final _animation = listenable as Animation<double>;
    return Center(
      child: Opacity(
        opacity: _opacityTween.evaluate(_animation),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: _sizeTween.evaluate(_animation),
          width: _sizeTween.evaluate(_animation),
          child: Image(
            image: AssetImage(logo.assetImage),
          ),
        ),
      ),
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController _controller;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          _controller.forward();
        } else if (status == AnimationStatus.completed) {
          _controller.reverse();
        }
      });
    animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashBloc,SplashState>(
          listener: (context, state) {
            if(state.hasToken!=null){
              if(state.hasToken!){
                _timer= Timer(const Duration(seconds: 3), () => Navigate.goHomeAndRemoveUtil());
              }else{
                _timer = Timer(const Duration(seconds: 3), () => Navigate.goLogin());
              }
            }
          },
          child: AnimatedSplash(
            animation: animation,
            key: widget.key,
          )),
    );
  }
}
