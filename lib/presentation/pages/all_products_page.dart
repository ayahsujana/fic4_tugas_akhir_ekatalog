// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:fic4_flutter_auth_bloc/bloc/product_wishlist/product_cubit_cubit.dart';
import 'package:fic4_flutter_auth_bloc/data/localsources/database_provider.dart';
import 'package:fic4_flutter_auth_bloc/data/models/request/product_model.dart';
import 'package:fic4_flutter_auth_bloc/presentation/widget/edit_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fic4_flutter_auth_bloc/bloc/product/get_pagination_bloc/get_pagination_product_bloc.dart';
import 'package:fic4_flutter_auth_bloc/data/models/response/product_response_model.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  final scrolController = ScrollController();

  void setupScrollController() {
    scrolController.addListener(() {
      if (scrolController.position.atEdge) {
        if (scrolController.position.pixels != 0) {
          context
              .read<GetPaginationProductBloc>()
              .add(GetProductWithPagination());
        }
      }
    });
  }

  @override
  void initState() {
    setupScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetPaginationProductBloc, GetPaginationProductState>(
        builder: (context, state) {
      if (state is ProductLoading && state.isFirstFetch == true) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      List products = [];
      bool isLoading = false;
      if (state is ProductLoading) {
        isLoading = true;
        products = state.products;
      } else if (state is ProductLoaded) {
        products = state.products;
      }
      if (products.isEmpty) {
        return const Center(
          child: Text('Products is Empty'),
        );
      }
      return Column(
        children: [
          Expanded(
              child: GridView.builder(
                  controller: scrolController,
                  itemCount: products.length + (isLoading ? 1 : 0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.7),
                  itemBuilder: (context, index) {
                    if (index < products.length) {
                      return ProductList(
                        products: state.products[index],
                      );
                    } else {
                      Timer(const Duration(milliseconds: 100), () {
                        scrolController
                            .jumpTo(scrolController.position.maxScrollExtent);
                      });
                    }
                    return Container();
                  })),
          isLoading
              ? const SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text('Load more product...')
                    ],
                  ),
                )
              : const SizedBox(),
        ],
      );
    });
  }
}

class ProductList extends StatelessWidget {
  const ProductList({
    Key? key,
    required this.products,
  }) : super(key: key);
  final ProductResponseModel products;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: NetworkImage(
                    "https://images.unsplash.com/photo-1528735602780-2552fd46c7af?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1173&q=80",
                  ),
                  fit: BoxFit.cover,
                ),
                color: Colors.blue[400],
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () async {
                        final prd = ProductModel(
                            title: products.title.toString(),
                            price: products.price!.toInt(),
                            description: products.description.toString());
                        context.read<ProductCubitCubit>().addproduct(prd);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6.0),
                        margin: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              12.0,
                            ),
                          ),
                        ),
                        child: const Icon(
                          Icons.favorite_border,
                          color: Colors.pinkAccent,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6.0),
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.green[800],
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          12.0,
                        ),
                      ),
                    ),
                    child: const Text(
                      "PROMO",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8.0,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () =>
                          EditMyProduct().editMyProduct(context, products),
                      child: Container(
                        padding: const EdgeInsets.all(6.0),
                        margin: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              12.0,
                            ),
                          ),
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.cyan,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    products.title ?? 'Roti Bakar',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "8.2 km",
                        style: TextStyle(
                          fontSize: 10.0,
                        ),
                      ),
                      const SizedBox(
                        width: 4.0,
                      ),
                      const Icon(
                        Icons.circle,
                        size: 4.0,
                      ),
                      const SizedBox(
                        width: 4.0,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.orange[400],
                        size: 16.0,
                      ),
                      const Text(
                        "4.8",
                        style: TextStyle(
                          fontSize: 10.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    products.description ?? "Bakery & Cake . Breakfast . Snack",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 10.0,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Rp. ${products.price}' ?? "Rp. 500",
                        style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.add_shopping_cart,
                          color: Colors.redAccent,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
