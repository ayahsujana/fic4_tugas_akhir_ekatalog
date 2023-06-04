// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/datasources/product_datasources.dart';
import '../../../data/models/response/product_response_model.dart';

part 'get_product_by_id_event.dart';
part 'get_product_by_id_state.dart';

class GetProductByIdBloc
    extends Bloc<GetProductByIdEvent, GetProductByIdState> {
  final ProductDatasources productDatasources;
  GetProductByIdBloc(
    this.productDatasources,
  ) : super(GetProductByIdInitial()) {
    on<DoGetProductByIdEvent>((event, emit) async {
      emit(GetProductByIdLoading());
      final result = await productDatasources
          .getProductById(event.id);
      emit(GetProductByIdLoaded(productResponseModel: result));
    });
  }
}
