import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:use_case_manager/model/use_case.dart';

const fsUseCaseCollection = "UseCases";
const fsUseCaseActors = "actors";
const fsUseCaseId = "id";
const fsUseCaseProjectId = "project-id";
const fsUseCaseName = "uc-name";
const fsUseCaseProcess = "us-process";

class UseCaseCollectionMngr {
  final CollectionReference _ref;
  static final UseCaseCollectionMngr instance = UseCaseCollectionMngr._privateConstructor();

  UseCaseCollectionMngr._privateConstructor(): _ref = FirebaseFirestore.instance.collection("UseCases");

  Query<UseCase> useCasesForProject(String project) => _ref.orderBy("").where("", isEqualTo: project).withConverter(fromFirestore: (snapshot, _) => UseCase.fromFirestore(doc: snapshot), toFirestore: (useCase, _) => useCase.toMap());
}
