class TotalSalesModel {
  String? status;
  int? results;
  String? message;
  List<Data>? data;

  TotalSalesModel({this.status, this.results, this.message, this.data});

  TotalSalesModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? totalSales;

  Data({this.name, this.totalSales});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    totalSales = json['total_sales'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['total_sales'] = this.totalSales;
    return data;
  }
}