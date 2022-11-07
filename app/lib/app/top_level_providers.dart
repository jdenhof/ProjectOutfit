import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ootd/app/constants/strings.dart';
import 'package:ootd/app/models/wardrobe_item.dart';
import 'package:ootd/app/services/firestore_database.dart';
import 'package:ootd/app/services/firestore_path.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final cameraProvider = Provider<CameraService>((ref) => CameraService.instance);

class CameraService {
  CameraService._();

  late List<CameraDescription> cameras;
  initializeCameras() async {
    cameras = await availableCameras();
  }

  static final instance = CameraService._();
}

final authStateChangesProvider = StreamProvider.autoDispose<User?>(
    (ref) => ref.watch(firebaseAuthProvider).authStateChanges());

final storageProvider = Provider.autoDispose<StorageDatabase?>(((ref) {
  final auth = ref.watch(authStateChangesProvider);

  if (auth.asData?.value?.uid != null) {
    return StorageDatabase(uid: auth.asData!.value!.uid);
  }
}));

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
      throw UnimplementedError();
    }
  }

  Future<Uint8List?> getWardrobeItemImage(WardrobeItem item) async {
    try {
      const fourMegabyte = 3 * 1024 * 1024;
      return await storageRef
          .child(FirestorePath.wardrobeImageRef(uid, item.imagePath))
          .getData(fourMegabyte);
    } on FirebaseException catch (e) {
      // Handle any errors.
      throw UnimplementedError();
    }
  }
}

final databaseProvider = Provider.autoDispose<FirestoreDatabase?>((ref) {
  final auth = ref.watch(authStateChangesProvider);

  if (auth.asData?.value?.uid != null) {
    return FirestoreDatabase(uid: auth.asData!.value!.uid);
  }
  return null;
});
