part of '../../baskets.dart';

class BusketsScreen extends StatelessWidget {
  const BusketsScreen({super.key});

  _onCreateBusket(BuildContext context) {
    appRouter.push(RouterPaths.createBusket);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<BusketsBloc, BusketsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppMainToolbar(title: 'Корзины'),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: AppFubButton(
              onTap: () {
                _onCreateBusket(context);
              },
              color: context.theme.busket,
              child: SvgPicture.asset(AppAssets.icAdd),
            ),
            body: Column(children: []),
          );
        },
      ),
    );
  }
}
