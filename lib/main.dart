import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:iscad/features/home/presentation/screens/all_curd.dart';
import 'package:iscad/features/home/presentation/crud_cuibt/crud_cuibt.dart';
import 'package:iscad/features/authentication/presentation/screens/login_page.dart';
import 'package:iscad/features/home/domain/product_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('userBox');
  Hive.registerAdapter(ProductAdapter());
  await Hive.openBox<Product>('productBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit()..fetchProducts(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Product App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AllProductsPage(),
        // const LoginPage(),
      ),
    );
  }
}
