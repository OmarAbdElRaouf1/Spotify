import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/features/auth/data/models/sign_in_user_model.dart';
import 'package:spotify/features/auth/domain/repos/auth_repo.dart';

class SignInUseCase implements UseCase<Either, SignInUserModel> {
  final AuthRepo authRepo;

  SignInUseCase(this.authRepo);

  @override
  Future<Either> call(SignInUserModel? params) async {
    return authRepo.signIn(params!);
  }
}
