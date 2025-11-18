import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
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
      if (pc.loading.value) return Center(child: CircularProgressIndicator());
      return RefreshIndicator(
        onRefresh: () async => await pc.fetchProducts(),
        child: ListView.builder(
          padding: EdgeInsets.all(8),
          itemCount: pc.products.length,
          itemBuilder: (context, index) {
            final p = pc.products[index];
            final bookmarked = bc.isBookmarked(p.id);
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: ListTile(
                contentPadding: EdgeInsets.all(12),
                leading: Image.network(p.image, width: 64, height: 64),
                title: Text(
                  p.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text('\$${p.price.toString()} — ${p.category}'),
                trailing: IconButton(
                  icon: Icon(
                    bookmarked ? Icons.bookmark : Icons.bookmark_border,
                  ),
                  onPressed: () async {
                    if (bookmarked) {
                      await bc.removeBookmark(p.id);
                    } else {
                      await bc.addBookmark(p);
                    }
                  },
                ),
                onTap: () {
                  Get.to(() => ProductDetailPage(product: p));
                },
              ),
            );
          },
        ),
      );
    });
  }
}
