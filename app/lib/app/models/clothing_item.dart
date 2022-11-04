import 'package:equatable/equatable.dart';

class ClothingItem extends Equatable {
  //TODO~Implement tags and secondaryColors
  const ClothingItem({
    required this.id,
    required this.wardrobeId,
    required this.name,
    required this.category,
    required this.type,
    required this.color,
  });

  final String id;
  final String wardrobeId;
  final String name;
  final String category;
  final String type;
  final int color;

  @override
  List<Object> get props => [id, wardrobeId, name, category, type];

  @override
  bool get stringify => true;

  factory ClothingItem.fromMap(Map<dynamic, dynamic>? value, String id) {
    if (value == null) {
      throw StateError('missing data for entryId: $id');
    }
    return ClothingItem(
      id: id,
      wardrobeId: value['wardrobeId'] as String,
      name: value['name'] as String,
      category: value['category'] as String,
      type: value['type'] as String,
      color: value['color'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'wardrobeId': wardrobeId,
      'name': name,
      'category': category,
      'type': type,
      'color': color,
    };
  }
}
