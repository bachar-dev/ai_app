part of 'auth_bloc.dart';

@immutable
sealed class Auth1State {}

final class AuthInitial extends Auth1State {}

final class LoadingState extends Auth1State {}

final class SuccessState extends Auth1State {}

final class FailureState extends Auth1State {
  final String error;

  FailureState({required this.error});
}
