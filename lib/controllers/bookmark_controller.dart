import 'package:get/get.dart';
import 'package:pas_moobile_11pplg_18/Helper/database_helper.dart';
import 'package:pas_moobile_11pplg_18/models/model_product.dart';

class BookmarkController extends GetxController {
  static BookmarkController get to => Get.find();
  var bookmarks = [].obs;

  Future loadBookmarks() async {
    final rows = await DatabaseHelper.instance.getBookmarks();
    bookmarks.value = rows
        .map(
          (r) => ModelProduct(
            id: r['id'] as int,
            title: r['title'] ?? '',
            price: (r['price'] is int)
                ? (r['price'] as int).toDouble()
                : (r['price'] as double? ?? 0.0),
            description: r['description'] ?? '',
            category: r['category'] ?? '',
            image: r['image'] ?? '',
          ),
        )
        .toList();
  }

  Future addBookmark(ModelProduct p) async {
    await DatabaseHelper.instance.insertBookmark(
      p.toMap().cast<String, Object?>(),
    );
    await loadBookmarks();
    Get.snackbar('Saved', '${p.title} saved to favorites');
  }

  Future removeBookmark(int id) async {
    await DatabaseHelper.instance.deleteBookmark(id);
    await loadBookmarks();
    Get.snackbar('Removed', 'Removed from favorites');
  }

  bool isBookmarked(int id) {
    return bookmarks.any((b) => b.id == id);
  }
}
