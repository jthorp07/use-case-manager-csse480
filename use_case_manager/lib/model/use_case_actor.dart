import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:use_case_manager/managers/use_case_document_manager.dart';
import 'package:use_case_manager/model/firestore_model_utils.dart';

class Actor {
  String? documentId;
  String _name;
  String parentId;

  Actor({required String name, required this.parentId, this.documentId}) : _name = name;
  Actor.fromFirestore({required DocumentSnapshot doc}): this(
    documentId: doc.id,
    name: FirestoreModelUtils.getStringField(doc, fsActors_Name), 
    parentId: FirestoreModelUtils.getStringField(doc, fsParentId),
  );

  String get name => _name;

  void setName(String name) {
    _name = name;
  }

  Map<String, Object> toMap() {
    return {
      documentId!: documentId!,
      fsParentId: parentId,
      fsActors_Name: _name,
    };
  }
}
