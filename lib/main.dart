import 'package:bloc_app/core/theme/theme.dart';
import 'package:bloc_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bloc_app/features/auth/presentation/pages/sign_in_page.dart';
import 'package:bloc_app/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await initDependencies();
    runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => serviceLocator<AuthBloc>(),
          ),
        ],
        child: const MyApp(),
      ),
    );
  } catch (e) {
    print('Error initializing the app: $e');
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthUserLoggedIn());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dartkThemeMode,
      home: const SignInPage(),
    );
  }
}
