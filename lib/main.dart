import 'package:flutter/material.dart';
import 'package:groceryhelper/app/app.dart';
import 'package:groceryhelper/app/setup/setup_app.dart';
import 'package:groceryhelper/features/baskets/baskets.dart';
import 'package:groceryhelper/infrastructure/services/locator.dart';
import 'package:groceryhelper/shared_ui/theme/bloc/theme_bloc.dart' as theme_bloc;
import 'package:groceryhelper/features/home/presentation/bloc/home_bloc.dart';
import 'package:groceryhelper/features/user/presentation/bloc/user/user_bloc.dart';
import 'package:groceryhelper/features/products_list/presentation/bloc/products_list_bloc.dart';
import 'package:groceryhelper/features/user/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await setupApp();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: locator<HomeBloc>()),
        BlocProvider.value(value: locator<BusketsBloc>()),
        BlocProvider.value(value: locator<ProductsListBloc>()),
        BlocProvider.value(value: locator<UserBloc>()..add(UserInitEvent())),
        BlocProvider.value(value: locator<AuthBloc>()..add(AuthInitEvent())),
        BlocProvider.value(value: locator<theme_bloc.ThemeBloc>()..add(theme_bloc.ThemeInitEvent())),
      ],
      child: const GroceryHelperApp(),
    ),
  );
}
