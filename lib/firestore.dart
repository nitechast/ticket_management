import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ticket_management/models/schedule.dart';
import 'package:ticket_management/models/ticket.dart';

class FirestoreHelper {

  static const String paramTickets = "tickets";

  static const String paramSchedules = "schedules";

  static final FirestoreHelper _instance = FirestoreHelper._();

  factory FirestoreHelper() => _instance;

  FirestoreHelper._();

  FirebaseFirestore get db => _db;

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> setTicket(String section, String namespace, Ticket ticket) async {
    db.collection(section).doc(namespace)
        .collection(paramTickets).doc(ticket.code).set(ticket.map);
  }

  Future<List<Ticket>> getTickets(String section, String namespace) async {
    final event = await db.collection(section).doc(namespace)
        .collection(paramTickets).get();
    List<Ticket> results = [];
    for(var doc in event.docs) {
      results.add(Ticket.fromMap(doc as Map<String, dynamic>));
    }
    return results;
  }

  Future<void> setSchedule(String section, String namespace, Schedule schedule) async {
    db.collection(section).doc(namespace)
        .collection(paramSchedules).doc(schedule.code).set(schedule.map);
  }

  Future<List<Schedule>> getSchedule(String section, String namespace) async {
    final event = await db.collection(section).doc(namespace)
        .collection(paramTickets).get();
    List<Schedule> results = [];
    for(var doc in event.docs) {
      results.add(Schedule.fromMap(doc as Map<String, dynamic>));
    }
    return results;
  }

}