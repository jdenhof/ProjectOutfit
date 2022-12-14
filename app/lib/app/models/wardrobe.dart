import 'package:equatable/equatable.dart';

class Wardrobe extends Equatable {
  const Wardrobe({
    required this.id,
    required this.name,
  });
  final String id;
  final String name;

  @override
  List<Object> get props => [
        id,
        name,
      ];

  @override
  bool get stringify => true;

  factory Wardrobe.fromMap(Map<String, dynamic>? data, String documentId) {
    if (data == null) {
      throw StateError('missing data for wardrobeId: $documentId');
    }
    final name = data['name'] as String?;
    if (name == null) {
      throw StateError('missing name for wardrobeId: $documentId');
    }
    return Wardrobe(
      id: documentId,
      name: name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }
}
