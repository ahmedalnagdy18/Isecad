import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:iscad/features/home/domain/product_model.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart' as zm;
import 'package:printing/printing.dart';

class Printing extends StatefulWidget {
  static const name = 'print';
  final List<Product> products;
  final Map<int, int?> selectedQuantities;
  final Map<int, double> totals;
  const Printing({
    super.key,
    required this.products,
    required this.selectedQuantities,
    required this.totals,
  });

  @override
  State<Printing> createState() => _PrintingState();
}

class _PrintingState extends State<Printing> {
  String? A;

  String? C;
  var focusNode = FocusNode();
  String? B;
  String? D;
  String? E;

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as List<dynamic>?;

    A = arguments?[0] ?? "Unknown";
    B = arguments?[1]?.toString() ?? "0";
    C = arguments?[2]?.toString() ?? "0";
    D = arguments?[3]?.toString() ?? "Unknown";
    E = "Some default value";

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            children: [
              RawKeyboardListener(
                autofocus: true,
                focusNode: focusNode,
                onKey: (event) {
                  if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
                    zm.Printing.layoutPdf(
                        onLayout: (format) =>
                            _generatePdf(format, A!, C!, B!, D!, E!));
                  }
                },
                child: const Text(''),
              ),
              IconButton(
                icon: const Icon(FontAwesomeIcons.arrowLeft),
                onPressed: () {
                  int count = 0;
                  Navigator.of(context).popUntil((_) => count++ >= 1);
                },
              ),
            ],
          ),
        ),
        body: PdfPreview(
          build: (format) => _generatePdf(format, A!, C!, B!, D!, E!),
        ),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String A, String B,
      String C, String D, String E) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_4, compress: true);

    final fonts = await fontFromAssetBundle('lib/assests/EBGaramond-Bold.ttf');
    final ByteData fontData =
        await rootBundle.load("lib/assests/alfont_com_arial-1.ttf");
    final ttf = pw.Font.ttf(fontData);
    final font = pw.Font.ttf(fontData);
    final NumberFormat currencyFormatter = NumberFormat("#,##0", "en_US");
    final double grandTotal =
        widget.totals.values.fold(0.0, (sum, total) => sum + (total));

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Padding(
              padding: const pw.EdgeInsets.symmetric(horizontal: 100),
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                children: [
                  pw.Column(
                    children: [
                      pw.Text(
                        "Isecad",
                        style: const pw.TextStyle(fontSize: 22),
                      ),
                      pw.SizedBox(height: 8),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: List.generate(
                          20,
                          (index) {
                            return pw.Container(
                              width: 15,
                              height: 1,
                              color: (index % 2 == 0)
                                  ? PdfColors.black
                                  : PdfColors.white,
                            );
                          },
                        ),
                      ),
                      pw.SizedBox(height: 12),

                      // Header Row
                      pw.Table(
                        columnWidths: {
                          0: const pw.FlexColumnWidth(1), // No column
                          1: const pw.FlexColumnWidth(3), // Item column
                          2: const pw.FlexColumnWidth(2), // Price column
                          3: const pw.FlexColumnWidth(1), // Qty column
                          4: const pw.FlexColumnWidth(2), // Total column
                        },
                        children: [
                          pw.TableRow(
                            children: [
                              pw.Text("No"),
                              pw.Text("Item"),
                              pw.Text("Price", textAlign: pw.TextAlign.right),
                              pw.Text("Qty", textAlign: pw.TextAlign.center),
                              pw.Text("Total", textAlign: pw.TextAlign.right),
                            ],
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 8),

                      // Table Rows for Items
                      pw.Table(
                        columnWidths: {
                          0: const pw.FlexColumnWidth(1), // No column
                          1: const pw.FlexColumnWidth(3), // Item column
                          2: const pw.FlexColumnWidth(2), // Price column
                          3: const pw.FlexColumnWidth(1), // Qty column
                          4: const pw.FlexColumnWidth(2), // Total column
                        },
                        children: widget.products.asMap().entries.map((entry) {
                          final index = entry.key;
                          final product = entry.value;
                          final quantity =
                              widget.selectedQuantities[index] ?? 0;
                          final totalPrice = widget.totals[index] ?? 0.0;

                          return pw.TableRow(
                            children: [
                              pw.Text("${index + 1}"), // No
                              pw.Text(product.name), // Item
                              pw.Text(currencyFormatter.format(product.price),
                                  textAlign: pw.TextAlign.right), // Price
                              pw.Text('$quantity',
                                  textAlign: pw.TextAlign.center), // Qty
                              pw.Text(currencyFormatter.format(totalPrice),
                                  textAlign: pw.TextAlign.right), // Total
                            ],
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 8),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: List.generate(
                      72,
                      (index) {
                        return pw.Container(
                          width: 4,
                          height: 1,
                          color: (index % 2 == 0)
                              ? PdfColors.black
                              : PdfColors.white,
                        );
                      },
                    ),
                  ),
                  pw.SizedBox(height: 14),
                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(horizontal: 30),
                    child: pw.Row(children: [
                      pw.Text("total"),
                      pw.Spacer(),
                      pw.Text(currencyFormatter.format(grandTotal)),
                    ]),
                  ),
                  pw.SizedBox(height: 18),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: List.generate(
                      72,
                      (index) {
                        return pw.Container(
                          width: 4,
                          height: 1,
                          color: (index % 2 == 0)
                              ? PdfColors.black
                              : PdfColors.white,
                        );
                      },
                    ),
                  ),
                  pw.SizedBox(height: 4),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: List.generate(
                      72,
                      (index) {
                        return pw.Container(
                          width: 4,
                          height: 1,
                          color: (index % 2 == 0)
                              ? PdfColors.black
                              : PdfColors.white,
                        );
                      },
                    ),
                  ),
                  pw.SizedBox(height: 22),
                  pw.Center(
                    child: pw.Text("Thank you!"),
                  ),
                  pw.SizedBox(height: 4),
                  pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Text(
                        "${DateFormat.yMd().format(DateTime.now())}   ${DateFormat.jm().format(DateTime.now())}",
                        style: pw.TextStyle(
                          font: fonts,
                          fontSize: 14,
                        ),
                        textDirection: pw.TextDirection.rtl,
                      ),
                      pw.SizedBox(height: 10),
                    ],
                  )
                ],
              ));
        },
      ),
    );

    return pdf.save();
  }
}
