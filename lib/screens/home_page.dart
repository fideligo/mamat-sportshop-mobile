import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mamatsportshop_mobile/models/left_drawer.dart';
import 'package:mamatsportshop_mobile/screens/add_product.dart';
import '../models/button_item.dart';
import 'package:mamatsportshop_mobile/models/app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: LeftDrawer(),
      backgroundColor: Colors.white,
      appBar: AppBarWidget(title: "Mamat Sportshop"),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                NavigationButton(
                  title: "Add Product",
                  icon: Icons.add,
                  warna: Colors.transparent,
                  route: AddProductPage(),
                ),
                ButtonItem(
                  title: "All Products",
                  icon: Icons.storefront,
                  warna: Colors.transparent,
                ),
                ButtonItem(
                  title: "My Products",
                  icon: Icons.store,
                  warna: Colors.transparent,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
