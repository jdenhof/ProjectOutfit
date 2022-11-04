import 'dart:async';
import 'package:ootd/app/services/firestore_services.dart';
import 'package:ootd/app/services/firestore_path.dart';
import 'package:ootd/app/models/wardrobe.dart';
import 'package:ootd/app/models/clothing_item.dart';

abstract class Database {
  Future<void> setWardrobe(Wardrobe wardrobe);
  Future<void> deleteWardrobe(Wardrobe wardrobe);
  Stream<Wardrobe> wardrobeStream(String wardrobeId);
  Stream<List<Wardrobe>> wardrobesStream();
  Future<void> setClothingItem(String wardrobeId, ClothingItem item);
  Future<void> deleteClothingItem(ClothingItem item);
}

class FirestoreDatabase implements Database {
  FirestoreDatabase({required this.uid});
  final String uid;

  final FirestoreService _service = FirestoreService.instance;

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
  Future<void> deleteClothingItem(ClothingItem item) => _service.deleteData(
        path: FirestorePath.clothingItem(uid, item.wardrobeId, item.id),
      );

  @override
  Future<void> setClothingItem(String wardrobeId, ClothingItem item) =>
      _service.setData(
        path: FirestorePath.clothingItem(uid, wardrobeId, item.id),
        data: item.toMap(),
      );

  @override
  Stream<Wardrobe> wardrobeStream(String wardrobeId) => _service.documentStream(
        path: FirestorePath.wardrobe(uid, wardrobeId),
        builder: (data, documentId) => Wardrobe.fromMap(data, documentId),
      );

  @override
  Stream<List<Wardrobe>> wardrobesStream() => _service.collectionStream(
        path: FirestorePath.wardrobes(uid),
        builder: (data, documentId) => Wardrobe.fromMap(data, documentId),
      );

  currentWardrobe() {}

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
}
