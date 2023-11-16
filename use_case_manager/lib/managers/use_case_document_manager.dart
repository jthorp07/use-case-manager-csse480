import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:use_case_manager/managers/auth_manager.dart';
import 'package:use_case_manager/managers/project_collection_manager.dart';
import 'package:use_case_manager/managers/use_case_collection_manager.dart';
import 'package:use_case_manager/model/use_case.dart';
import 'package:use_case_manager/model/use_case_actor.dart';
import 'package:use_case_manager/model/use_case_flow.dart';

// General Fields
const fsParentId = "parentId";
const fsOwnerId = "ownerUid";

// Actors Collection Fields
const fsActorsCollection = "Actors";
const fsActors_Name = "name";

// Flows Collection Fields
const fsFlowsCollection = "Flows";
const fsFlows_FlowType = "type";
const fsFlows_FlowName = "name";

// Flow Steps Collection Fields
const fsFlowStepsCollection = "FlowSteps";
const fsFlowSteps_Index = "stepIndex";
const fsFlowSteps_Step = "step";

class UseCaseDocumentMngr {

  static final instance = UseCaseDocumentMngr._privateConstructor();
  
  // Collection References
  final CollectionReference _ucRef;
  final CollectionReference _actorRef;
  final CollectionReference _flowRef;
  final CollectionReference _flowStepRef;

  // Current Selections
  String? _selectedUseCase;
  String? _selectedFlow;

  UseCase? _currentUseCase;

  UseCaseDocumentMngr._privateConstructor(): 
    _ucRef = FirebaseFirestore.instance.collection(fsUseCase_Collection), 
    _actorRef = FirebaseFirestore.instance.collection(fsActorsCollection), 
    _flowRef = FirebaseFirestore.instance.collection(fsFlowsCollection),
    _flowStepRef = FirebaseFirestore.instance.collection(fsFlowStepsCollection);

  // Use Case methods
  Future<UseCase?> selectUseCase({required String docId}) {
    _selectedUseCase = docId;
    return _ucRef.doc(docId).withConverter(fromFirestore: (doc, _) => UseCase.fromFirestore(doc: doc), toFirestore: (uc, _) => uc.toMap()).get().then((doc) {
      UseCase? uc = doc.data();
      _currentUseCase = uc;
      return uc;
    });
  }

  void updateTopLevel({required UseCase useCase}) {
    _ucRef.doc(useCase.documentId).update({
      fsUseCase_Title: useCase.title,
      fsUseCase_ProcessName: useCase.processName,
    });
  }

  Future<UseCase?> get currentUseCase async {
    if (_currentUseCase == null) {
      return _ucRef.doc(_selectedUseCase ?? "").withConverter(fromFirestore: (doc, _) => UseCase.fromFirestore(doc: doc), toFirestore: (uc, _) => uc.toMap()).get().then((doc) => doc.data());
    } else {
      return _currentUseCase;
    }
  } 

  // Actor methods
  void addActor({required String name}) {
    _actorRef.add({
      fsActors_Name: name,
      fsParentId: _currentUseCase!.documentId,
    });
  }

  Future<List<Actor>> get ucActors {
    return _actorRef
      .where(fsParentId, isEqualTo: _selectedUseCase)
      .withConverter(fromFirestore: (doc, _) => Actor.fromFirestore(doc: doc), toFirestore: (actor, _) => actor.toMap())
      .get().then((query) {
        return query.docs.map((doc) {
          return doc.data();
        }).toList();
      });
  }
    

  // Flow methods
  void addFlow({required FlowType type, required String name}) async {
    _flowRef.add({
      fsFlows_FlowName: name,
      fsFlows_FlowType: type.toString(),
      fsParentId: _selectedUseCase
    });
  }

  // Flow step methods
  void addFlowStep({required String step, required int index}) {
    _flowStepRef.add({
      fsFlowSteps_Index: index,
      fsFlowSteps_Step: step,
      fsParentId: _selectedFlow
    });
  }
}
