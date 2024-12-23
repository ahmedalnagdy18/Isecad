import 'package:flutter/material.dart';
import 'package:iscad/core/common/textfield.dart';
import 'package:iscad/core/extentions/app_extentions.dart';
import 'package:iscad/features/home/presentation/widgets/list_view_body.dart';
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
                //  crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TitleText(title: "الكود"),
                  TitleText(title: "صاحب البطاقة"),
                  TitleText(title: "عدد الارغفة"),
                  TitleText(title: " اخر سحب"),
                  TitleText(title: "تاريخ"),
                  TitleText(title: "الاذن"),
                  TitleText(title: "الاشتراك"),
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
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                //  crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DataText(dataText: "45"),
                  DataText(dataText: "اسم المستخدم "),
                  DataText(dataText: "15"),
                  DataText(dataText: "5"),
                  DataText(dataText: "40"),
                  DataText(dataText: " 20  اغسطس 12:34"),
                  DataText(dataText: "الاشتراك"),
                ],
              ),
            ),
            SizedBox(height: appHight(context, 0.19)),
            const TextFieldWidget(),
            SizedBox(height: appHight(context, 0.12)),
            Expanded(
              flex: 1,
              child: SizedBox(
                width: appWidth(context, 0.60),
                child: SizedBox(
                  height: 60,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 4.0,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return ListViewBody(
                        title: "${index * 5}",
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
