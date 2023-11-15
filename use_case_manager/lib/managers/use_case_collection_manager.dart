import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:use_case_manager/managers/auth_manager.dart';
import 'package:use_case_manager/managers/project_collection_manager.dart';
import 'package:use_case_manager/model/use_case.dart';

const fsUseCase_Collection = "UseCases";
const fsUseCase_Actors = "actors";
const fsUseCase_OwnerUid = "ownerUid";
const fsUseCase_ProjectTitle = "project-title";
const fsUseCase_Title = "uc-name";
const fsUseCase_ProcessName = "us-process";

class UseCaseCollectionMngr {
  final CollectionReference _ref;
  static final UseCaseCollectionMngr instance =
      UseCaseCollectionMngr._privateConstructor();

  UseCaseCollectionMngr._privateConstructor()
      : _ref = FirebaseFirestore.instance.collection("UseCases");

  Future<bool> add({required UseCase useCase}) async {
    if (await instance._hasUseCase(useCase: useCase) == false) {
      instance._ref.add({
        fsUseCase_Title: useCase.title,
        fsUseCase_OwnerUid: AuthManager.instance.uid,
        fsUseCase_ProcessName: useCase.processName,
        fsUseCase_ProjectTitle: ProjectCollectionManager.instance.selected,
      });
      return true;
    }
    return false;
  }

  Future<bool> _hasUseCase({required UseCase useCase}) async {
    return _ref
        .where(fsUseCase_ProjectTitle,
            isEqualTo: ProjectCollectionManager.instance.selected)
        .where(fsUseCase_OwnerUid, isEqualTo: AuthManager.instance.uid)
        .withConverter(
            fromFirestore: (snapshot, _) =>
                UseCase.fromFirestore(doc: snapshot),
            toFirestore: (useCase, _) => useCase.toMap())
        .where(fsUseCase_Title, isEqualTo: useCase.title)
        .get()
        .then(
      (value) {
        return value.size > 0;
      },
    );
  }

  Future<List<UseCase>> get useCasesForCurrentProject => _ref
          .where(fsUseCase_ProjectTitle,
              isEqualTo: ProjectCollectionManager.instance.selected)
          .where(fsUseCase_OwnerUid, isEqualTo: AuthManager.instance.uid)
          .withConverter(
              fromFirestore: (snapshot, _) =>
                  UseCase.fromFirestore(doc: snapshot),
              toFirestore: (useCase, _) => useCase.toMap())
          .get()
          .then((querySnap) {
        return querySnap.docs.map((doc) {
          return doc.data();
        }).toList();
      });
}
