import 'package:cookmatch/features/recipes/presentation/bloc/recipes_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipesScreen extends StatelessWidget {
  const RecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipesBloc, RecipesState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(body: Column(children: [Text('RecipesScreen')])),
        );
      },
    );
  }
}
