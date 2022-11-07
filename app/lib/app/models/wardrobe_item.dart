import 'dart:io';

import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:ootd/app/wardrobe_manager/wardrobe_builder/wardrobe_item_creator.dart';

class WardrobeItem extends Equatable {
  //TODO~Implement tags and secondaryColors
  WardrobeItem({
    required this.id,
    required this.wardrobeId,
    required this.name,
    required this.category,
    required this.type,
    required this.imagePath,
    this.image,
  });

  final String id;
  final String wardrobeId;
  final String name;
  final String category;
  final String type;
  late XFile? image;
  final String imagePath;

  @override
  List<Object> get props => [id, wardrobeId, name, category, type, imagePath];

  @override
  bool get stringify => true;

  factory WardrobeItem.fromMap(Map<dynamic, dynamic>? value, String id) {
    if (value == null) {
      throw StateError('missing data for entryId: $id');
    }
    return WardrobeItem(
      id: id,
      wardrobeId: value['wardrobeId'] as String,
      name: value['name'] as String,
      category: value['category'] as String,
      type: value['type'] as String,
      imagePath: value['imagePath'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'wardrobeId': wardrobeId,
      'name': name,
      'category': category,
      'type': type,
      'imagePath': imagePath,
    };
  }

  static WardrobeItem fromValidator(WardrobeItemValidator wardrobeItem) {
    return WardrobeItem.fromMap(
        wardrobeItem.toMap(), DateTime.now().microsecondsSinceEpoch.toString());
  }
}
