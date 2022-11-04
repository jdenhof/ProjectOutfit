import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
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
      throw StateError('missing data for jobId: $documentId');
    }
    final name = data['name'] as String?;
    if (name == null) {
      throw StateError('missing name for jobId: $documentId');
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
