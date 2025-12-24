import 'package:dartz/dartz.dart';
import 'package:spotify/core/services/get_it.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/features/auth/data/models/create_user_model.dart';
import 'package:spotify/features/auth/domain/repos/auth_repo.dart';

class SignUpUseCase implements UseCase<Either, CreateUserModel> {
  final AuthRepo authRepo;

  SignUpUseCase(this.authRepo);

  @override
  Future<Either> call(CreateUserModel? params) async {
    return getIt<AuthRepo>().signUp(params!);
  }
}
