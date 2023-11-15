import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:use_case_manager/managers/project_collection_manager.dart';
import 'package:use_case_manager/model/firestore_model_utils.dart';

class Project {
  String? documentId;
  final String ownerUid;
  final String title;

  Project({required this.ownerUid, required this.title, this.documentId});
  Project.fromFirestore({required DocumentSnapshot snapshot}): 
    this(
      ownerUid: FirestoreModelUtils.getStringField(snapshot, fsProjectCollection_ownerUid), 
      title: FirestoreModelUtils.getStringField(snapshot, fsProjectCollection_title), 
      documentId: snapshot.id,
    );

  // ************************************
  //
  // Getters
  //
  // ************************************

  // ************************************
  //
  // Public Methods
  //
  // ************************************
  Map<String, Object> toMap() {
    return {
      fsProjectCollection_ownerUid: ownerUid,
      fsProjectCollection_title: title,
    };
  }

  // ************************************
  //
  // Private Methods
  //
  // ************************************
}
