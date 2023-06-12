// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fic4_flutter_auth_bloc/bloc/product_wishlist/product_cubit_cubit.dart';
import 'package:fic4_flutter_auth_bloc/data/models/request/product_model.dart';
import 'package:get/get.dart';

class WistlistProduct extends StatefulWidget {
  const WistlistProduct({super.key});

  @override
  State<WistlistProduct> createState() => _WistlistProductState();
}

class _WistlistProductState extends State<WistlistProduct> {
  @override
  void initState() {
    context.read<ProductCubitCubit>().getProductWithlist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const WishListPage();
  }
}

class WishListPage extends StatelessWidget {
  const WishListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProductCubitCubit>().state;
    print('STATE: $state');
    if (state is ProductCubitInitial) {
      return const SizedBox(
        child: Center(
          child: Text('INITIALPRODUCT'),
        ),
      );
    } else if (state is ProductCubitLoading) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    } else if (state is ProductCubitLoaded) {
      print('STATUS: ${state.product!.length}');
      if (state.product!.isEmpty) {
        return const Center(
          child: Text('Belum ada product yang di tambahkan.'),
        );
      } else {
        return ListProducts(product: state.product);
      }
    } else if (state is ProductCubitError) {
      return Center(
        child: Text(state.error.toString()),
      );
    }
    return const Placeholder();
  }
}

class ListProducts extends StatelessWidget {
  const ListProducts({
    Key? key,
    required this.product,
  }) : super(key: key);

  final List<ProductModel>? product;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: product!.length,
        itemBuilder: ((context, index) {
          return Text(product![index].title);
        }));

    // ListView(
    //   children: [
    //     for (final prduct in product!) ...[
    //       Padding(
    //         padding: const EdgeInsets.all(10),
    //         child: ListTile(
    //           title: Text(prduct.title),
    //           subtitle: Text(prduct.description),
    //         ),
    //       )
    //     ]
    //   ],
    // );
  }
}
