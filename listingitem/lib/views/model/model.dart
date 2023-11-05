class ApiResponse {
  final int statusCode;
  final Data data;
  final String message;
  final bool success;

  ApiResponse({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      statusCode: json['statusCode'],
      data: Data.fromJson(json['data']),
      message: json['message'],
      success: json['success'],
    );
  }
}

class Data {
  final int page;
  final int limit;
  final int totalPages;
  final bool previousPage;
  final bool nextPage;
  final int totalItems;
  final int currentPageItems;
  final List<DataItem> dataItems;

  Data({
    required this.page,
    required this.limit,
    required this.totalPages,
    required this.previousPage,
    required this.nextPage,
    required this.totalItems,
    required this.currentPageItems,
    required this.dataItems,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<DataItem> items = list.map((item) => DataItem.fromJson(item)).toList();

    return Data(
      page: json['page'],
      limit: json['limit'],
      totalPages: json['totalPages'],
      previousPage: json['previousPage'],
      nextPage: json['nextPage'],
      totalItems: json['totalItems'],
      currentPageItems: json['currentPageItems'],
      dataItems: items,
    );
  }
}

class DataItem {
  final String category;
  final double price;
  final String thumbnail;
  final List<String> images;
  final String title;
  final int id;

  DataItem({
    required this.category,
    required this.price,
    required this.thumbnail,
    required this.images,
    required this.title,
    required this.id,
  });

  factory DataItem.fromJson(Map<String, dynamic> json) {
    return DataItem(
      category: json['category'],
      price: json['price'].toDouble(),
      thumbnail: json['thumbnail'],
      images: List<String>.from(json['images']),
      title: json['title'],
      id: json['id'],
    );
  }
}
