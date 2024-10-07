import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticket_management/firebase.dart';
import 'package:ticket_management/models/schedule.dart';
import 'package:ticket_management/models/ticket.dart';

class TicketsState extends StateNotifier<List<Ticket>> {

  static const String sectionPlanetarium = "planetarium";

  TicketsState(this.ref) : super([]);

  final Ref ref;

  /// Clear state
  void clear() => state = [];

  Future<void> set(String section, String namespace, Ticket ticket) async {
    final client = FirebaseHelper();
    await client.setTicket(section, namespace, ticket);
    get(section, namespace);
  }

  /// Request [T] items fit to [condition] and filter by [options]
  ///
  /// This method overrides [state]
  Future<void> get(String section, String namespace) async {
    final client = FirebaseHelper();
    final List<Ticket> response = await client.getTickets(section, namespace);
    if (response.isEmpty) {
      return;
    }
    state = response;
  }
}

class SchedulesState extends StateNotifier<List<Schedule>> {

  static const String sectionPlanetarium = "planetarium";

  SchedulesState(this.ref) : super([]);

  final Ref ref;

  /// Clear state
  void clear() => state = [];

  Future<void> set(String section, String namespace, Ticket ticket) async {
    final client = FirebaseHelper();
    await client.setTicket(section, namespace, ticket);
    get(section, namespace);
  }

  /// Request [T] items fit to [condition] and filter by [options]
  ///
  /// This method overrides [state]
  Future<void> get(String section, String namespace) async {
    final client = FirebaseHelper();
    final List<Schedule> response = await client.getSchedule(section, namespace);
    if (response.isEmpty) {
      return;
    }
    state = response;
  }
}