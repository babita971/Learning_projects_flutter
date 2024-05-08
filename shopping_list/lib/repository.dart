import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shopping_list/models/response_model.dart';

class ShoppingListRepository {
  Future<CustomResponse> getAllItemsFromDatabase() async {
    final url = Uri.https(
        "shopping-list-sl-default-rtdb.firebaseio.com", "shopping-list.json");
    try {
      final response = await http.get(url);
      CustomResponse result = CustomResponse(
          statusCode: response.statusCode,
          data: json.decode(response.body),
          errorMsg: response.statusCode == 200
              ? ""
              : "Oops. A network error has ocurred.");
      return result;
    } catch (e) {
      return CustomResponse(
          statusCode: 404,
          data: null,
          errorMsg: "Oops. A network error has ocurred.");
    }
  }

  Future<CustomResponse> addItemToDataBase({body}) async {
    var url = Uri.https(
        "shopping-list-sl-default-rtdb.firebaseio.com", "shopping-list.json");
    var response = await http.post(url,
        headers: {
          'Content-Type': "application/json",
        },
        body: json.encode(body));

    CustomResponse result = CustomResponse(
        statusCode: response.statusCode,
        data: json.decode(response.body),
        errorMsg: response.statusCode == 200
            ? ""
            : "Oops. A network error has ocurred.");
    return result;
  }

  Future<CustomResponse> removeItemFromDatabase(String id) async {
    var url = Uri.https("shopping-list-sl-default-rtdb.firebaseio.com",
        "shopping-list/$id.json");
    var response = await http.delete(url);
    CustomResponse result = CustomResponse(
        statusCode: response.statusCode,
        data: json.decode(response.body),
        errorMsg: response.statusCode == 200
            ? ""
            : "Oops. A network error has ocurred.");
    return result;
  }
}
