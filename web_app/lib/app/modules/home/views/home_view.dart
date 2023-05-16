import 'package:adv_database/app/modules/home/views/top_products_table.dart';
import 'package:adv_database/app/modules/home/views/total_sales_table.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'customer_min_order_table.dart';
import 'customer_table.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Presented to Dr. Heba ElNemr',
            textAlign: TextAlign.center,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                color: Colors.blueGrey,
                child: Center(
                  child: Text(
                    "Advanced Database Project",
                    style: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              Obx(
                () => Container(
                  height: controller.noResponse() ? Get.height * 0.8 : Get.height * 0.15,
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (!controller.noInputRequired())
                                  SizedBox(
                                    width: Get.width * 0.2,
                                    child: Form(
                                      key: controller.formKey,
                                      child: TextFormField(
                                        validator: (value){
                                          if(value == null || value.isEmpty){
                                            return "Enter query parameter";
                                          }
                                          return null;
                                        },
                                        controller: controller.queryController,
                                        decoration: InputDecoration(
                                          labelText: controller.labelText.value,
                                          hintText: "",
                                          fillColor: Colors.white,
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8.0),
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8.0),
                                            borderSide: BorderSide(
                                              color: Colors.grey.withOpacity(0.7),
                                              width: 2.0,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.red),
                                              borderRadius: BorderRadius.circular(8)),
                                          focusedErrorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.red),
                                              borderRadius: BorderRadius.circular(8)),

                                        ),
                                      ),
                                    ),
                                  ),
                                SizedBox(
                                  width: 10,
                                ),
                                Obx(() {
                                  return Container(
                                    width: Get.width * 0.2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        DropdownButtonHideUnderline(
                                          child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8),
                                                border: Border.all(color: Colors.grey.withOpacity(0.7))),
                                            child: DropdownButton2<int>(
                                              hint: Text(
                                                "Query",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Theme.of(context).hintColor,
                                                ),
                                              ),
                                              isDense: true,
                                              isExpanded: true,
                                              items: [
                                                DropdownMenuItem<int>(
                                                    value: null,
                                                    child: Text(
                                                      "Query",
                                                      maxLines: 1,
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                    )),
                                                ...controller.queries
                                                    .asMap()
                                                    .map((key, data) => MapEntry(
                                                        key,
                                                        DropdownMenuItem<int>(
                                                            value: key,
                                                            child: Text(
                                                              data,
                                                              maxLines: 1,
                                                              style: const TextStyle(
                                                                fontSize: 12,
                                                              ),
                                                            ))))
                                                    .values
                                                    .toList(),
                                              ],
                                              value: controller.pickedQuery.value,
                                              onChanged: (newValue) {
                                                controller.changeQuery(newValue);
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          ElevatedButton(onPressed: () => controller.performQuery(), child: Text("Query"))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Obx(() {
                if (!controller.noResponse())
                  return SizedBox(
                    width: Get.width * 0.8 - 40,
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueGrey, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text("Results: ${controller.noOfResults}"),
                        ),
                        Spacer(),
                      ],
                    ),
                  );
                return SizedBox();
              }),
              Obx(() {
                if (controller.customerListResponse.value != null)
                  return SizedBox(
                      width: Get.width * 0.8,
                      height: Get.height * 0.8,
                      child: controller.pickedQuery.value == 0 ? CustomerMinOrderTable() : CustomerTable());
                return SizedBox();
              }),
              Obx(() {
                if (controller.topProductsResponse.value != null)
                  return SizedBox(width: Get.width * 0.8, height: Get.height * 0.8, child: TopProductsTable());
                return SizedBox();
              }),
              Obx(() {
                if (controller.totalSalesResponse.value != null)
                  return SizedBox(width: Get.width * 0.8, height: Get.height * 0.8, child: TotalSalesTable());
                return SizedBox();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
