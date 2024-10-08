import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ticket_management/models/model.dart';

class FirebaseHelper {

  static const String sectionGlobal = "global";

  static const String sectionPlanetarium = "planetarium";

  static const String namespaceIam = "iam";

  static final FirebaseHelper _instance = FirebaseHelper._();

  factory FirebaseHelper() => _instance;

  FirebaseHelper._();

  FirebaseFirestore get db => _db;

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> set<T extends Model>({
    required String section,
    required String namespace,
    required T data,
  }) async {
    return await db.collection(section).doc(namespace)
        .collection(Model.getParam<T>()).doc(data.uid).set(data.map);
  }

  Future<void> update<T extends Model>({
    required String section,
    required String namespace,
    required T data,
  }) async {
    return await db.collection(section).doc(namespace)
        .collection(Model.getParam<T>()).doc(data.uid).update(data.map);
  }

  Future<void> delete<T extends Model>({
    required String section,
    required String namespace,
    required String uid,
  }) async {
    return await db.collection(section).doc(namespace)
        .collection(Model.getParam<T>()).doc(uid).delete();
  }

  Future<Map<String, dynamic>?> get<T extends Model>({
    required String section,
    required String namespace,
    required String doc,
  }) async {
    final result = await db.collection(section).doc(namespace).collection(Model.getParam<T>()).doc(doc).snapshots().first;
    if (result.data() == null) {
      return null;
    }
    return result.data()!;
  }

  Future<List<Map<String, dynamic>>> gets<T extends Model>({
    required String section,
    required String namespace,
  }) async {
    final event = await db.collection(section).doc(namespace).collection(Model.getParam<T>()).get();
    List<Map<String, dynamic>> results = [];
    for(var doc in event.docs) {
      results.add(doc as Map<String, dynamic>);
    }
    return results;
  }

  Future<UserCredential> signInWithGoogle() async {
    // Create a new provider
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithPopup(googleProvider);
  }
}