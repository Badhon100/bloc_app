import 'package:bloc_app/core/theme/error/exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<String> signInWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceIml implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceIml({required this.supabaseClient});
 

  
  
  @override
  Future<String> signInWithEmailPassword({required String email, required String password}) {
    throw UnimplementedError();
  }
  
  @override
  Future<String> signUpWithEmailPassword({required String name, required String email, required String password}) 
    async {
    try {
      final respnse = await supabaseClient.auth
          .signUp(password: password, email: email, data: {'name': name});
      if (respnse.user == null) {
        throw const ServerException("User is null");
      }
      return respnse.user!.id;
    } catch (e) {
      throw ServerException(e.toString());
    }
  
  }
}
