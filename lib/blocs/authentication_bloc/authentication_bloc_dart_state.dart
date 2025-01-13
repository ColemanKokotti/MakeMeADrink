part of 'authentication_bloc_dart_bloc.dart';

sealed class AuthenticationBlocDartState extends Equatable {
  const AuthenticationBlocDartState();
  
  @override
  List<Object> get props => [];
}

final class AuthenticationBlocDartInitial extends AuthenticationBlocDartState {}
