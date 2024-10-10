import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticket_management/models/schedule.dart';
import 'package:ticket_management/models/ticket.dart';
import 'package:ticket_management/provider.dart' as provider;
import 'package:ticket_management/cards/schedule_card.dart';

final _schedules = Provider<List<Schedule>>((ref) {
  final data = ref.watch(provider.schedules);
  data.sort((a, b) {
    return a.datetime.compareTo(b.datetime);
  });
  return data;
});

final _tickets = Provider<Map<String, List<Ticket>>>((ref) {
  final Map<String, List<Ticket>> map = {};
  final schedules = ref.watch(_schedules);
  for(Schedule s in schedules) {
    map[s.uid] = <Ticket>[];
  }
  final tickets = ref.watch(provider.tickets);
  for(Ticket item in tickets) {
    map[item.scheduleUid]!.add(item);
  }
  return map;
});

class ScheduleList extends ConsumerStatefulWidget {
  const ScheduleList({
    super.key,
    this.onItemTap,
  });

  final Function(Schedule)? onItemTap;

  @override
  ConsumerState createState() => _ScheduleListState();
}

class _ScheduleListState extends ConsumerState<ScheduleList> {

  @override
  Widget build(BuildContext context) {
    final schedules = ref.watch(_schedules);
    final tickets = ref.watch(_tickets);
    if (schedules.isEmpty) {
      return const Icon(Icons.disabled_visible_outlined);
    }
    return ListView.builder(
      itemCount: schedules.length,
      itemBuilder: (context, index) {
        final item = schedules[index];
        final ts = tickets[item.uid]!.fold<int>(0, (prev, t) => prev + t.seats);
        return ScheduleCard(
          datetime: item.datetime,
          maxSeats: item.seats,
          leftSeats: item.seats - ts,
          onTap: widget.onItemTap == null ? null : () {
            widget.onItemTap!(item);
          },
        );
      },
    );
  }
}