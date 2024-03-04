import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/extensions/extensions.dart';
import '../../../../../../domain/entities/home/brand_entity.dart';
import '../../../../../../domain/entities/home/category_entity.dart';
import '../../../../../../domain/entities/home/product_entity.dart';
import '../../../../../widgets/custom_header_and_search.dart';
import '../manager/home_cubit.dart';
import '../widgets/home_grid_widget.dart';
import '../widgets/home_offers_widget.dart';
import '../widgets/home_products_list_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();

    return BlocConsumer<HomeCubit, HomeStates>(
      bloc: homeCubit..getCategories(),
      buildWhen: (previous, current) {
        if (current is LoadingState) return false;
        if (current is FailureState) return false;
        return true;
      },
      listenWhen: (previous, current) {
        if (current is LoadingState) return true;
        if (current is FailureState) return true;
        return false;
      },
      builder: (context, state) {
        if (state is SuccessState) {
          return buildSuccessWidget(
            context,
            state.categories ?? [],
            state.brands ?? [],
            state.products ?? [],
          );
        }
        return Column(
          children: [
            const CustomHeaderAndSearch(),
            SizedBox(height: 350.h),
            const CircularProgressIndicator(),
          ],
        );
      },
      listener: (context, state) {
        if (state is LoadingState) {
          // show loading
        }
        if (state is FailureState) {
          // show error
        }
      },
    );
  }

  Widget buildSuccessWidget(BuildContext context, List<Category> categories,
      List<Brand> brands, List<Product> products) {
    return Column(
      children: [
        const CustomHeaderAndSearch(),
        Expanded(
          child: CustomScrollView(
            shrinkWrap: true,
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 210.h,
                  child: const HomeOffersWidget(),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  width: double.infinity,
                  height: 365.h,
                  child: HomeGridWidget(
                    title: 'Popular Categories',
                    gridList: categories,
                  ),
                ).setOnlyPadding(context, 24.h, 24.h, 0, 0),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  width: double.infinity,
                  height: 365.h,
                  child: HomeGridWidget(
                    title: 'Popular Brands',
                    gridList: brands,
                    imageFit: BoxFit.contain,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 465.h,
                  child: HomeProductsListWidget(
                    products: products,
                  ).setOnlyPadding(context, 24.h, 24.h, 0, 0),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
