import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:pas_moobile_11pplg_18/controllers/bookmark_controller.dart';
import 'package:pas_moobile_11pplg_18/pages/product_detail_page.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bc = BookmarkController.to;
    return Obx(() {
      if (bc.bookmarks.isEmpty) return Center(child: Text('No favorites yet'));
      return ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: bc.bookmarks.length,
        itemBuilder: (context, index) {
          final p = bc.bookmarks[index];
          return Card(
            child: ListTile(
              leading: Image.network(p.image, width: 64, height: 64),
              title: Text(
                p.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text('\$${p.price}'),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  await bc.removeBookmark(p.id);
                },
              ),
              onTap: () => Get.to(() => ProductDetailPage(product: p)),
            ),
          );
        },
      );
    });
  }
}
