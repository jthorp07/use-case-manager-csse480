import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:use_case_manager/managers/use_case_document_manager.dart';
import 'package:use_case_manager/model/firestore_model_utils.dart';

class FlowStep implements Comparable<FlowStep> {
  String _contents;
  int _index;
  String? documentId;
  String parentId;
  int get index => _index;

  FlowStep(
      {required String contents,
      this.documentId,
      required this.parentId,
      required int index})
      : _contents = contents,
        _index = index;
  FlowStep.fromFirestore({required DocumentSnapshot doc})
      : this(
            contents: FirestoreModelUtils.getStringField(doc, fsFlowSteps_Step),
            documentId: doc.id,
            parentId: FirestoreModelUtils.getStringField(doc, fsParentId),
            index: FirestoreModelUtils.getIntField(doc, fsFlowSteps_Index));

  Map<String, Object> toMap() => {
        fsFlowSteps_Index: _index,
        fsFlowSteps_Step: _contents,
        fsParentId: parentId,
        documentId!: documentId!
      };

  void setStep(String step) {
    _contents = step;
    UseCaseDocumentMngr.instance
        .updateFlowStep(docId: documentId!, contents: step, index: _index);
  }

  void setIndex(int index) {
    _index = index;
    UseCaseDocumentMngr.instance
        .updateFlowStep(docId: documentId!, contents: _contents, index: index);
  }

  String get contents => _contents;

  @override
  int compareTo(FlowStep other) {
    return _index - other.index;
  }
}
