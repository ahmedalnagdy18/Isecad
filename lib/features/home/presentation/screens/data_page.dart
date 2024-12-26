import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iscad/core/common/textfield.dart';
import 'package:iscad/core/extentions/app_extentions.dart';
import 'package:iscad/features/home/presentation/widgets/text_widget.dart';

class DataPage extends StatelessWidget {
  const DataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 20),
                const Text(
                  "البيانات",
                  style: TextStyle(color: Colors.black, fontSize: 24),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      TitleText(title: "الكود"),
                      Divider(),
                      DataText(dataText: "45"),
                    ],
                  ),
                  Column(
                    children: [
                      TitleText(title: "الصنف"),
                      Divider(),
                      DataText(dataText: "اسم الصنف "),
                    ],
                  ),
                  Column(
                    children: [
                      TitleText(title: "الكمية"),
                      Divider(),
                      DataText(dataText: "15"),
                    ],
                  ),
                  Column(
                    children: [
                      TitleText(title: "السعر"),
                      Divider(),
                      DataText(dataText: "1200"),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              height: 1,
              decoration: const BoxDecoration(
                color: Colors.grey,
              ),
            ),
            SizedBox(height: appHight(context, 0.10)),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: appHight(context, 0.50)),
              child: TextFieldWidget(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
