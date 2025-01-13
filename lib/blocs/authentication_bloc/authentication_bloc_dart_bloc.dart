import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'authentication_bloc_dart_event.dart';
part 'authentication_bloc_dart_state.dart';

class AuthenticationBlocDartBloc extends Bloc<AuthenticationBlocDartEvent, AuthenticationBlocDartState> {
  AuthenticationBlocDartBloc() : super(AuthenticationBlocDartInitial()) {
    on<AuthenticationBlocDartEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
