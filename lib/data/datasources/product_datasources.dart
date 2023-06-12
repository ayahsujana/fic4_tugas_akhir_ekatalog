import 'dart:convert';

import 'package:fic4_flutter_auth_bloc/data/models/request/product_model.dart';
import 'package:fic4_flutter_auth_bloc/data/models/response/product_response_model.dart';
import 'package:http/http.dart' as http;

class ProductDatasources {
  Future<ProductResponseModel> createProduct(ProductModel model) async {
    // try {
    var headers = {'Content-Type': 'application/json'};
    print(model.toJson());
    final response = await http.post(
      Uri.parse('https://api.escuelajs.co/api/v1/products'),
      headers: headers,
      body: model.toJson(),
    );
    print('=====');
    print(response.body);
    return ProductResponseModel.fromJson(response.body);
    // } catch (e) {

    // }
  }

  Future<ProductResponseModel> updateProduct(ProductModel model, int id) async {
    var headers = {'Content-Type': 'application/json'};
    final response = await http.put(
      Uri.parse('https://api.escuelajs.co/api/v1/products/$id'),
      body: model.toJson(),
      headers: headers
    );

    return ProductResponseModel.fromJson(response.body);
  }

  Future<ProductResponseModel> getProductById(int? id) async {
    final response = await http.get(
      Uri.parse('https://api.escuelajs.co/api/v1/products/$id'),
    );

    return ProductResponseModel.fromJson(response.body);
  }

  Future<List<ProductResponseModel>> getAllProduct(int page) async {
    final response = await http.get(
      Uri.parse('https://api.escuelajs.co/api/v1/products/?offset=$page&limit=10'),
    );

    final result = List<ProductResponseModel>.from(jsonDecode(response.body)
        .map((x) => ProductResponseModel.fromMap(x))).toList();

    return result;
  }
}
