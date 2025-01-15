import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:iscad/features/home/domain/quantity_log/quantity_log.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';


class SalesReportPage extends StatelessWidget {
  const SalesReportPage({Key? key}) : super(key: key);

  Future<void> generateExcel(BuildContext context, {DateTime? filterDate}) async {
    try {
      final salesLogBox = Hive.box<QuantityLog>('quantityLogBox');
      final salesLogs = salesLogBox.values.toList();

      final filteredLogs = filterDate != null
          ? salesLogs.where((log) {
              return log.timestamp.year == filterDate.year &&
                  log.timestamp.month == filterDate.month &&
                  log.timestamp.day == filterDate.day;
            }).toList()
          : salesLogs;

      if (filteredLogs.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No sales data found for the selected date.')),
        );
        return;
      }

      // Create a new Excel document
      final excel = Excel.createExcel();

      // Add a sheet for sales data
      final sheet = excel['Sales Report'];
      sheet.appendRow(['Product ID', 'Product Name', 'Quantity Sold', 'Date', 'Total Price']);

      // Populate the sheet with filtered sales data
      for (var log in filteredLogs) {
        sheet.appendRow([
          log.productId,
          log.productName,
          log.soldQuantity,
          log.timestamp.toIso8601String(),
          log.totalPrice
        ]);
      }

      // Save the Excel file
      final directory = await getApplicationDocumentsDirectory();
      final fileName = filterDate != null
          ? 'sales_report_${filterDate.year}_${filterDate.month}_${filterDate.day}.xlsx'
          : 'sales_report_all.xlsx';
      final filePath = '${directory.path}/$fileName';
      final fileBytes = excel.save();
      final file = File(filePath);
      await file.writeAsBytes(fileBytes!);

      // Notify the user of success
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sales report saved to $filePath')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to generate report: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sales Report')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                // Generate Excel for today
                final today = DateTime.now();
                await generateExcel(context, filterDate: today);
              },
              child: Text('Generate Today\'s Report'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Show date picker and generate Excel for the selected date
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                );
                if (selectedDate != null) {
                  await generateExcel(context, filterDate: selectedDate);
                }
              },
              child: Text('Generate Report for a Specific Date'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Generate Excel for all sales logs
                await generateExcel(context);
              },
              child: Text('Generate All Sales Report'),
            ),
          ],
        ),
      ),
    );
  }
}
