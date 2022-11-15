import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ootd/app/models/outfit_item.dart';
import 'package:ootd/app/services/firestore_services.dart';
import 'package:ootd/app/services/firestore_path.dart';
import 'package:ootd/app/models/wardrobe.dart';
import 'package:ootd/app/models/wardrobe_item.dart';

abstract class Database {
  Future<void> setWardrobe(Wardrobe wardrobe);
  Future<void> deleteWardrobe(Wardrobe wardrobe);
  Stream<List<Wardrobe>> wardrobesStream();
  Future<void> setWardrobeItem(WardrobeItem item);
  Future<void> deleteWardrobeItem(WardrobeItem item);
  Stream<List<WardrobeItem>> wardrobeItemsStream(Wardrobe wardrobe);
}

extension on User {
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
    };
  }
}

class FirestoreDatabase implements Database {
  FirestoreDatabase({required this.uid});
  final String uid;

  final FirestoreService _service = FirestoreService.instance;

  Future<void> newUser(User user) => _service.setData(
        path: FirestorePath.user(uid),
        data: user.toMap(),
      );

  @override
  Future<void> setWardrobe(Wardrobe wardrobe) => _service.setData(
        path: FirestorePath.wardrobe(uid, wardrobe.id),
        data: wardrobe.toMap(),
      );

  @override
  Future<void> deleteWardrobe(Wardrobe wardrobe) => _service.deleteData(
        path: FirestorePath.wardrobe(uid, wardrobe.id),
      );

  @override
  Stream<List<Wardrobe>> wardrobesStream() => _service.collectionStream(
        path: FirestorePath.wardrobes(uid),
        builder: (data, documentId) => Wardrobe.fromMap(data, documentId),
      );

  @override
  Future<void> setWardrobeItem(WardrobeItem item) async {
    _service.setData(
      path: FirestorePath.wardrobeItem(uid, item.id, item.wardrobeId),
      data: item.toMap(),
    );
  }

  @override
  Future<void> deleteWardrobeItem(WardrobeItem item) => _service.deleteData(
      path: FirestorePath.wardrobeItem(uid, item.id, item.wardrobeId));

  @override
  Stream<List<WardrobeItem>> wardrobeItemsStream(Wardrobe? wardrobe) =>
      _service.collectionStream(
        path: FirestorePath.wardrobeItems(uid, wardrobe?.id ?? 'default'),
        builder: (data, documentId) => WardrobeItem.fromMap(data, documentId),
      );

  Stream<List<WardrobeItem>> wardrobeItemsStreamFromCategory(String category) =>
      _service.collectionStream(
          path: FirestorePath.wardrobeItems(uid, 'default'),
          builder: (data, documentId) => WardrobeItem.fromMap(data, documentId),
          queryBuilder: (query) =>
              query.where('category', isEqualTo: category));

  Future<void> setOutfit(OutfitItem outfit) => _service.setData(
        path: FirestorePath.outfit(uid, outfit.id),
        data: outfit.toMap(),
      );

  Stream<List<OutfitItem>> outfitItemsStream() => _service.collectionStream(
      path: FirestorePath.outfits(uid),
      builder: (data, documentId) {
        return OutfitItem.fromMap(data, documentId);
      });
}

  /*
  Future<void> setJob(Job job) => _service.setData(
        path: FirestorePath.job(uid, job.id),
        data: job.toMap(),
      );

  Future<void> deleteJob(Job job) async {
    // delete where entry.jobId == job.jobId
    final allEntries = await entriesStream(job: job).first;
    for (final entry in allEntries) {
      if (entry.jobId == job.id) {
        await deleteEntry(entry);
      }
    }
    // delete job
    await _service.deleteData(path: FirestorePath.job(uid, job.id));
  }

  Stream<Job> jobStream({required String jobId}) => _service.documentStream(
        path: FirestorePath.job(uid, jobId),
        builder: (data, documentId) => Job.fromMap(data, documentId),
      );

  Stream<List<Job>> jobsStream() => _service.collectionStream(
        path: FirestorePath.jobs(uid),
        builder: (data, documentId) => Job.fromMap(data, documentId),
      );

  Future<void> setEntry(Entry entry) => _service.setData(
        path: FirestorePath.entry(uid, entry.id),
        data: entry.toMap(),
      );

  Future<void> deleteEntry(Entry entry) =>
      _service.deleteData(path: FirestorePath.entry(uid, entry.id));

  Stream<List<Entry>> entriesStream({Job? job}) =>
      _service.collectionStream<Entry>(
        path: FirestorePath.entries(uid),
        queryBuilder: job != null
            ? (query) => query.where('jobId', isEqualTo: job.id)
            : null,
        builder: (data, documentID) => Entry.fromMap(data, documentID),
        sort: (lhs, rhs) => rhs.start.compareTo(lhs.start),
      );
      */
