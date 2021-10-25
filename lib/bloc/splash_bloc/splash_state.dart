part of 'splash_bloc.dart';

// ignore: must_be_immutable
class SplashState extends Equatable{
  SplashState({this.hasToken});

  bool ?hasToken;

  @override
  List<Object?> get props => [hasToken];

}