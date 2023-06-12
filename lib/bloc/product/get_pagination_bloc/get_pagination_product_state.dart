// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_pagination_product_bloc.dart';

abstract class GetPaginationProductState extends Equatable {
  final List<ProductResponseModel> products;
  const GetPaginationProductState({this.products = const []});

  @override
  List<Object> get props => [];
}

class GetPaginationProductInitial extends GetPaginationProductState {}

class ProductLoaded extends GetPaginationProductState {
  @override
  final List<ProductResponseModel> products;
  final ProductResponseModel? loadedProduct;
  const ProductLoaded({
    required this.products,
    this.loadedProduct,
  });
}

class ProductLoading extends GetPaginationProductState {
  @override
  final List<ProductResponseModel> products;
  bool isFirstFetch;
  ProductLoading({
    required this.products,
    this.isFirstFetch = false,
  });
}

class ProductError extends GetPaginationProductState {
  final String error;
  const ProductError({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
