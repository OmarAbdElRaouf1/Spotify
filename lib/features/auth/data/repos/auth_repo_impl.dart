import 'package:dartz/dartz.dart';
import 'package:spotify/core/services/auth/supabase_auth.dart';
import 'package:spotify/core/services/get_it.dart';
import 'package:spotify/features/auth/data/models/create_user_model.dart';
import 'package:spotify/features/auth/data/models/sign_in_user_model.dart';
import 'package:spotify/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  @override
  Future<Either> signIn(SignInUserModel user) async {
    return await getIt<FirebaseAuthService>().signIn(user);
  }

  @override
  Future<Either> signUp(CreateUserModel user) async {
    return await getIt<FirebaseAuthService>().signUp(user);
  }
}
