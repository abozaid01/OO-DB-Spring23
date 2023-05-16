class CustomerRecentOrderResponse {
  String? status;
  int? results;
  String? message;
  List<Data>? data;

  CustomerRecentOrderResponse(
      {this.status, this.results, this.message, this.data});

  CustomerRecentOrderResponse.fromJson(Map<String, dynamic> json) {
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
  String? customerId;
  String? firstName;
  String? lastName;
  String? orderCount;

  Data({this.customerId, this.firstName, this.lastName});

  Data.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    orderCount = json['order_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    return data;
  }
}