import 'package:bloc_app/core/secret/app_secret.dart';
import 'package:bloc_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:bloc_app/features/auth/data/repositories/auth_repository_imp.dart';
import 'package:bloc_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:bloc_app/features/auth/domain/usecases/user_sign_in.dart';
import 'package:bloc_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:bloc_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;
Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  //DataSource
  serviceLocator..registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceIml(
      supabaseClient: serviceLocator(),
    ),
  )
  //Repository
  ..registerFactory<AuthRepository>(
    () => AuthRepositoryImp(
      remoteDataSource: serviceLocator(),
    ),
  )
  ..registerFactory(
    () => UserSignUp(
      authRepository: serviceLocator(),
    ),
  )
  //UseCases
  ..registerFactory(
    () => UserSignIn(
      authRepository: serviceLocator(),
    ),
  )
  //bloc
  ..registerLazySingleton(
    () => AuthBloc(
      userSignIn: serviceLocator(),
      userSignUp: serviceLocator(),
      currentUser: serviceLocator(),
    ),
  );
}
