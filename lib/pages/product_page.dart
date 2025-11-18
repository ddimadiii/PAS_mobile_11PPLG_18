import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas_moobile_11pplg_18/controllers/Products_controller.dart';
import 'package:pas_moobile_11pplg_18/controllers/bookmark_controller.dart';
import 'package:pas_moobile_11pplg_18/pages/product_detail_page.dart';

class ProductsPage extends StatelessWidget {
  final controller = Get.find<ProductsController>();

  @override
  Widget build(BuildContext context) {
    final pc = ProductsController.to;
    final bc = BookmarkController.to;

    return Obx(() {
      if (pc.loading.value) {
        return Center(child: CircularProgressIndicator());
      }

      return RefreshIndicator(
        onRefresh: () async => await pc.fetchProducts(),
        child: ListView.builder(
          padding: EdgeInsets.all(8),
          itemCount: pc.products.length,
          itemBuilder: (context, index) {
            final p = pc.products[index];
            final bookmarked = bc.isBookmarked(p.id);

            return GestureDetector(
              onTap: () {
                Get.to(() => ProductDetailPage(product: p));
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 6),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        p.image,
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            p.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "Rp ${p.price}",
                            style: TextStyle(
                              color: Color(0xFFB8860B),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            p.category,
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    // IconButton(
                    //   icon: Icon(
                    //     bookmarked ? Icons.bookmark : Icons.bookmark_border,
                    //     color: Color(0xFFB8860B),
                    //   ),
                    //   onPressed: () async {
                    //     if (bookmarked) {
                    //       await bc.removeBookmark(p.id);
                    //     } else {
                    //       await bc.addBookmark(p);
                    //     }
                    //   },
                    // ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
