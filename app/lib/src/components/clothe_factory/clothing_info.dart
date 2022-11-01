import 'package:flutter/material.dart';

class ClothingInfoBuilder {
  static const categorys = ['none', 'headwear', 'top', 'bottom', 'footwear'];
  static const headwear = ['none', 'hat', 'scarf'];
  static const top = [
    'none',
    't-shirt',
    'long-sleeve',
    'sweatshirt',
    'dress',
    'sweater',
    'tank top',
    'crew neck',
    'jacket',
    'button down',
    'vest'
  ];

  static const bottom = [
    'none',
    'sweatpants',
    'jeans',
    'shorts',
    'jogger pants',
    'khakis',
    'dress pants'
  ];

  static const footwear = ['none', 'socks', 'sneakers', 'boots', 'dress shoes'];

  static List<DropdownMenuItem<dynamic>> categoryItems() {
    return ClothingInfoBuilder.categorys
        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
        .toList();
  }

  static typeFromCategory(String category) {
    List<String> tmp = [];
    switch (category) {
      case ('headwear'):
        tmp = ClothingInfoBuilder.headwear;
        break;
      case ('top'):
        tmp = ClothingInfoBuilder.top;
        break;
      case ('bottom'):
        tmp = ClothingInfoBuilder.bottom;
        break;
      case ('footwear'):
        tmp = ClothingInfoBuilder.footwear;
        break;
      default:
        tmp = ['none'];
        break;
    }
    return tmp;
  }

  static List<DropdownMenuItem<dynamic>> typeItems(String category) {
    List<String> tmp = typeFromCategory(category);
    return tmp.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList();
  }
}
