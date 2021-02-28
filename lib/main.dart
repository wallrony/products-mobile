import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:products/ui/pages/add_product_page.dart';
import 'package:products/ui/pages/home_page.dart';
import 'package:products/ui/providers/products_provider.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.deepOrange,
      systemNavigationBarColor: Colors.deepOrange,
    ));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductsProvider>(
          create: (context) => new ProductsProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Meus Produtos',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Colors.grey[100],
        ),
        routes: {
          HomePage.routeName: (context) => HomePage(),
          AddProductPage.routeName: (context) => AddProductPage(),
        },
        home: HomePage(),
      ),
    );
  }
}
