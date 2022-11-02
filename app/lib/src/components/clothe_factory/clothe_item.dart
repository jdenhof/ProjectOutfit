class ClothingItem {
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

  List<String> tagList = [];
  List<String> get currentTags => tagList;

  void addNewTag(String newTag) {
    if (newTag != '') {
      tagList.add(newTag);
    }
  }

  //Returns true if clothing item contains required components
  //Required Components
  /// name - auto generated if none supplied
  /// category
  /// type
  //TODO ~ Pass invalid reasons to user
  static bool validator(ClothingItem item) {
    if (item.category == null || item.type == 'none') {
      return false;
    }
    if (item.type == null || item.type == 'none') {
      return false;
    }
    item.name ??= "${item.brand ?? ''} ${item.type ?? ''}";

    return true;
  }
}
