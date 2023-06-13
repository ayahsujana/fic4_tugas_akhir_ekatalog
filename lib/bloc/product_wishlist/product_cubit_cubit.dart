// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:fic4_flutter_auth_bloc/bloc/product/get_pagination_bloc/get_pagination_product_bloc.dart';

import 'package:fic4_flutter_auth_bloc/data/models/request/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/localsources/database_provider.dart';

part 'product_cubit_state.dart';

class ProductCubitCubit extends Cubit<ProductCubitState> {
  ProductCubitCubit({
    required DatabaseProvider databaseProvider,
  })  : _dbProvider = databaseProvider,
        super(ProductCubitInitial());

  final DatabaseProvider _dbProvider;

  Future<void> getProductWithlist() async {
    emit(ProductCubitLoading());
    try {
      final product = await _dbProvider.getProduct();
      emit(ProductCubitLoaded(product: product, wishlist: product.length));
      print('JUMLAH BADGE: ${product.length}');
    } catch (e) {
      emit(ProductCubitError(error: e.toString()));
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      await _dbProvider.deleteProduct(id);
    } catch (e) {
      emit(ProductCubitError(error: e.toString()));
    }
  }

  Future<void> addproduct(ProductModel product) async {
    emit(ProductCubitLoading());
    try {
      await _dbProvider.saveProduct(product);
    } catch (e) {
      emit(ProductCubitError(error: e.toString()));
    }
  }
}
