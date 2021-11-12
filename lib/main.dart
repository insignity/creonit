import 'package:creonit/features/product/presentation/bloc/products/product_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/product/presentation/bloc/category/category_bloc.dart';
import 'features/product/presentation/pages/home_page.dart';
import 'locator_service.dart' as di;
import 'locator_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.white));

    return MultiBlocProvider(
      providers: [
        BlocProvider<CategoryBloc>(create: (context) => sl<CategoryBloc>()),
        BlocProvider<ProductBloc>(create: (context) => sl<ProductBloc>()),
      ],
      child: const CupertinoApp(
        debugShowCheckedModeBanner: false,
        title: 'Creonit',
        home: HomePage(),
      ),
    );
  }
}
