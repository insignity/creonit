import 'package:creonit/common/app_colors.dart';
import 'package:creonit/common/text_style.dart';
import 'package:creonit/features/product/presentation/widgets/categories.dart';
import 'package:creonit/features/product/presentation/widgets/empty_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> bodies = [
    const EmptyTab(tabName: 'Главная'),
    const Categories(),
    const EmptyTab(tabName: 'Избранное'),
    const EmptyTab(tabName: 'Корзина'),
    const EmptyTab(tabName: 'Профиль'),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: const Text(
            'Каталог',
            style: Style.text1,
          ),
          centerTitle: true,
        ),
        body: IndexedStack(
          index: currentIndex,
          children: bodies,
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 10,
            selectedLabelStyle: Style.textBottomNavBarSelected,
            unselectedLabelStyle: Style.textBottomNavBarUnselected,
            selectedItemColor: AppColors.primaryBlack,
            unselectedItemColor: AppColors.grayColorTransparent,
            currentIndex: currentIndex,
            onTap: (index) => setState(() => currentIndex = index),
            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/images/icons/home.svg',
                    color: currentIndex == 0
                        ? AppColors.primaryBlack
                        : AppColors.grayColorTransparent,
                  ),
                  label: "Главная"),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/images/icons/catalogue.svg',
                    color: currentIndex == 1
                        ? AppColors.primaryBlack
                        : AppColors.grayColorTransparent,
                  ),
                  label: "Каталог"),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/images/icons/like.svg',
                    color: currentIndex == 2
                        ? AppColors.primaryBlack
                        : AppColors.grayColorTransparent,
                  ),
                  label: "Избранное"),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/images/icons/cart.svg',
                    color: currentIndex == 3
                        ? AppColors.primaryBlack
                        : AppColors.grayColorTransparent,
                  ),
                  label: "Корзина"),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/images/icons/profile.svg',
                    color: currentIndex == 4
                        ? AppColors.primaryBlack
                        : AppColors.grayColorTransparent,
                  ),
                  label: "Профиль"),
            ]));
  }
}
