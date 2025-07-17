import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:design/design.dart';
import 'package:groceryhelper/app/router/app_router.dart';
import 'package:groceryhelper/features/create_basket/presentation/bloc/create_busket_bloc.dart';
import 'package:groceryhelper/infrastructure/services/locator.dart';

class CreateBusketScreen extends StatelessWidget {
  const CreateBusketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: locator<CreateBusketBloc>(), child: const _CreateBusketScreenView());
  }
}

class _CreateBusketScreenView extends StatefulWidget {
  const _CreateBusketScreenView();

  @override
  State<_CreateBusketScreenView> createState() => _CreateBusketScreenViewState();
}

class _CreateBusketScreenViewState extends State<_CreateBusketScreenView> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppToolbar(title: 'Создание корзины', withBackButton: true, onBackPressed: () => appRouter.pop()),
      body: SingleChildScrollView(child: Column(children: [])),
    );
  }
}
