import 'package:bloc_app/core/theme/error/exception.dart';
import 'package:bloc_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> signInWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceIml implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceIml({required this.supabaseClient});
 

  
  
  @override
  Future<UserModel> signInWithEmailPassword({required String email, required String password}) async{
    try {
      final respnse = await supabaseClient.auth
          .signInWithPassword(password: password, email: email);
      if (respnse.user == null) {
        throw const ServerException("User is null");
      }
      return UserModel.fromJson(respnse.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
  
  @override
  Future<UserModel> signUpWithEmailPassword({required String name, required String email, required String password}) 
    async {
    try {
      final respnse = await supabaseClient.auth
          .signUp(password: password, email: email, data: {'name': name});
      if (respnse.user == null) {
        throw const ServerException("User is null");
      }
      return UserModel.fromJson(respnse.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  
  }
}
