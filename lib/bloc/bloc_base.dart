import 'package:flutter_bloc/flutter_bloc.dart';

abstract class Base<Event,State> extends Bloc<Event,State>{
  Base(State initialState) : super(initialState);

  void refreshState();

}