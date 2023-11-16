import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:use_case_manager/managers/use_case_document_manager.dart';
import 'package:use_case_manager/model/firestore_model_utils.dart';

class FlowStep {

  String _contents;
  int _index;
  String? documentId;
  String parentId;



  FlowStep({required String contents, this.documentId, required this.parentId, required int index}): _contents = contents, _index = index;
  FlowStep.fromFirestore({required DocumentSnapshot doc}): this(
    contents: FirestoreModelUtils.getStringField(doc, fsFlowSteps_Step),
    documentId: doc.id,
    parentId: FirestoreModelUtils.getStringField(doc, fsParentId),
    index: FirestoreModelUtils.getIntField(doc, fsFlowSteps_Index)
  );

  Map<String, Object> toMap() => {
    fsFlowSteps_Index: _index,
    fsFlowSteps_Step: _contents,
    fsParentId: parentId,
    documentId!: documentId!
  };
}