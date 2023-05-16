import 'package:get/get.dart';

import '../models/customer_recent_order_response.dart';

class CustomersProvider extends GetConnect {

  Future<Response<CustomerRecentOrderResponse>> getCity() => get<CustomerRecentOrderResponse>(
      "localhost:3000/customers/recent-orders?days=30",
    headers: {"Accept": "*/*"},

  );


}
