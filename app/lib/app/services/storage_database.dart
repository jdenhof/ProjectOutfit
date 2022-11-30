import 'dart:io';
import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ootd/app/models/outfit_item.dart';
import 'package:ootd/app/models/wardrobe_item.dart';
import 'package:ootd/app/services/firestore_path.dart';
import 'package:ootd/app/top_level_providers.dart';

class StorageDatabase {
  StorageDatabase({required this.uid});
  final String uid;
  final storageRef = FirebaseStorage.instance.ref();

  Future<void> addWardrobeItemImage(WardrobeItem item) async {
    final newImageRef =
        storageRef.child(FirestorePath.wardrobeImage(uid, item.imagePath));

    try {
      await newImageRef.putFile(File(item.image!.path));
    } on FirebaseException catch (e) {
      throw FirebaseException(plugin: e.plugin);
    }
  }

  Future<Uint8List?> getWardrobeItemImage(String imagePath) async {
    try {
      const fourMegabyte = 3 * 1024 * 1024;
      return await storageRef
          .child(FirestorePath.wardrobeImageRef(uid, imagePath))
          .getData(fourMegabyte);
    } on FirebaseException catch (e) {
      throw FirebaseException(plugin: e.plugin);
    }
  }

  Future<void> deleteWardrobeItem(WardrobeItem item) async {
    final imageRef =
        storageRef.child(FirestorePath.wardrobeImage(uid, item.imagePath));
    try {
      await imageRef.delete();
    } on FirebaseException catch (e) {
      throw FirebaseException(plugin: e.plugin);
    }
  }

  Future<void> setOutfitImage(XFile image) async {
    final newImageRef = storageRef
        .child(FirestorePath.outfitImage(uid, image.path.split('/').last));

    try {
      await newImageRef.putFile(File(image.path));
    } on FirebaseException catch (e) {
      throw FirebaseException(plugin: e.plugin);
    }
  }

  Future<Uint8List?> getOutfitItemImage(OutfitItem item) async {
    try {
      const fourMegabyte = 3 * 1024 * 1024;
      return await storageRef
          .child(FirestorePath.outfitImage(uid, item.imagePath))
          .getData(fourMegabyte);
    } on FirebaseException catch (e) {
      throw FirebaseException(plugin: e.plugin);
    }
  }

  Future<Uint8List?> getWardrobeItemImagesFromOutfit(WardrobeItem item) async {
    try {
      const fourMegabyte = 3 * 1024 * 1024;
      return await storageRef
          .child(FirestorePath.wardrobeImage(uid, item.imagePath))
          .getData(fourMegabyte);
    } on FirebaseException catch (e) {
      throw FirebaseException(plugin: e.plugin);
    }
  }
}
