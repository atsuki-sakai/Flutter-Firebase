import 'package:flutter/material.dart';
import 'package:flutter_firebase/home/models/job.dart';
import 'package:flutter_firebase/service/api_path.dart';
import 'package:flutter_firebase/service/firestore_service.dart';
import 'package:uuid/uuid.dart';

abstract class Database {
  Future<void> setJob(Job job);
  Stream<List<Job>> jobsStream();
}

// TimeベースのUUID　package無し
String documentIdFromCurrentDate() => DateTime.now().toIso8601String();
// UUIDを生成する package必要
final uuid = Uuid();

class FirestoreDatabase implements Database {
  FirestoreDatabase({
    @required this.uid,
  }) : assert(uid != null);
  final String uid;

  // Singleton instance
  final _service = FireStoreService.instance;

  @override
  Future<void> setJob(Job job) => _service.setData(
        // ! job.idを使うことで上書きできる
        path: APIPath.job(uid, job.id),
        data: job.toMap(),
      );
  @override
  Stream<List<Job>> jobsStream() => _service.collectionStream(
        path: APIPath.jobs(uid),
        builder: (data, documentId) => Job.fromMap(
          data,
          documentId,
        ),
      );
}
