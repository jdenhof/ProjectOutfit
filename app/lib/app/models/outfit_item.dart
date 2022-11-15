import 'dart:io';

import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:ootd/app/wardrobe_manager/wardrobe_item_builder/wardrobe_item_creator.dart';
import 'package:ootd/app/wardrobe_manager/wardrobe_item_builder/wardrobe_item_validator.dart';

class OutfitItem extends Equatable {
  //TODO~Implement tags and secondaryColors
  OutfitItem({
    required this.id,
    required this.name,
    required this.category,
    required this.tags,
    required this.imagePath,
    this.image,
  });

  final String id;
  final String name;
  final String category;
  final String tags;
  final String imagePath;

  late XFile? image;

  @override
  List<Object> get props => [id, name, category, tags, imagePath];

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
      imagePath: value['imagePath'] as String,
    );

    return item;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'category': category,
      'tags': tags,
      'imagePath': imagePath,
    };
  }

  static OutfitItem fromValidator(WardrobeItemValidator wardrobeItem) {
    return OutfitItem.fromMap(
        wardrobeItem.toMap(), DateTime.now().microsecondsSinceEpoch.toString());
  }
}
