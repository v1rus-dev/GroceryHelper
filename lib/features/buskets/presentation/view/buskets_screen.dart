import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceryhelper/core/widgets/app_main_toolbar.dart';
import 'package:groceryhelper/features/buskets/presentation/bloc/buskets_bloc.dart';

class BusketsScreen extends StatelessWidget {
  const BusketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<BusketsBloc, BusketsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppMainToolbar(text: 'Корзины'),
            body: Column(children: []),
          );
        },
      ),
    );
  }
}
