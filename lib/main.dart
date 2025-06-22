import 'package:cookmatch/core/navigation/app_router.dart';
import 'package:cookmatch/core/services/locator.dart';
import 'package:cookmatch/features/auth/user/presentation/bloc/user_bloc.dart';
import 'package:cookmatch/features/recipes/presentation/bloc/recipes_bloc.dart';
import 'package:cookmatch/features/shopping_list/presentation/bloc/shopping_list_bloc.dart';
import 'package:cookmatch/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await initServiceLocator();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator<RecipesBloc>()),
        BlocProvider(create: (_) => locator<ShoppingListBloc>()),
        BlocProvider(create: (_) => locator<UserBloc>()..add(UserInitEvent())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: appRouter);
  }
}
