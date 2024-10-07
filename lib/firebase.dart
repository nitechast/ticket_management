import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ticket_management/models/model.dart';

class FirebaseHelper {

  static const String sectionPlanetarium = "planetarium";

  static const String paramTickets = "tickets";

  static const String paramSchedules = "schedules";

  static final FirebaseHelper _instance = FirebaseHelper._();

  factory FirebaseHelper() => _instance;

  FirebaseHelper._();

  Future<UserCredential> signInWithGoogle() async {
    // Create a new provider
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithPopup(googleProvider);
  }

  FirebaseFirestore get db => _db;

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> set<T extends Model>({
    required String section,
    required String namespace,
    required T data,
  }) async {
    return await db.collection(section).doc(namespace)
        .collection(Model.getParam<T>()).doc(data.code).set(data.map);
  }

  Future<List<T>> get<T extends Model>({
    required String section,
    required String namespace,
  }) async {
    final event = await db.collection(section).doc(namespace).collection(Model.getParam<T>()).get();
    List<T> results = [];
    for(var doc in event.docs) {
      results.add(Model.fromMap(doc as Map<String, dynamic>) as T);
    }
    return results;
  }
}