// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_product_by_id_bloc.dart';

@immutable
abstract class GetProductByIdState {}

class GetProductByIdInitial extends GetProductByIdState {}
class GetProductByIdLoading extends GetProductByIdState {}
class GetProductByIdLoaded extends GetProductByIdState {
  final ProductResponseModel productResponseModel;
  GetProductByIdLoaded({
    required this.productResponseModel,
  });
}
