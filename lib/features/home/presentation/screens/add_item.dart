import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iscad/core/colors/app_colors.dart';
import 'package:iscad/core/common/buttons.dart';
import 'package:iscad/core/common/textfield.dart';
import 'package:iscad/core/extentions/app_extentions.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final TextEditingController _code = TextEditingController();
  final TextEditingController _productName = TextEditingController();
  final TextEditingController _quantity = TextEditingController();
  final TextEditingController _price = TextEditingController();

  bool _isButtonEnabled = false;

  @override
  void dispose() {
    _code.dispose();
    _productName.dispose();
    _quantity.dispose();
    _price.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Form(
          onChanged: _isEnabled,
          child: SingleChildScrollView(
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
                      "اضافة منتج",
                      style: TextStyle(color: Colors.black, fontSize: 24),
                    ),
                  ],
                ),
                SizedBox(height: appHight(context, 0.10)),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: appHight(context, 0.50)),
                  child: TextFieldWidget(
                    mycontroller: _code,
                    label: "الكود",
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: appHight(context, 0.50)),
                  child: TextFieldWidget(
                    mycontroller: _productName,
                    label: "اسم المنتج",
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: appHight(context, 0.50)),
                  child: TextFieldWidget(
                    mycontroller: _quantity,
                    label: "الكمية",
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: appHight(context, 0.50)),
                  child: TextFieldWidget(
                    mycontroller: _price,
                    label: "السعر",
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                    ],
                  ),
                ),
                const SizedBox(height: 60),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: appHight(context, 0.50)),
                  child: ColoredButtonWidget(
                    buttonColor:
                        !_isButtonEnabled ? AppColors.darkGrey : Colors.black,
                    onPressed: _isButtonEnabled
                        ? () {
                            //       print("object");
                          }
                        : null,
                    text: "Add",
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _isEnabled() {
    if (_code.text.isNotEmpty &&
        _productName.text.isNotEmpty &&
        _quantity.text.isNotEmpty &&
        _price.text.isNotEmpty) {
      _isButtonEnabled = true;
      setState(() {});
    } else {
      _isButtonEnabled = false;
      setState(() {});
    }
    setState(() {});
  }
}
