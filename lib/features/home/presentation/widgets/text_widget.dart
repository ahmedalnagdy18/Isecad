import 'package:flutter/material.dart';
import 'package:iscad/core/colors/app_colors.dart';

class TitleText extends StatelessWidget {
  const TitleText({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class DataText extends StatelessWidget {
  const DataText({super.key, required this.dataText});
  final String dataText;
  @override
  Widget build(BuildContext context) {
    return Text(
      dataText,
      style: TextStyle(
        color: AppColors.redColor,
      ),
    );
  }
}
