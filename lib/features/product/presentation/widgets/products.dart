import 'dart:async';

import 'package:creonit/common/app_colors.dart';
import 'package:creonit/common/text_style.dart';
import 'package:creonit/features/product/domain/entities/category_entity.dart';
import 'package:creonit/features/product/domain/entities/product_entity.dart';
import 'package:creonit/features/product/presentation/bloc/products/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Products extends StatefulWidget {
  final CategoryEntity category;
  const Products({required this.category, Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  void initState() {
    BlocProvider.of<ProductBloc>(context).add(widget.category.id == 0
        ? const ProductEventLoadAll()
        : ProductEventLoadByCategory(categoryid: widget.category.id));
    super.initState();
  }

  final scrollController = ScrollController();

  void setupScrollController(BuildContext context) {
    print('scroll controller');
    scrollController.addListener(() {
      print('scroll controller added listener');
      if (scrollController.position.atEdge) {
        print('scroll controller position at edge');
        if (scrollController.position.pixels != 0) {
          print('scroll controller position pisels != 0');
          BlocProvider.of<ProductBloc>(context).add(widget.category.id == 0
              ? const ProductEventLoadAll()
              : ProductEventLoadByCategory(categoryid: widget.category.id));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        List<ProductEntity> products = [];
        bool isLoading = false;
        if (state is ProductLoading && state.isFirstPage) {
          return _loadingIndicator();
        } else if (state is ProductLoading) {
          isLoading = true;
          products = state.oldProductsList;
        } else if (state is ProductLoaded) {
          products = state.products;
        } else if (state is ProductError) {
          return Text(
            state.message,
            style: const TextStyle(color: Colors.white, fontSize: 25),
          );
        }
        return Column(
          children: [
            _productsTopBar(),
            const Divider(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  controller: scrollController,
                  itemBuilder: (context, index) {
                    if (index < products.length) {
                      return GestureDetector(
                        onTap: () {},
                        child: _productItem(products[index], context,
                            hit: (index % 50 == 0) ? true : false,
                            finished: (index % 50 == 2) ? true : false,
                            sale: (index % 50 == 1) ? 1 : 0),
                      );
                    } else {
                      Timer(const Duration(milliseconds: 30), () {
                        scrollController
                            .jumpTo(scrollController.position.maxScrollExtent);
                      });
                      return _loadingIndicator();
                    }
                  },
                  itemCount: products.length + (isLoading ? 1 : 0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 164 / 323, crossAxisCount: 2),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _loadingIndicator() {
    return const Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(child: CircularProgressIndicator()));
  }

  /// Filters and sorting
  Widget _productsTopBar() {
    return IntrinsicHeight(
      child: Row(children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 11, bottom: 6),
            child: Row(
              children: [
                SvgPicture.asset('assets/icons/filter.svg'),
                const SizedBox(width: 8),
                const Text(
                  'Фильтры',
                  style: Style.text2,
                )
              ],
            ),
          ),
        ),
        const VerticalDivider(
          indent: 6,
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 11, bottom: 6),
            child: Row(
              children: [
                SvgPicture.asset('assets/icons/sorting.svg'),
                const SizedBox(width: 8),
                const Text(
                  'По популярности',
                  style: Style.text2,
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget _productItem(ProductEntity product, BuildContext context,
      {bool hit = false, bool finished = false, int sale = 0}) {
    return Container(
        padding: const EdgeInsets.fromLTRB(7, 0, 7, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: (MediaQuery.of(context).size.width - 36) / 2,
                  width: (MediaQuery.of(context).size.width - 36) / 2,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Image.network(
                      product.image,
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: SvgPicture.asset(
                      'assets/icons/like.svg',
                      width:
                          ((MediaQuery.of(context).size.width - 36) / 2) * 0.13,
                    )),
                hit
                    ? Positioned.fill(
                        bottom: 12,
                        child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: AppColors.greenColorHit),
                              // width:
                              //     ((MediaQuery.of(context).size.width - 36) / 2) * 0.13,
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text(
                                  'ХИТ',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )),
                      )
                    : Container(),
              ],
            ),
            // Price and cart icon
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                height: 36,
                decoration: BoxDecoration(
                    color: AppColors.grayColorFullTransparent,
                    borderRadius: BorderRadius.circular(4.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      product.price.toString() + ' ₽',
                      style: Style.textPrice(sale > 0),
                    ),
                    if (sale > 0)
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          (product.price + sale).toString() + ' ₽',
                          style: Style.textPriceCrossed,
                        ),
                      ),
                    Spacer(),
                    finished
                        ? Text('ЗАКОНЧИЛСЯ', style: Style.textProductFinished)
                        : SvgPicture.asset(
                            'assets/icons/cart_dark.svg',
                            color: AppColors.primaryBlack,
                          ),
                  ],
                )),

            /// Company name
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(
                product.slug,
                style: Style.textProductCompany,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            /// Product title
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                product.title,
                style: Style.textProductTitle,
                maxLines: 3,
              ),
            ),
          ],
        ));
  }
}
