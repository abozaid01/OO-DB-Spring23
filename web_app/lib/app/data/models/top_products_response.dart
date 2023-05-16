class TopProductsResponse {
  String? status;
  int? results;
  String? message;
  List<Data>? data;

  TopProductsResponse({this.status, this.results, this.message, this.data});

  TopProductsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    results = json['results'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['results'] = this.results;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? productId;
  String? description;
  String? revenue;

  Data({this.productId, this.description, this.revenue});

  Data.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    description = json['description'];
    revenue = json['revenue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['description'] = this.description;
    data['revenue'] = this.revenue;
    return data;
  }
}