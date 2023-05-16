import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class CustomerTable extends GetView<HomeController> {
  const CustomerTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: DataTable2(
            empty: Center(
              child: Text(
                "No customers",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            headingRowColor: MaterialStateColor.resolveWith(
                  (states) => Colors.blueGrey,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xffEFEFEF)),
              boxShadow: [
                BoxShadow(
                  spreadRadius: 12,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                  color: Colors.black.withOpacity(.01),
                )
              ],
            ),
            columnSpacing: 12,
            horizontalMargin: 12,
            minWidth: 600,
            columns: [
              DataColumn2(
                label: Text(
                  'Customer ID',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'First name',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Last name',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
            rows: controller.customerListResponse.value!.data!
                .asMap()
                .map(
                  (key, data) => MapEntry(
                key,
                DataRow(
                  selected: key % 2 == 0 ? false : true,
                  cells: [
                    DataCell(Text(data.customerId.toString())),
                    DataCell(Text(data.firstName.toString())),
                    DataCell(Text(data.lastName.toString())),
                  ],
                ),
              ),
            )
                .values
                .toList()));
  }
}
