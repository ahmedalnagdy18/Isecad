import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:iscad/core/colors/app_colors.dart';
import 'package:iscad/core/extentions/app_extentions.dart';
import 'package:iscad/features/home/domain/quantity_log/quantity_log.dart';
import 'package:iscad/generated/l10n.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class SalesReportPage extends StatelessWidget {
  const SalesReportPage({super.key});

  Future<void> generateExcel(BuildContext context,
      {DateTime? filterDate}) async {
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
          const SnackBar(
              content: Text('No sales data found for the selected date.')),
        );
        return;
      }

      // Create a new Excel document
      final excel = Excel.createExcel();

      // Add a sheet for sales data
      final sheet = excel['Sales Report'];
      sheet.appendRow([
        'Product ID',
        'Product Name',
        'Quantity Sold',
        'Date',
        'Total Price'
      ]);

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          S.of(context).sales_report,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.mainBlue,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: appWidth(context, 0.15)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: appHight(context, 0.25),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ExcelButton(
                      onPressed: () async {
                        // Generate Excel for today
                        final today = DateTime.now();
                        await generateExcel(context, filterDate: today);
                      },
                      text: S.of(context).generate_todays_report,
                    ),
                  ),
                  Expanded(
                    child: ExcelButton(
                      onPressed: () async {
                        // Show date picker and generate Excel for the selected date
                        final selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now(),
                        );
                        if (selectedDate != null) {
                          await generateExcel(context,
                              filterDate: selectedDate);
                        }
                      },
                      text: S.of(context).generate_specific_date_report,
                    ),
                  ),
                ],
              ),
              //  const SizedBox(height: 24),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ExcelButton(
                      onPressed: () async {
                        // Generate Excel for all sales logs
                        await generateExcel(context);
                      },
                      text: S.of(context).generate_all_sales_report,
                    ),
                  ),
                  Expanded(
                    child: ExcelButton(
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      text: S.of(context).back,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExcelButton extends StatelessWidget {
  const ExcelButton({super.key, required this.onPressed, required this.text});
  final void Function() onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: ElevatedButton(
        style: ButtonStyle(
            minimumSize: const WidgetStatePropertyAll(Size.fromHeight(80)),
            backgroundColor: WidgetStatePropertyAll(AppColors.mainBlue),
            shape: WidgetStatePropertyAll(ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(12)))),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
