class FirestorePath {
  static String wardrobe(String uid, String wardrobeId) =>
      'users/$uid/wardrobes/$wardrobeId';
  static String wardrobes(String uid) => 'users/$uid/wardrobes';
  static String clothingItem(String uid, String wardrobeId, String itemId) =>
      'users/$uid/wardrobes/$wardrobeId/items/$itemId';
  static String outfits(String uid) => 'users/$uid/outfits';
  static String outfit(String uid, outfitId) => 'users/$uid/outfits/$outfitId';
}
