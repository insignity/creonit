import 'package:creonit/common/text_style.dart';
import 'package:creonit/features/product/domain/entities/category_entity.dart';
import 'package:creonit/features/product/presentation/bloc/category/category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'products.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CategoryBloc>(context, listen: false).add(CategoryLoad());
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        List<CategoryEntity> categories = [];
        bool isLoading = false;

        if (state is CategoryLoading && state.isFirstPage) {
          return _loadingIndicator();
        } else if (state is CategoryLoading) {
          isLoading = true;
        } else if (state is CategoryLoaded) {
          categories = state.categories;
        } else if (state is CategoryError) {
          return Text(
            state.message,
            style: const TextStyle(color: Colors.white, fontSize: 25),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
              itemBuilder: (context, index) {
                if (index < categories.length + 1) {
                  if (index == 0) {
                    return GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => Products(
                                  category: const CategoryEntity(
                                      id: 0,
                                      title: 'Все товары категории',
                                      slug: 'all-categies'))))),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(0, 16, 0, 12),
                        child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Text("Все товары категории",
                                      style: Style.text1Red)),
                              SvgPicture.asset(
                                'assets/icons/arrow.svg',
                              ),
                            ]),
                      ),
                    );
                  }
                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) =>
                                Products(category: categories[index])))),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(0, 16, 0, 12),
                      child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Text(categories[index].title,
                                    style: Style.text1)),
                            SvgPicture.asset(
                              'assets/icons/arrow.svg',
                            ),
                          ]),
                    ),
                  );
                } else {
                  return _loadingIndicator();
                }
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.grey[400],
                );
              },
              itemCount: categories.length + (isLoading ? 1 : 0)),
        );
      },
    );
  }

  Widget _loadingIndicator() {
    return const Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(child: CircularProgressIndicator()));
  }
}
