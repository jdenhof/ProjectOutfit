import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ootd/app/services/camera_service.dart';
import 'package:ootd/app/services/firestore_database.dart';
import 'package:ootd/app/services/storage_database.dart';

// Provider for FirebaseAuth instance
final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

// Camera provider
final cameraProvider = Provider<CameraService>((ref) => CameraService.instance);

// Provider for FirebaseAuth user state changes
final authStateChangesProvider = StreamProvider.autoDispose<User?>(
    (ref) => ref.watch(firebaseAuthProvider).authStateChanges());

// Provider for Firestore database
final databaseProvider = Provider.autoDispose<FirestoreDatabase?>((ref) {
  final auth = ref.watch(authStateChangesProvider);

  if (auth.asData?.value?.uid != null) {
    return FirestoreDatabase(uid: auth.asData!.value!.uid);
  }
  return null;
});

// Provider for Firestore storage of images
final storageProvider = Provider.autoDispose<StorageDatabase?>(
  (ref) {
    final auth = ref.watch(authStateChangesProvider);

    if (auth.asData?.value?.uid != null) {
      return StorageDatabase(uid: auth.asData!.value!.uid);
    } else {
      return null;
    }
  },
);
