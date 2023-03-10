 

import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeLayoutBloc extends Bloc<ChangeLayoutEvent, bool> {

  ChangeLayoutBloc() : super(false){

   on<ChangeLayoutPressed>((event, emit) => emit(!state));
  }
}

abstract class ChangeLayoutEvent{}

class ChangeLayoutPressed extends ChangeLayoutEvent{}