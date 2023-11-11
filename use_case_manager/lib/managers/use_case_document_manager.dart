import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:use_case_manager/managers/auth_manager.dart';
import 'package:use_case_manager/managers/project_collection_manager.dart';
import 'package:use_case_manager/managers/use_case_collection_manager.dart';
import 'package:use_case_manager/model/use_case.dart';
import 'package:use_case_manager/model/use_case_flow.dart';

// Actors Collection Fields
const fsActorsCollection = "Actors";
const fsActors_OwnerUid = "ownerUid";
const fsActors_ProjectTitle = "projectTitle";
const fsActors_UseCaseTitle = "useCaseTitle";
const fsActors_Name = "name";

// Flows Collection Fields
const fsFlowsCollection = "Flows";
const fsFlows_FlowType = "type";
const fsFlows_FlowName = "name";
const fsFlows_OwnerUid = "ownerUid";
const fsFlows_ProjectTitle = "projectTitle";
const fsFlows_UseCaseTitle = "useCaseTitle";

// Flow Steps Collection Fields
const fsFlowStepsCollection = "FlowSteps";
const fsFlowSteps_Index = "stepIndex";
const fsFlowSteps_Step = "step";

class UseCaseDocumentMngr {
  
  // Collection References
  final CollectionReference _ucRef;
  final CollectionReference _actorRef;
  final CollectionReference _flowRef;
  final CollectionReference _flowStepRef;

  // Current Selections
  String? _selectedUseCase;
  String? _selectedFlow;

  UseCaseDocumentMngr._privateConstructor(): 
    _ucRef = FirebaseFirestore.instance.collection(fsUseCase_Collection), 
    _actorRef = FirebaseFirestore.instance.collection(fsActorsCollection), 
    _flowRef = FirebaseFirestore.instance.collection(fsFlowsCollection),
    _flowStepRef = FirebaseFirestore.instance.collection(fsFlowStepsCollection);

  // Use Case methods
  void updateTopLevel({required UseCase useCase}) {
    _ucRef.doc(useCase.documentId).update(useCase.toMap());
  }

  // Actor methods
  void addActor({required String name}) {
    _actorRef.add({
      fsActors_Name: name,
      fsActors_OwnerUid: AuthManager.instance.uid,
      fsActors_ProjectTitle: ProjectCollectionManager.instance.selected,
      fsActors_UseCaseTitle: _selectedUseCase
    });
  }

  // Flow methods
  void addFlow({required FlowType type, required String name}) {
    _flowRef.add({
      fsFlows_FlowName: name,
      fsFlows_FlowType: type.toString(),
      fsFlows_OwnerUid: AuthManager.instance.uid,
      fsFlows_ProjectTitle: ProjectCollectionManager.instance.selected,
      fsFlows_UseCaseTitle: _selectedUseCase
    });
  }

  // Flow step methods
  void addFlowStep({required String step, required int index}) {
    _flowStepRef.add({
      fsFlowSteps_Index: index,
      fsFlowSteps_Step: step,
    });
  }
}
