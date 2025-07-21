import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:groceryhelper/domain/entities/product_item_with_type.dart';
import 'package:groceryhelper/features/products_list/presentation/widgets/product_category_filter.dart';
import 'package:groceryhelper/features/products_list/presentation/widgets/dismissible_product_item.dart';
import 'package:groceryhelper/infrastructure/services/locator.dart';
import 'package:groceryhelper/shared/constants/app_assets.dart';
import 'package:groceryhelper/app/router/app_router.dart';
import 'package:groceryhelper/app/router/router_paths.dart';
import 'package:design/design.dart';
import 'package:design/widgets/text_fields/app_text_field.dart';
import 'package:groceryhelper/features/products_list/presentation/bloc/products_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({super.key});

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late AnimationController _scrollToTopAnimationController;
  late Animation<double> _scrollToTopAnimation;
  bool _showScrollToTopButton = false;

  @override
  void initState() {
    super.initState();
    _scrollToTopAnimationController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    _scrollToTopAnimation = CurvedAnimation(parent: _scrollToTopAnimationController, curve: Curves.easeInOut);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final showButton = _scrollController.offset > 200;
    if (showButton != _showScrollToTopButton) {
      setState(() {
        _showScrollToTopButton = showButton;
      });
      if (showButton) {
        _scrollToTopAnimationController.forward();
      } else {
        _scrollToTopAnimationController.reverse();
      }
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  _onAddItem(BuildContext context) {
    appRouter.push(RouterPaths.productForm, extra: false);
  }

  _onProductTap(ProductItemWithType product) {
    appRouter.push(RouterPaths.productForm, extra: true);
  }

  _onTapDelete(ProductItemWithType product) {
    locator<ProductsListBloc>().add(DeleteProduct(product: product));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: BlocBuilder<ProductsListBloc, ProductsListState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppMainToolbar(title: 'Товары'),
            floatingActionButton: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_showScrollToTopButton)
                  AnimatedBuilder(
                    animation: _scrollToTopAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _scrollToTopAnimation.value,
                        child: Container(
                          margin: const EdgeInsets.only(right: 16),
                          child: FloatingActionButton(
                            onPressed: _scrollToTop,
                            backgroundColor: context.theme.busket,
                            elevation: 4,
                            child: Icon(Icons.keyboard_arrow_up, color: Colors.white, size: 28),
                          ),
                        ),
                      );
                    },
                  ),
                AppFubButton(
                  onTap: () {
                    _onAddItem(context);
                  },
                  color: context.theme.primary,
                  child: SvgPicture.asset(AppAssets.icAdd),
                ),
              ],
            ),
            body: CustomScrollView(
              controller: _scrollController,
              slivers: [
                const SliverGap(8),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverToBoxAdapter(
                    child: AppTextField(controller: _searchController, labelText: 'Поиск'),
                  ),
                ),
                const SliverGap(16),
                SliverToBoxAdapter(
                  child: ProductCategoryFilter(
                    selectedCategory: state.selectedCategory,
                    onCategorySelected: (category) {
                      context.read<ProductsListBloc>().add(UpdateSelectedCategory(category: category));
                    },
                  ),
                ),
                const SliverGap(16),
                SliverList.separated(
                  separatorBuilder: (context, index) => const Gap(8),
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: DismissibleProductItem(
                        product: state.products[index],
                        onTap: _onProductTap,
                        onDelete: _onTapDelete,
                      ),
                    );
                  },
                ),
                const SliverGap(80),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _scrollToTopAnimationController.dispose();
    super.dispose();
  }
}
