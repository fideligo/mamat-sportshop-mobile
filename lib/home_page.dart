import 'package:flutter/material.dart';
import 'models/ButtonItem.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Mamat Sportshop",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),),
        backgroundColor: Color(0xFF07141E).withOpacity(0.9),
      ),
      body: Column(
        children: [
          ButtonItem(title: "Create Products", icon: Icons.add_box, warna: Colors.redAccent,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonItem(title: "All Products", icon: Icons.shopping_bag, warna: Color(0xFF377DFF),),
              ButtonItem(title: "My Products", icon: Icons.shopping_bag_outlined, warna: Color(0xFF38CB89),),
            ],
          ),
        ],
      ),
    );
  }
}
