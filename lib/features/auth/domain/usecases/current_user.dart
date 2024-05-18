import 'package:bloc_app/core/theme/error/failure.dart';
import 'package:bloc_app/core/usecase/usecase.dart';
import 'package:bloc_app/features/auth/domain/entities/user.dart';
import 'package:bloc_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository authRepository;

  CurrentUser({required this.authRepository});

  @override
  Future<Either<Failure, User>> call(NoParams noParams) {
    return authRepository.currentUser();
  }
}
