import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:design/design.dart';
import 'package:groceryhelper/app/router/app_router.dart';
import 'package:groceryhelper/features/create_basket/presentation/bloc/create_busket_bloc.dart';
import 'package:groceryhelper/features/create_basket/presentation/widgets/basket_colors.dart';
import 'package:groceryhelper/features/create_basket/presentation/widgets/basket_tag.dart';
import 'package:groceryhelper/features/create_basket/presentation/widgets/name_part.dart';
import 'package:groceryhelper/features/create_basket/presentation/widgets/select_icon_part.dart';
import 'package:groceryhelper/infrastructure/services/locator.dart';
import 'package:gap/gap.dart';

class CreateBusketScreen extends StatelessWidget {
  const CreateBusketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateBusketBloc>(
      create: (_) => locator<CreateBusketBloc>(),
      child: const _CreateBusketScreenView(),
    );
  }
}

class _CreateBusketScreenView extends StatefulWidget {
  const _CreateBusketScreenView();

  @override
  State<_CreateBusketScreenView> createState() => _CreateBusketScreenViewState();
}

class _CreateBusketScreenViewState extends State<_CreateBusketScreenView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController tagController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppToolbar(title: 'Создание корзины', withBackButton: true, onBackPressed: () => appRouter.pop()),
      body: BlocBuilder<CreateBusketBloc, CreateBusketState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const Gap(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: NamePart(
                    selectedIcon: state.selectedIcon,
                    selectedIconColor: state.selectedColor,
                    nameController: nameController,
                  ),
                ),
                const Gap(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SelectIconPart(
                    selectedIcon: state.selectedIcon,
                    selectedColor: state.selectedColor,
                    onIconSelected: (icon) => context.read<CreateBusketBloc>().add(ChangeIconEvent(icon: icon)),
                  ),
                ),
                const Gap(20),
                BasketColors(
                  onColorSelected: (color) => context.read<CreateBusketBloc>().add(ChangeColorEvent(color: color)),
                ),
                const Gap(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: BasketTag(
                    controller: tagController,
                    tags: state.tags,
                    onAddTag: (tag) => context.read<CreateBusketBloc>().add(AddTagEvent(tag: tag)),
                    onRemoveTag: (tag) => context.read<CreateBusketBloc>().add(RemoveTagEvent(tag: tag)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    tagController.dispose();
    super.dispose();
  }
}
