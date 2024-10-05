import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticket_management/models/schedule.dart';
import 'package:ticket_management/models/ticket.dart';
import 'package:ticket_management/models/tickets_state.dart';

final tickets = StateNotifierProvider<TicketsState, List<Ticket>>((ref) {
  return TicketsState(ref);
});

final schedules = StateNotifierProvider<SchedulesState, List<Schedule>>((ref) {
  return SchedulesState(ref);
});