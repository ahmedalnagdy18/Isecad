import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:iscad/core/extentions/app_extentions.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart' as zm;
import 'package:printing/printing.dart';

class Printing extends StatefulWidget {
  static const name = 'print';
  final String productName;
  final int quantity;
  final double pricePerUnit;
  final double price;
  const Printing(
      {super.key,
      required this.productName,
      required this.quantity,
      required this.price,
      required this.pricePerUnit});

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
                      pw.Text("Isecad",
                          style: const pw.TextStyle(
                            fontSize: 22,
                          )),
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
                      pw.Row(children: [
                        pw.Text("No"),
                        pw.SizedBox(width: 12),
                        pw.Text("Item"),
                        pw.Spacer(),
                        pw.Text("Price"),
                        pw.SizedBox(width: 12),
                        pw.Text("Qty"),
                        pw.SizedBox(width: 12),
                        pw.Text("Total"),
                      ]),
                      pw.SizedBox(height: 8),
                      pw.ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return pw.Row(children: [
                            pw.Text("${index + 1}"),
                            pw.SizedBox(width: 12),
                            pw.Text(widget.productName),
                            pw.Spacer(),
                            pw.Text(
                                currencyFormatter.format(widget.pricePerUnit)),
                            pw.SizedBox(width: 12),
                            pw.Text('${widget.quantity}'),
                            pw.SizedBox(width: 12),
                            pw.Text(currencyFormatter.format(widget.price)),
                          ]);
                        },
                      )
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
                      pw.Text(currencyFormatter.format(widget.price)),
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
                        DateFormat.yMd().add_jm().format(DateTime.now()),
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
