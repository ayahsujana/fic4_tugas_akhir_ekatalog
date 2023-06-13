// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fic4_flutter_auth_bloc/bloc/product_wishlist/product_cubit_cubit.dart';
import 'package:fic4_flutter_auth_bloc/data/models/request/product_model.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class WistlistProduct extends StatelessWidget {
  const WistlistProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<ProductCubitCubit>(context)..getProductWithlist(),
      child: const WishListPage(),
    );
  }
}

class WishListPage extends StatelessWidget {
  const WishListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProductCubitCubit>().state;
    if (state is ProductCubitInitial) {
      return const SizedBox(
        child: Center(
          child: Text('INITIALPRODUCT'),
        ),
      );
      // } else if (state is ProductCubitLoading) {
      //   return const Center(
      //     child: CircularProgressIndicator.adaptive(),
      //   );
    } else if (state is ProductCubitLoaded) {
      if (state.product.isEmpty) {
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
    return const Center(
      child: Text('Belum ada product yang di tambahkan.'),
    );
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
          var item = product![index];
          return Card(
            clipBehavior: Clip.antiAlias,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 160.0,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          "https://i.ibb.co/JpdK5ch/photo-1513104890138-7c749659a591-crop-entropy-cs-tinysrgb-fit-max-fm-jpg-ixid-Mnwy-ODA4-ODh8-MHwxf-H.jpg",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              item.title,
                              style: const TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              highlightColor: Colors.yellow.withOpacity(0.3),
                              splashColor: Colors.red.withOpacity(0.8),
                              focusColor: Colors.green.withOpacity(0.0),
                              hoverColor: Colors.blue.withOpacity(0.8),
                              onTap: () async {
                                BlocProvider.of<ProductCubitCubit>(context)
                                    .deleteProduct(item.id!);
                                BlocProvider.of<ProductCubitCubit>(context)
                                    .getProductWithlist();
                              },
                              canRequestFocus: false,
                              enableFeedback: false,
                              borderRadius: BorderRadius.circular(2),
                              child: Icon(MdiIcons.deleteOutline),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          item.description,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        Row(
                          children: [
                            Text(
                              'Rp. ${item.price}',
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Transform.scale(
                              scale: 0.8,
                              alignment: Alignment.centerRight,
                              child: ElevatedButton.icon(
                                icon: Icon(MdiIcons.cart),
                                label: const Text("Add to Cart"),
                                style: ElevatedButton.styleFrom(),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
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
