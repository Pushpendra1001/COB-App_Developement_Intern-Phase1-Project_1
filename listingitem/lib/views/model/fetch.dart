import 'dart:convert';

import 'package:listingitem/views/model/model.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> fetchData(String serchingName) async {
  String itemName = "watch";

  itemName = serchingName;

  final response = await http.get(Uri.parse(
      'http://192.168.208.193:8080/api/v1/public/randomproducts?page=1&limit=10&inc=category%2Cprice%2Cthumbnail%2Cimages%2Ctitle%2Cid&query=$itemName'));

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    ApiResponse apiResponse = ApiResponse.fromJson(jsonData);
    return apiResponse;
  } else {
    throw Exception('Failed to load data');
  }
}
