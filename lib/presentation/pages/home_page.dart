import 'package:fic4_flutter_auth_bloc/bloc/product/create_product/create_product_bloc.dart';
import 'package:fic4_flutter_auth_bloc/bloc/product/get_all_product/get_all_product_bloc.dart';
import 'package:fic4_flutter_auth_bloc/bloc/product/get_product_by_id/get_product_by_id_bloc.dart';
import 'package:fic4_flutter_auth_bloc/bloc/product/update_product/update_product_bloc.dart';
import 'package:fic4_flutter_auth_bloc/bloc/profile/profile_bloc.dart';
import 'package:fic4_flutter_auth_bloc/data/localsources/auth_local_storage.dart';
import 'package:fic4_flutter_auth_bloc/data/models/request/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../data/models/response/product_response_model.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  @override
  void initState() {
    context.read<ProfileBloc>().add(GetProfileEvent());
    context.read<GetAllProductBloc>().add(DoGetAllProductEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jual Product'),
        automaticallyImplyLeading: false,
        leading:
            IconButton(onPressed: () {}, icon: const Icon(Icons.menu_rounded)),
        actions: [
          IconButton(
              onPressed: () => logOutDialog(),
              icon: const Icon(Icons.logout_rounded)),
          IconButton(
              onPressed: () => logOutDialog(),
              icon: const Icon(Icons.account_box_sharp))
        ],
      ),
      body: Column(
        children: [
          BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ProfileLoaded) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.profile.name ?? ''),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(state.profile.email ?? ''),
                ],
              );
            }

            return const Text('no data');
          }),
          Expanded(child: BlocBuilder<GetAllProductBloc, GetAllProductState>(
            builder: (context, state) {
              if (state is GetAllProductLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is GetALlProductLoaded) {
                return ListView.builder(itemBuilder: ((context, index) {
                  final product = state.listProduct.reversed.toList()[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 90,
                            height: 90,
                            margin: const EdgeInsets.only(right: 10.0),
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: NetworkImage(
                                  "https://images.unsplash.com/photo-1528735602780-2552fd46c7af?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1173&q=80",
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(16.0),
                              ),
                              color: Colors.blue[400],
                            ),
                            child: Stack(
                              children: [
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
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(5.0),
                                      margin: const EdgeInsets.all(0.0),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(
                                            12.0,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        '€${product.price}' ?? '€24',
                                        style: const TextStyle(
                                            color: Colors.green,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        product.title ?? '-',
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () => editProduct(product),
                                      child: const Icon(
                                        Icons.edit,
                                        size: 20,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 6.0,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "8.1 km",
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
                                  product.description ?? '',
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontSize: 10.0,
                                  ),
                                ),
                                const SizedBox(
                                  height: 6.0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }));
              }
              return const Text('no data');
            },
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Add Product'),
                  content: SingleChildScrollView(
                    child: SizedBox(
                      height: 250,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            decoration:
                                const InputDecoration(labelText: 'Title'),
                            controller: titleController,
                          ),
                          TextField(
                            decoration:
                                const InputDecoration(labelText: 'Price'),
                            controller: priceController,
                            keyboardType: TextInputType.number,
                          ),
                          TextField(
                            maxLines: 3,
                            decoration:
                                const InputDecoration(labelText: 'Description'),
                            controller: descriptionController,
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    BlocListener<CreateProductBloc, CreateProductState>(
                      listener: (context, state) {
                        if (state is CreateProductLoaded) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text('${state.productResponseModel.id}')));
                          Navigator.pop(context);
                          context
                              .read<GetAllProductBloc>()
                              .add(DoGetAllProductEvent());
                        }
                      },
                      child: BlocBuilder<CreateProductBloc, CreateProductState>(
                        builder: (context, state) {
                          if (state is CreateProductLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ElevatedButton(
                            onPressed: () {
                              final productModel = ProductModel(
                                title: titleController.text,
                                price: int.parse(priceController.text),
                                description: descriptionController.text,
                              );
                              context.read<CreateProductBloc>().add(
                                  DoCreateProductEvent(
                                      productModel: productModel));
                            },
                            child: const Text('Save'),
                          );
                        },
                      ),
                    ),
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  logOutDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Logout :('),
            content: const Text('Are you sure want to logout?'),
            actions: [
              TextButton(
                  onPressed: () => Get.back(), child: const Text('Cancel')),
              TextButton(
                  onPressed: () async {
                    await AuthLocalStorage().removeToken();
                    Get.offAll(const LoginPage());
                  },
                  child: const Text('Yes')),
            ],
          );
        });
  }

  editProduct(ProductResponseModel product) {
    titleController.text = product.title.toString();
    priceController.text = product.price.toString();
    descriptionController.text = product.description.toString();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text('Edit product'),
              content: SingleChildScrollView(
                child: SizedBox(
                  height: 250,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        decoration: const InputDecoration(labelText: 'Title'),
                        controller: titleController,
                      ),
                      TextField(
                        decoration: const InputDecoration(labelText: 'Price'),
                        controller: priceController,
                        keyboardType: TextInputType.number,
                      ),
                      TextField(
                        maxLines: 3,
                        decoration:
                            const InputDecoration(labelText: 'Description'),
                        controller: descriptionController,
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                const SizedBox(
                  width: 4,
                ),
                BlocListener<UpdateProductBloc, UpdateProductState>(
                  listener: (context, state) {
                    if (state is UpdateProducLoaded) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              'Update Product Id ${state.productResponseModel.id} Success!')));
                      Navigator.pop(context);
                      context
                          .read<GetAllProductBloc>()
                          .add(DoGetAllProductEvent());
                    }
                  },
                  child: BlocBuilder<CreateProductBloc, CreateProductState>(
                    builder: (context, state) {
                      if (state is UpdateProductLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ElevatedButton(
                        onPressed: () {
                          final productModel = ProductModel(
                            title: titleController.text,
                            price: int.parse(priceController.text),
                            description: descriptionController.text,
                          );
                          context.read<UpdateProductBloc>().add(
                              DoUpdateProductEvent(
                                  productModel: productModel,
                                  id: product.id!.toInt()));
                        },
                        child: const Text('Update'),
                      );
                    },
                  ),
                ),
              ]);
        });
  }
}
