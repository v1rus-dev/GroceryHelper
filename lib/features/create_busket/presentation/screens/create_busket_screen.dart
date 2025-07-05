import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceryhelper/common_ui/widgets/layouts/app_scaffold.dart';
import 'package:groceryhelper/common_ui/widgets/toolbars/app_toolbar.dart';
import 'package:groceryhelper/features/create_busket/presentation/bloc/create_busket_bloc.dart';

class CreateBusketScreen extends StatelessWidget {
  const CreateBusketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateBusketBloc>(
      create: (context) => CreateBusketBloc(),
      child: const _CreateBusketScreenView(),
    );
  }
}

class _CreateBusketScreenView extends StatefulWidget {
  const _CreateBusketScreenView({super.key});

  @override
  State<_CreateBusketScreenView> createState() => _CreateBusketScreenViewState();
}

class _CreateBusketScreenViewState extends State<_CreateBusketScreenView> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppToolbar(title: 'Создание корзины', withBackButton: true),
      body: SingleChildScrollView(child: Column(children: [])),
    );
  }
}
