import 'package:dartz/dartz.dart';
import 'package:spotify/features/auth/data/models/create_user_model.dart';
import 'package:spotify/features/auth/data/models/sign_in_user_model.dart';

abstract class AuthRepo {
  Future<Either> signUp(CreateUserModel user);
  Future<Either> signIn(SignInUserModel user);
}
