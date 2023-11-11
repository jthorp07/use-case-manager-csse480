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
  static final ProjectCollectionManager instance = ProjectCollectionManager._privateConstructor();

  ProjectCollectionManager._privateConstructor(): _ref = FirebaseFirestore.instance.collection(fsProjectCollection);

  Future<bool> add({required Project project}) async {
    if (await instance.hasProject(title: project.title)) {
      return false;
    }
    _ref.add({
      fsProjectCollection_ownerUid: project.ownerUid,
      fsProjectCollection_title: project.title,
    });
    return true;
  }

  Future<bool> hasProject({required String title}) {
    return allUserProjects.where(fsProjectCollection_title, isEqualTo: title).get().then((snapshot) {
      print("Size: ${snapshot.size} >? 0");
      return snapshot.size > 0;
    },);
  }

  void selectProject(Project project) async {
    if (await hasProject(title: project.title)) {
      _selectedProjectTitle = project.title;
    }
  }

  String get selected => _selectedProjectTitle ?? "";
  Query<Project> get allUserProjects => _ref.where(fsProjectCollection_ownerUid, isEqualTo: AuthManager.instance.uid).withConverter(fromFirestore: (snapshot, _) => Project.fromFirestore(snapshot: snapshot), toFirestore: (project, _) => project.toMap());
}