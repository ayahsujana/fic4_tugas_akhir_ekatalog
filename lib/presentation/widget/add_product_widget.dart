import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/product/create_product/create_product_bloc.dart';
import '../../bloc/product/get_all_product/get_all_product_bloc.dart';
import '../../data/models/request/product_model.dart';

class AddNewProduct {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  addNewProduct(BuildContext context) {
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
              BlocListener<CreateProductBloc, CreateProductState>(
                listener: (context, state) {
                  if (state is CreateProductLoaded) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('${state.productResponseModel.id}')));
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
                            DoCreateProductEvent(productModel: productModel));
                      },
                      child: const Text('Save'),
                    );
                  },
                ),
              ),
            ],
          );
        });
  }
}
