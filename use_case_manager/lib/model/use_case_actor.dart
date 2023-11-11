import 'package:use_case_manager/managers/use_case_document_manager.dart';

class Actor {
  String? documentId;
  String _name;
  final String ownerUid;
  final String projectTitle;
  final String useCaseTitle;

  Actor({required String name, required this.projectTitle, required this.useCaseTitle, required this.ownerUid, this.documentId}) : _name = name;

  String get name => _name;

  void setName(String name) {
    _name = name;
  }

  Map<String, Object> toMap() {
    return {
      documentId!: documentId!,
      fsActors_OwnerUid: ownerUid,
      fsActors_ProjectTitle: projectTitle,
      fsActors_UseCaseTitle: useCaseTitle,
      fsActors_Name: _name,
    };
  }
}
