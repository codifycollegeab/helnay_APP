import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  String? id;
  String? title;
  String? body;
  Timestamp? creationDate;
  int? notificationid;

  NoteModel(
      {this.id, this.title, this.body, this.creationDate, this.notificationid});

  NoteModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot["id"];
    title = documentSnapshot['title'];
    body = documentSnapshot["body"];
    creationDate = documentSnapshot["creationDate"];
    notificationid = documentSnapshot['notificationid'];
  }

  NoteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json["body"];
    creationDate = json["creationDate"];
    notificationid = json['notificationid'];
  }
}
