import 'package:camera/camera.dart';

class WardrobeItemValidator {
  String? name;
  String get nameLabel => "Name: ${name ?? ''}";

  String? category;
  String get currentCategory => category ?? '';
  String get categoryLabel => "Category: $currentCategory";

  String? type;
  String get typeLabel => "Type: ${type ?? ''}";

  String? brand;
  String get brandLabel => "Brand: ${brand ?? ''}";

  String get tagsLabel {
    String tags = '';
    for (var tag in currentTags) {
      tags == '' ? tags = tag : tags = "$tags, $tag";
    }
    return tags;
  }

  String get tags {
    String tmp = '';
    int index = 0;
    for (var tag in currentTags) {
      if (index == 0) {
        tmp += tag;
      } else {
        tmp += ', $tag';
      }
      index++;
    }
    return tmp;
  }

  List<String> tagList = [];
  List<String> get currentTags => tagList;

  late XFile? image;

  void addNewTag(String newTag) {
    if (newTag != '') {
      tagList.add(newTag);
    }
  }

  void addImage(XFile item) {
    image = item;
  }

  //Returns true if clothing item contains required components
  //Required Components
  /// name - auto generated if none supplied
  /// category
  /// type
  ///
  // TODO: Pass invalid reasons to user
  static bool validator(WardrobeItemValidator item) {
    if (item.category == null || item.type == 'none') {
      return false;
    }
    if (item.type == null || item.type == 'none') {
      return false;
    }

    if (item.image == null) {
      return false;
    }

    item.name ??= "${item.brand ?? ''} ${item.type ?? ''}";

    return true;
  }

  Map<String, dynamic> toMap() {
    if (name != null || name == '') {
      name = '$brand $type';
    }
    return {
      'name': name,
      'wardrobeId': 'default',
      'category': category,
      'type': type,
      'brand': brand,
      'tags': tags,
      'imagePath': image?.path.split('/').last,
    };
  }
}
