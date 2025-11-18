
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:pas_moobile_11pplg_18/controllers/bookmark_controller.dart';
import 'package:pas_moobile_11pplg_18/models/model_product.dart';

class ProductDetailPage extends StatelessWidget {
  final ModelProduct product;
  ProductDetailPage({required this.product});

  @override
  Widget build(BuildContext context) {
    final bc = BookmarkController.to;
    return Scaffold(
      appBar: AppBar(title: Text('Detail')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.network(product.image, height: 200)),
            SizedBox(height: 12),
            Text(product.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('\$${product.price.toString()}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 12),
            Text(product.description),
            SizedBox(height: 20),
            Obx(() {
              final isB = bc.isBookmarked(product.id);
              return ElevatedButton.icon(
                onPressed: () async {
                  if (isB) await bc.removeBookmark(product.id);
                  else await bc.addBookmark(product);
                },
                icon: Icon(isB ? Icons.bookmark : Icons.bookmark_border),
                label: Text(isB ? 'Remove Favorite' : 'Save Favorite'),
              );
            })
          ],
        ),
      ),
    );
  }
}