import 'package:flutter/material.dart';
import 'package:iscad/core/extentions/app_extentions.dart';
import 'package:iscad/features/home/presentation/screens/add_item.dart';
import 'package:iscad/features/home/presentation/screens/data_page.dart';
import 'package:iscad/features/home/presentation/widgets/list_view_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: appWidth(context, 0.20),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: appHight(context, 0.25)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                  width: appWidth(context, 0.22),
                  child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          if (index == 0) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DataPage(),
                                ));
                          }
                          if (index == 1) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AddItemPage(),
                                ));
                          }
                        },
                        child: ListViewBody(
                          title: titles1[index],
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 25),
              Expanded(
                flex: 1,
                child: SizedBox(
                  width: appWidth(context, 0.22),
                  child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return ListViewBody(
                        title: titles2[index],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
