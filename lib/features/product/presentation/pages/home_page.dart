import 'package:creonit/common/app_colors.dart';
import 'package:creonit/common/text_style.dart';
import 'package:creonit/features/product/presentation/widgets/categories.dart';
import 'package:creonit/features/product/presentation/widgets/empty_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CupertinoTabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = CupertinoTabController(initialIndex: 0);
  }

  List<Widget> bodies = [
    const EmptyTab(tabName: 'Главная'),
    const Categories(),
    const EmptyTab(tabName: 'Избранное'),
    const EmptyTab(tabName: 'Корзина'),
    const EmptyTab(tabName: 'Профиль'),
  ];
  List<String> titles = [
    'Главная',
    'Каталог',
    'Избранное',
    'Корзина',
    'Профиль'
  ];
  final GlobalKey<NavigatorState> firstTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> secondTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> thirdTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> fourthTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> fifthTabNavKey = GlobalKey<NavigatorState>();

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final listOfKeys = [
      firstTabNavKey,
      secondTabNavKey,
      thirdTabNavKey,
      fourthTabNavKey,
      fifthTabNavKey
    ];
    return WillPopScope(
        onWillPop: () async {
          return !await listOfKeys[tabController!.index]
              .currentState!
              .maybePop();
        },
        child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            leading: GestureDetector(
              onTap: () {
                Navigator.of(context).maybePop();
              },
              child: RotatedBox(
                  quarterTurns: 2,
                  child: SvgPicture.asset(
                    'assets/icons/arrow.svg',
                    color: AppColors.primaryBlack,
                  )),
            ),
            middle: Text(
              titles[currentIndex],
              style: Style.text1,
            ),
          ),
          child: SafeArea(
            child: CupertinoTabScaffold(
              controller: tabController,
              tabBar: CupertinoTabBar(
                activeColor: AppColors.primaryBlack,
                onTap: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                items: [
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/icons/home.svg',
                        color: currentIndex == 0
                            ? AppColors.primaryBlack
                            : AppColors.grayColorTransparent,
                      ),
                      label: "Главная"),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/icons/catalogue.svg',
                        color: currentIndex == 1
                            ? AppColors.primaryBlack
                            : AppColors.grayColorTransparent,
                      ),
                      label: "Каталог"),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/icons/like.svg',
                        color: currentIndex == 2
                            ? AppColors.primaryBlack
                            : AppColors.grayColorTransparent,
                      ),
                      label: "Избранное"),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/icons/cart.svg',
                        color: currentIndex == 3
                            ? AppColors.primaryBlack
                            : AppColors.grayColorTransparent,
                      ),
                      label: "Корзина"),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/icons/profile.svg',
                        color: currentIndex == 4
                            ? AppColors.primaryBlack
                            : AppColors.grayColorTransparent,
                      ),
                      label: "Профиль"),
                ],
              ),
              tabBuilder: (context, index) => CupertinoTabView(
                  navigatorKey: listOfKeys[index],
                  builder: (context) {
                    currentIndex = index;
                    return bodies[index];
                  }),
            ),
          ),
        ));
  }
}
