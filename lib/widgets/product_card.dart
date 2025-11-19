import 'package:flutter/material.dart';
import 'package:mamatsportshop_mobile/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductCard({
    Key? key,
    required this.product,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fields = product.fields;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        // gunakan warna putih agar mirip desain modern
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE AREA
            AspectRatio(
              aspectRatio: 1, // membuat kotak gambar (sesuai foto)
              child: Stack(
                children: [
                  // background gambar (placeholder jika thumbnail null)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      child:
                          fields.thumbnail != null &&
                              fields.thumbnail!.isNotEmpty
                          ? Image.network(
                              fields.thumbnail!,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const Center(
                                child: Icon(
                                  Icons.checkroom,
                                  size: 48,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          : Container(
                              color: Colors.grey[50],
                              child: const Center(
                                child: Icon(
                                  Icons.checkroom,
                                  size: 56,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                    ),
                  ),

                  // BADGE TOP-LEFT if featured
                  if (fields.isFeatured)
                    Positioned(
                      left: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Text(
                          'FEATURED',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.4,
                            fontSize: 10
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // PADDING: rating, title, price
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${fields.brand} - ${fields.name}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    // format sederhana harga, kamu bisa pakai intl jika mau
                    'Rp ${fields.price.toString()}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
