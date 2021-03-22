import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/home/models/job.dart';
import 'package:flutter_firebase/service/api_path.dart';

abstract class Database {
  Future<void> createJob(Job job);
  Stream<List<Job>> jobsStream();
}

class FirestoreDatabase implements Database {
  FirestoreDatabase({
    @required this.uid,
  }) : assert(uid != null);
  final String uid;

  Future<void> createJob(Job job) => _setData(
        path: APIPath.job(uid, 'job_456'),
        data: job.toMap(),
      );
  Stream<List<Job>> jobsStream() {
    final path = APIPath.jobs(uid);
    final reference = FirebaseFirestore.instance.collection(path);
    final snapShots = reference.snapshots();

    return snapShots.map((snapShot) => snapShot.docs.map(
          (snapShot) {
            final data = snapShot.data();
            return data != null
                ? Job(
                    name: data['name'],
                    ratePerHour: data['ratePerHour'],
                  )
                : null;
          },
        ).toList());
  }

  Future<void> _setData({String path, Map<String, dynamic> data}) async {
    final refrence = FirebaseFirestore.instance.doc(path);
    print('path: $path, data: $data');
    await refrence.set(data);
  }
}
