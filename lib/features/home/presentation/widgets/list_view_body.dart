import 'package:flutter/material.dart';

class ListViewBody extends StatelessWidget {
  const ListViewBody({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.black,
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}

List<String> titles1 = [
  "استعلام",
  "اضافة",
  "تعديل الكل",
];

List<String> titles2 = [
  "تعديل اخر عملية",
  "تعديل",
  "الاجمالي",
];

  // List pages = [
  //   SelectMicPage(),
  //   OnlineVideosPage(),
  //   EventsPage(),
  //   AboutAsPage(),
  // ];