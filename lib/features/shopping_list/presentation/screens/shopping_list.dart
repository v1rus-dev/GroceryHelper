import 'package:cookmatch/features/shopping_list/presentation/bloc/shopping_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingList extends StatelessWidget {
  const ShoppingList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShoppingListBloc, ShoppingListState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(body: Column(children: [Text('ShoppingList')])),
        );
      },
    );
  }
}
