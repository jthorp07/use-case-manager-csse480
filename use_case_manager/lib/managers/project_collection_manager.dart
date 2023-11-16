import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:use_case_manager/managers/auth_manager.dart';
import 'package:use_case_manager/model/project.dart';
import 'package:use_case_manager/model/use_case.dart';

const fsProjectCollection = "Projects";
const fsProjectCollection_ownerUid = "ownerUid";
const fsProjectCollection_title = "title";

class ProjectCollectionManager {

  final CollectionReference _ref;
  String? _selectedProjectTitle;
  String? _selectedProjectId;
  static final ProjectCollectionManager instance = ProjectCollectionManager._privateConstructor();

  ProjectCollectionManager._privateConstructor(): _ref = FirebaseFirestore.instance.collection(fsProjectCollection);

  Future<bool> add({required String title}) async {
    if (await instance.hasProject(title: title)) {
      return false;
    }
    _ref.add({
      fsProjectCollection_ownerUid: AuthManager.instance.uid,
      fsProjectCollection_title: title,
    });
    return true;
  }

  Future<bool> hasProject({required String title}) {
    return _ref.where(fsProjectCollection_ownerUid, isEqualTo: AuthManager.instance.uid)
      .withConverter(fromFirestore: (snapshot, _) => Project.fromFirestore(snapshot: snapshot), toFirestore: (project, _) => project.toMap()).where(fsProjectCollection_title, isEqualTo: title).get().then((snapshot) {
      print("Size: ${snapshot.size} >? 0");
      return snapshot.size > 0;
    },);
  }

  void selectProject(Project project) async {
    if (await hasProject(title: project.title)) {
      _selectedProjectTitle = project.title;
      _selectedProjectId = (await selectedProject).documentId;
    }

  }

  String get selected => _selectedProjectTitle ?? "";
  String get selectedId => _selectedProjectId ?? "";
  Future<List<Project>> get allUserProjects => _ref.where(fsProjectCollection_ownerUid, isEqualTo: AuthManager.instance.uid)
  .withConverter(fromFirestore: (snapshot, _) => Project.fromFirestore(snapshot: snapshot), toFirestore: (project, _) => project.toMap())
  .get().then((querySnap) {
    return querySnap.docs.map((doc) {
      return doc.data();
    }).toList();
  },);

  Future<Project> get selectedProject => 
    _ref.where(fsProjectCollection_ownerUid, isEqualTo: AuthManager.instance.uid)
      .where(fsProjectCollection_title, isEqualTo: _selectedProjectTitle)
      .withConverter(fromFirestore: (snapshot, _) => Project.fromFirestore(snapshot: snapshot), toFirestore: (project, _) => project.toMap())
      .get().then((query) {
        return query.docs.first.data();
      });
}