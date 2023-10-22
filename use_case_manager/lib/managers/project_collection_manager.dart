import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:use_case_manager/model/use_case.dart';

const fsProjectCollection = "Projects";

class ProjectCollectionManager {

  final CollectionReference _ref;
  String? _projectId;
  static final ProjectCollectionManager instance = ProjectCollectionManager._privateConstructor();

  ProjectCollectionManager._privateConstructor(): _ref = FirebaseFirestore.instance.collection(fsProjectCollection);

  Query<UseCase> useCasesForProject(String project) => _ref.orderBy("").where("", isEqualTo: project).withConverter(fromFirestore: (snapshot, _) => UseCase.fromFirestore(doc: snapshot), toFirestore: (useCase, _) => useCase.toMap());
}