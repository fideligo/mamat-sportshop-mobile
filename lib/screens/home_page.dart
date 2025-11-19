import 'package:flutter/material.dart';
import 'package:mamatsportshop_mobile/widgets/left_drawer.dart';
import 'package:mamatsportshop_mobile/screens/add_product.dart';
import 'package:mamatsportshop_mobile/widgets/button_item.dart';
import 'package:mamatsportshop_mobile/widgets/app_bar.dart';
import 'product_details.dart';

import 'package:mamatsportshop_mobile/models/product.dart';
import 'package:mamatsportshop_mobile/widgets/product_card.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = 'All';
  int selectedNavIndex = 0;

  // fetchProduct seperti yang sudah kamu buat
  Future<List<Product>> fetchProduct(CookieRequest request) async {
    // Tentukan URL berdasarkan kategori yang dipilih
    String url = 'http://10.0.2.2:8000/json/';

    if (selectedCategory == 'My') {
      url = 'http://10.0.2.2:8000/json-my/';
    }
    final response = await request.get(url);

    List<Product> productList = [];
    for (var data in response) {
      if (data != null) {
        productList.add(Product.fromJson(data));
      }
    }
    return productList;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      drawer: const LeftDrawer(),
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBarWidget(title: "Mamat Sportshop"),
      body: FutureBuilder<List<Product>>(
        future: fetchProduct(request),
        builder: (context, snapshot) {
          // sedang menunggu response
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // error handling sederhana
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // data ada tapi kosong
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'There are no products yet.',
                style: TextStyle(fontSize: 18, color: Color(0xff59A5D8)),
              ),
            );
          }

          // data tersedia -> bangun UI utama menggunakan CustomScrollView + SliverGrid
          final products = snapshot.data!;

          return CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 20)),

              // Horizontal buttons (Add, All Products, etc.)
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 64,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    scrollDirection: Axis.horizontal,
                    children: [
                      ButtonItem(
                        title: "Add Product",
                        icon: Icons.add,
                        warna: Colors.transparent,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AddProductPage(),
                            ),
                          );
                        },
                      ),
                      // Potongan kode yang sudah ada di home_page.dart Anda (tidak perlu diubah, hanya verifikasi):
                      ButtonItem(
                        title: "All Products",
                        icon: Icons.storefront,
                        warna: selectedCategory == 'All'
                            ? const Color(0xFFD1E7DD)
                            : Colors
                                  .transparent, // Opsional: Tambahkan highlight warna
                        onTap: () {
                          setState(() {
                            selectedCategory = 'All';
                          });
                        },
                      ),
                      ButtonItem(
                        title: "My Products",
                        icon: Icons.store,
                        warna: selectedCategory == 'My'
                            ? const Color(0xFFD1E7DD)
                            : Colors
                                  .transparent, // Opsional: Tambahkan highlight warna
                        onTap: () {
                          setState(() {
                            selectedCategory = 'My';
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 12)),

              // Grid produk: 2 kolom (dari data fetched)
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 8,
                ),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final product = products[index];

                    return ProductCard(
                      product: product,
                      onTap: () {
                        // optional: buka detail, atau tampilkan snackbar
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailsPage(product: product),
                          ),
                        );
                      },
                    );
                  }, childCount: products.length),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.62,
                  ),
                ),
              ),

              // bottom spacing
              const SliverToBoxAdapter(child: SizedBox(height: 48)),
            ],
          );
        },
      ),
    );
  }
}
