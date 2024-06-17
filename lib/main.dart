import 'package:flutter/material.dart';
import 'package:print_as_html/models/products_model.dart';
import 'package:print_as_html/services/main_services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Printing',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Print PDF'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Product product = Product(
      id: 1,
      name: "المنتج الاول",
      price: 99.99,
      priceAfterDiscount: 80.45,
      quantity: 10,
      note: "هذا المنتج يجب الحفاظ عليه",
      createdAt: DateTime.now());
  Product product2 = Product(
      id: 2,
      name: "المنتج الثاني",
      price: 200,
      priceAfterDiscount: 100,
      quantity: 12,
      note: "ملاحظة ٢",
      createdAt: DateTime.now());
  Product product3 = Product(
      id: 3,
      name: "المنتج الثالث",
      price: 250.00,
      priceAfterDiscount: 40.00,
      quantity: 13,
      note: "ملاحظة ٣",
      createdAt: DateTime.now());
  Product product4 = Product(
      id: 4,
      name: "المنتج الرابع",
      price: 125.30,
      priceAfterDiscount: 120.45,
      quantity: 2,
      note: "ملاحظة ٤",
      createdAt: DateTime.now());
  Product product5 = Product(
      id: 5,
      name: "المنتج الخامس",
      price: 350.00,
      priceAfterDiscount: 300.00,
      quantity: 5,
      note: "ملاحظة ٥",
      createdAt: DateTime.now());
  Product product6 = Product(
      id: 6,
      name: "المنتج السادس",
      price: 400.00,
      priceAfterDiscount: 350.00,
      quantity: 7,
      note: "ملاحظة ٦",
      createdAt: DateTime.now());

  List<Product> products = [];

  @override
  void initState() {
    products = [
      product,
      product2,
      product3,
      product4,
      product5,
      product6,
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              ' Number Of Products: ${products.length}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          printOrders(products: products, employeeName: "Abdallah Yassein");
        },
        tooltip: 'Increment',
        child: const Icon(
          Icons.print,
          color: Colors.white,
        ),
      ),
    );
  }
}
