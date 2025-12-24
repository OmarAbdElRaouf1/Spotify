import 'package:dartz/dartz.dart';
import 'package:spotify/features/auth/data/models/create_user_model.dart';
import 'package:spotify/features/auth/data/models/sign_in_user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class FirebaseAuthService {
  Future<Either> signUp(CreateUserModel user);
  Future<Either> signIn(SignInUserModel user);
}

class SupabaseAuthServiceImpl implements FirebaseAuthService {
  final SupabaseClient supabase = Supabase.instance.client;

  // ===================== SIGN UP =====================
  @override
  Future<Either<String, String>> signUp(CreateUserModel user) async {
    try {
      final response = await supabase.auth.signUp(
        email: user.email,
        password: user.password,
      );

      final supabaseUser = response.user;
      if (supabaseUser == null) {
        return Left('Sign up failed');
      }

      // حفظ بيانات اليوزر الإضافية
      await supabase.from('users').insert({
        'id': supabaseUser.id, // uuid من Supabase
        'name': user.fullName,
        'email': user.email,
      });

      return Right('Sign up successful');
    } on AuthException catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  // ===================== SIGN IN =====================
  @override
  Future<Either<String, String>> signIn(SignInUserModel user) async {
    try {
      await supabase.auth.signInWithPassword(
        email: user.email,
        password: user.password,
      );

      return Right('Sign in successful');
    } on AuthException catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left('Unexpected error');
    }
  }
}
