import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticket_management/models/schedule.dart';
import 'package:ticket_management/models/ticket.dart';
import 'package:ticket_management/models/state.dart';

final tickets = StateNotifierProvider<ModelsState<Ticket>, List<Ticket>>((ref) {
  return ModelsState<Ticket>(ref);
});

final schedules = StateNotifierProvider<ModelsState<Schedule>, List<Schedule>>((ref) {
  return ModelsState<Schedule>(ref);
});