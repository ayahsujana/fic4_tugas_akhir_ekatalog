import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fic4_flutter_auth_bloc/data/datasources/product_datasources.dart';

import '../../../data/models/response/product_response_model.dart';

part 'get_pagination_product_event.dart';
part 'get_pagination_product_state.dart';

class GetPaginationProductBloc
    extends Bloc<GetPaginationProductEvent, GetPaginationProductState> {
  final ProductDatasources productDatasources;
  GetPaginationProductBloc(this.productDatasources)
      : super(GetPaginationProductInitial()) {
    on<GetProductWithPagination>(_getAllProduct);
  }

  int offset = 0;
  void _getAllProduct(GetProductWithPagination event,
      Emitter<GetPaginationProductState> emit) async {
    if (state is ProductLoading) return;
    final currentState = state;
    List<ProductResponseModel> oldProducts = [];
    if (currentState is ProductLoaded) {
      oldProducts = currentState.products;
    }
    emit(ProductLoading(
      products: oldProducts,
      isFirstFetch: offset == 0,
    ));

    try {
      emit(ProductLoading(
        products: oldProducts,
        isFirstFetch: offset == 0,
      ));
      final result = await productDatasources.getAllProduct(offset);
      offset = offset + 1;
      final products = (state as ProductLoading).products;
      products.addAll(result);
      emit(ProductLoaded(products: products));
    } catch (e) {
      emit(ProductError(error: e.toString()));
    }
  }
}
