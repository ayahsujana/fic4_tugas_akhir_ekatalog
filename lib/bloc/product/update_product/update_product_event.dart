// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'update_product_bloc.dart';

@immutable
abstract class UpdateProductEvent {}

class DoUpdateProductEvent extends UpdateProductEvent {
  final ProductModel productModel;
  final int id;
  DoUpdateProductEvent({
    required this.productModel,
    required this.id,
  });
}
