import 'package:ootd/app/models/outfit_item.dart';

class FirestorePath {
  // Collections
  static const _users = 'users';
  static const _wardrobes = 'wardrobes';
  static const _outfits = 'outfits';

  // Sub collections
  static const _items = 'items';

  static String user(String uid) => '$_users/$uid';

  // Path to wardrobe document
  static String wardrobe(String uid, String wardrobeId) =>
      '$_users/$uid/$_wardrobes/$wardrobeId';

  // Path to wardobes collection
  static String wardrobes(String uid) => "$_users/$uid/$_wardrobes/";

  // Path to wardrobeItems documents, defaults to to default with no wardrobeId
  static String wardrobeItems(String uid, String wardrobeId) =>
      "$_users/$uid/$_wardrobes/$wardrobeId/$_items/";

  // Path to wardrobe Item, defaults to default with no wardrobeId
  static String wardrobeItem(String uid, String itemId, String? wardrobeId) =>
      '$_users/$uid/$_wardrobes/default/$_items/$itemId';

  // Path to outfits collection
  static String outfits(String uid) => '$_users/$uid/$_outfits/';

  // Path to outfit within outfits
  static String outfit(String uid, outfitId) =>
      '$_users/$uid/$_outfits/$outfitId';

  // Image reference wadrobe items paths for storage
  static String wardrobeImage(String uid, String imagepath) =>
      '/images/$uid/wardrobeItems/$imagepath';
  // Image reference wadrobe items paths for storage
  static String wardrobeImageRef(String uid, String imagepath) =>
      '/images/$uid/wardrobeItems/$imagepath';

  // Image refernce outfit paths for storage
  static String outfitImage(String uid, String imagepath) =>
      'images/$uid/$_outfits/$imagepath';

  static String outfitItemImage(String uid, String wardrobeItemImagePath) =>
      '/images/$uid/wardrobeItems/$wardrobeItemImagePath';

  static String wardrobeItemImages(String uid) => '/images/$uid/wardrobeItems/';
}
