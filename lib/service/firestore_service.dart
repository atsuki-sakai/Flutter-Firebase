import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FireStoreService {
  // - TODO : Singleton Class
  FireStoreService._();
  static final instance = FireStoreService._();

  Future<void> setData({String path, Map<String, dynamic> data}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    print('path: $path, data: $data');
    await reference.set(data);
  }

  Stream<List<T>> collectionStream<T>({
    @required String path,
    @required T Function(Map<String, dynamic> data, String documentId) builder,
  }) {
    final reference = FirebaseFirestore.instance.collection(path);
    final snapShots = reference.snapshots();
    return snapShots.map((snapShot) => snapShot.docs
        .map((snapShot) => builder(snapShot.data(), snapShot.id))
        .toList());
  }
}
