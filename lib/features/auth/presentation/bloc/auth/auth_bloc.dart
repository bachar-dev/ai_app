import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, Auth1State> {
  AuthBloc() : super(AuthInitial()) {
    final supabaseAuth = Supabase.instance.client.auth;
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoadingState());
        try {
          await supabaseAuth.signInWithPassword(
            email: event.email,
            password: event.password,
          );
          emit(SuccessState());
        } catch (e) {
          emit(FailureState(error: "error logging in:$e"));
        }
      }
    });
  }
}
