import 'dart:io';

import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:ootd/app/wardrobe_manager/wardrobe_item_builder/wardrobe_item_creator.dart';
import 'package:ootd/app/wardrobe_manager/wardrobe_item_builder/wardrobe_item_validator.dart';

class WardrobeItem extends Equatable {
  //TODO~Implement tags and secondaryColors
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

  final String id;
  final String wardrobeId;
  final String name;
  final String brand;
  final String category;
  final String type;
  final String tags;
  final String imagePath;

  late XFile? image;

  @override
  List<Object> get props =>
      [id, wardrobeId, name, brand, category, type, tags, imagePath];

  @override
  bool get stringify => true;

  factory WardrobeItem.fromMap(Map<dynamic, dynamic>? value, String id) {
    print("Start");
    if (value == null) {
      throw StateError('missing data for entryId: $id');
    }
    print("Initializer");
    print(value);
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
    print("Item created");
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
