import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class TopProductsTable extends GetView<HomeController> {
  const TopProductsTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: DataTable2(
            empty: Center(
              child: Text(
                "No products",
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
                  'Product ID',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn2(
                label: Text(
                  'Description',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                size: ColumnSize.L
              ),
              DataColumn2(
                label: Text(
                  'Revenue',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
            rows: controller.topProductsResponse.value!.data!
                .asMap()
                .map(
                  (key, data) => MapEntry(
                key,
                DataRow(
                  selected: key % 2 == 0 ? false : true,
                  cells: [
                    DataCell(Text(data.productId.toString())),
                    DataCell(Text(data.description.toString())),
                    DataCell(Text(data.revenue.toString())),
                  ],
                ),
              ),
            )
                .values
                .toList()));
  }
}
