import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/product/create_product/create_product_bloc.dart';
import '../../bloc/product/get_all_product/get_all_product_bloc.dart';
import '../../bloc/product/update_product/update_product_bloc.dart';
import '../../data/models/request/product_model.dart';
import '../../data/models/response/product_response_model.dart';

class EditMyProduct {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  
  editMyProduct(BuildContext context, ProductResponseModel product) {
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
