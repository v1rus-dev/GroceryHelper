import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceryhelper/features/home/presentation/bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(body: Column(children: [Text('HomeScreen')]));
        },
      ),
    );
  }
}
