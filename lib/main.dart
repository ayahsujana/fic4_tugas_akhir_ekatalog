import 'package:fic4_flutter_auth_bloc/bloc/product/create_product/create_product_bloc.dart';
import 'package:fic4_flutter_auth_bloc/bloc/product/get_all_product/get_all_product_bloc.dart';
import 'package:fic4_flutter_auth_bloc/bloc/product/get_product_by_id/get_product_by_id_bloc.dart';
import 'package:fic4_flutter_auth_bloc/bloc/product/update_product/update_product_bloc.dart';
import 'package:fic4_flutter_auth_bloc/bloc/profile/profile_bloc.dart';
import 'package:fic4_flutter_auth_bloc/bloc/register/register_bloc.dart';
import 'package:fic4_flutter_auth_bloc/data/datasources/auth_datasources.dart';
import 'package:fic4_flutter_auth_bloc/data/datasources/product_datasources.dart';
import 'package:fic4_flutter_auth_bloc/data/localsources/database_provider.dart';
import 'package:fic4_flutter_auth_bloc/presentation/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'bloc/login/login_bloc.dart';
import 'bloc/product/get_pagination_bloc/get_pagination_product_bloc.dart';
import 'bloc/product_wishlist/product_cubit_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(AuthDatasource()),
        ),
        BlocProvider(
          create: (context) => LoginBloc(AuthDatasource()),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(AuthDatasource()),
        ),
        BlocProvider(
          create: (context) => CreateProductBloc(ProductDatasources()),
        ),
        BlocProvider(
          create: (context) => GetAllProductBloc(ProductDatasources()),
        ),
        BlocProvider(
          create: (context) => GetProductByIdBloc(ProductDatasources()),
        ),
        BlocProvider(
          create: (context) => UpdateProductBloc(ProductDatasources()),
        ),
        BlocProvider(
          create: (context) => GetPaginationProductBloc(ProductDatasources()),
        ),
        BlocProvider(
          create: (context) =>
              ProductCubitCubit(databaseProvider: DatabaseProvider.instance),
        ),
      ],
      child: GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Splash(),
      ),
    );
  }
}
