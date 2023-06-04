// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_product_by_id_bloc.dart';

@immutable
abstract class GetProductByIdEvent {}

class DoGetProductByIdEvent extends GetProductByIdEvent {
  final int id;
  DoGetProductByIdEvent({
    required this.id,
  });
}
