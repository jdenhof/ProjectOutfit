import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:ootd/app/wardrobe_manager/wardrobe_item_builder/wardrobe_item_validator.dart';

// ignore: must_be_immutable
class WardrobeItem extends Equatable {
  // TODO: Implement tags and secondaryColors
  WardrobeItem({
    required this.id,
    required this.wardrobeId,
    required this.name,
    required this.brand,
    required this.category,
    required this.type,
    required this.tags,
    required this.imagePath,
    this.image,
  });

  late XFile? image;

  final String id;
  final String wardrobeId;
  final String name;
  final String brand;
  final String category;
  final String type;
  final String tags;
  final String imagePath;

  @override
  List<Object> get props =>
      [id, wardrobeId, name, brand, category, type, tags, imagePath];

  @override
  bool get stringify => true;

  factory WardrobeItem.fromMap(Map<dynamic, dynamic>? value, String id) {
    if (value == null) {
      throw StateError('missing data for entryId: $id');
    }
    WardrobeItem item = WardrobeItem(
      id: id,
      wardrobeId: value['wardrobeId'] as String,
      name: value['name'] as String,
      brand: value['brand'] as String,
      category: value['category'] as String,
      type: value['type'] as String,
      tags: value['tags'] as String,
      imagePath: value['imagePath'] as String,
    );
    return item;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'wardrobeId': wardrobeId,
      'name': name,
      'brand': brand,
      'category': category,
      'type': type,
      'tags': tags,
      'imagePath': imagePath,
    };
  }

  static WardrobeItem fromValidator(WardrobeItemValidator wardrobeItem) {
    return WardrobeItem.fromMap(
        wardrobeItem.toMap(), DateTime.now().microsecondsSinceEpoch.toString());
  }
}
