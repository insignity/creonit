import 'package:creonit/features/product/data/repositories/category_repository_impl.dart';
import 'package:creonit/features/product/domain/repositories/category_repository.dart';
import 'package:creonit/features/product/domain/usecases/get_all_categories.dart';
import 'package:creonit/features/product/presentation/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/platform/network_info.dart';
import 'features/product/data/datasources/category_local_data_source.dart';
import 'features/product/data/datasources/category_remote_data_source.dart';

final sl = GetIt.instance;

Future init() async {

  // BLoC / Cubit
  sl.registerFactory(
    () => CategoryBloc(getAllCategories: sl()),
  );

  // UseCases
  sl.registerLazySingleton(() => GetAllCategories(sl()));

  // Repository
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<CategoryRemoteDataSource>(
    () => CategoryRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<CategoryLocalDataSource>(
    () => CategoryLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );

  // External
  final  sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());

  debugPrint('sl initialized');
}