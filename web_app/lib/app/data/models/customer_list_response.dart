class CustomerListResponse {
  String? status;
  String? message;
  List<Data>? data;

  CustomerListResponse({this.status, this.message, this.data});

  CustomerListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? customerId;
  String? firstName;
  String? lastName;
  int? age;
  String? city;
  String? street;
  String? building;
  String? apartment;
  String? phone;
  String? email;

  Data(
      {this.customerId,
        this.firstName,
        this.lastName,
        this.age,
        this.city,
        this.street,
        this.building,
        this.apartment,
        this.phone,
        this.email});

  Data.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    age = json['age'];
    city = json['city'];
    street = json['street'];
    building = json['building'];
    apartment = json['apartment'];
    phone = json['phone'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customer_id'] = customerId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['age'] = age;
    data['city'] = city;
    data['street'] = street;
    data['building'] = building;
    data['apartment'] = apartment;
    data['phone'] = phone;
    data['email'] = email;
    return data;
  }
}