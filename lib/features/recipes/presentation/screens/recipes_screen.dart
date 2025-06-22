import 'package:groceryhelper/features/recipes/presentation/bloc/recipes_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipesScreen extends StatelessWidget {
  const RecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<RecipesBloc, RecipesState>(
        builder: (context, state) {
          return Scaffold(body: Column(children: [Text('RecipesScreen')]));
        },
      ),
    );
  }
}
