import 'package:equatable/equatable.dart';
import 'package:ootd/app/wardrobe_manager/wardrobe_item_builder/wardrobe_item_validator.dart';

class OutfitItem extends Equatable {
  // TODO: Implement tags and secondaryColors
  const OutfitItem({
    required this.id,
    required this.name,
    required this.category,
    required this.tags,
    required this.items,
    required this.imagePath,
  });

  final String id;
  final String name;
  final String category;
  final String tags;
  final List<String> items;
  final String imagePath;

  @override
  List<Object> get props => [id, name, category, tags, items, imagePath];

  @override
  bool get stringify => true;

  factory OutfitItem.fromMap(Map<dynamic, dynamic>? value, String id) {
    if (value == null) {
      throw StateError('missing data for entryId: $id');
    }

    OutfitItem item = OutfitItem(
      id: id,
      name: value['name'] as String,
      category: value['category'] as String,
      tags: value['tags'] as String,
      items: (value['items'] as List).map((item) => item as String).toList(),
      imagePath: value['imagePath'] as String,
    );

    return item;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'category': category,
      'tags': tags,
      'items': items,
      'imagePath': imagePath,
    };
  }

  static OutfitItem fromValidator(WardrobeItemValidator wardrobeItem) {
    return OutfitItem.fromMap(
        wardrobeItem.toMap(), DateTime.now().microsecondsSinceEpoch.toString());
  }
}
