import 'dart:convert';

import 'package:adv_database/app/data/models/customer_list_response.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/models/customer_recent_order_response.dart';
import '../../../data/models/top_products_response.dart';
import '../../../data/models/total_sales_model.dart';
import '../../../data/providers/customers_provider.dart';

class HomeController extends GetxController {
  Rx<CustomerRecentOrderResponse?> customerListResponse = Rx(null);
  Rx<TopProductsResponse?> topProductsResponse = Rx(null);
  Rx<TotalSalesModel?> totalSalesResponse = Rx(null);
  CustomersProvider customerProvider = Get.find<CustomersProvider>();
  TextEditingController queryController = TextEditingController();
  List<String> queries = [
   "Customer with minimum orders",
   "Customer made order in specific timeframe",
   "Top N products",
    "Top categories by sales",
    "Top categories by quantities",
  ];
  Rx<String> labelText = Rx('');
  Rx<int?> pickedQuery = Rx(null);
  Rx<int?> noOfResults = Rx(null);
  final formKey = GlobalKey<FormState>();

  performQuery() async {
    BotToast.showLoading();
    if(noInputRequired() || formKey.currentState!.validate())
    {
      var response = await http.get(getUrl());
      if (pickedQuery.value == 2) {
        topProductsResponse.value = TopProductsResponse.fromJson(jsonDecode(response.body));
      } else if (pickedQuery.value == 3 || pickedQuery.value == 4) {
        totalSalesResponse.value = TotalSalesModel.fromJson(jsonDecode(response.body));
      } else {
        customerListResponse.value = CustomerRecentOrderResponse.fromJson(jsonDecode(response.body));
      }
    }
    setNumOfResults();
    BotToast.closeAllLoading();
  }

  @override
  void onInit() async {
    super.onInit();
  }

  changeQuery(value){
    print("Value: $value");
    customerListResponse.value = null;
    topProductsResponse.value = null;
    totalSalesResponse.value = null;
    pickedQuery.value = value;
    getLabelText();
  }
  getUrl(){
    if(pickedQuery.value == null){

    }
    else if(pickedQuery.value == 0){

      return Uri.parse("http://localhost:3000/customers?min_order=${queryController.text}");
    }else if(pickedQuery.value == 1){
      return Uri.parse("http://localhost:3000/customers/recent-orders?days=${queryController.text}");
    }else if(pickedQuery.value == 2){
      return Uri.parse("http://localhost:3000/products?top=${queryController.text}");
    } else if(pickedQuery.value == 3){
      return Uri.parse("http://localhost:3000/category/total-sales");
    } else if(pickedQuery.value == 4){
      return Uri.parse("http://localhost:3000/category/total-sales-quantity");
    }
  }
  getLabelText(){
    if(pickedQuery.value == null){
      labelText.value = "";
    }
    else if(pickedQuery.value == 0){

      labelText.value= "Minimum orders";
    }else if(pickedQuery.value == 1){
      labelText.value= "Days";
    }else if(pickedQuery.value == 2){
      labelText.value= "Top N";
    }
    else{
      labelText.value = "";
    }
  }
  noResponse(){
    return (customerListResponse.value == null) && (topProductsResponse.value == null) && (totalSalesResponse.value == null);
  }

  noInputRequired(){
    return (pickedQuery.value == 3) || (pickedQuery.value == 4);
  }
  setNumOfResults(){
    if(customerListResponse.value != null){
      noOfResults.value = customerListResponse.value!.results;
    }else if(topProductsResponse.value != null){
      noOfResults.value = topProductsResponse.value!.results;
    }
    else if(totalSalesResponse.value != null){
      noOfResults.value = totalSalesResponse.value!.results;
    }
  }
}
