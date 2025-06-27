import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceryhelper/features/buskets/presentation/bloc/buskets_bloc.dart';

class BusketsScreen extends StatelessWidget {
  const BusketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<BusketsBloc, BusketsState>(
        builder: (context, state) {
          return Scaffold(body: Column(children: [Text('BusketsScreen')]));
        },
      ),
    );
  }
}
