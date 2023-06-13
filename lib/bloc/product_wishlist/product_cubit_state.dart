// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_cubit_cubit.dart';

abstract class ProductCubitState extends Equatable {
  const ProductCubitState();

  @override
  List<Object> get props => [];
}

class ProductCubitInitial extends ProductCubitState {}

class ProductCubitLoading extends ProductCubitState {
  @override
  List<Object> get props => [];
}

class ProductCubitLoaded extends ProductCubitState {
  final List<ProductModel> product;
  final int wishlist;
  const ProductCubitLoaded({
    required this.product,
    required this.wishlist,
  });

  @override
  List<Object> get props => [product];
}

class ProductCubitError extends ProductCubitState {
  final String error;
  const ProductCubitError({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class ProductCubitSuccess extends ProductCubitState {
  @override
  List<Object> get props => [];
}
