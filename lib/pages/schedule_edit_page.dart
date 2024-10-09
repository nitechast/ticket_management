import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticket_management/fragments/schedule_edit_dialog.dart';
import 'package:ticket_management/generated/locale_keys.g.dart';
import 'package:ticket_management/lists/schedule_list.dart';
import 'package:ticket_management/models/schedule.dart';
import 'package:ticket_management/provider.dart' as provider;

class ScheduleEditPage extends ConsumerStatefulWidget {
  const ScheduleEditPage({
    super.key,
  });

  @override
  ConsumerState createState() => _ScheduleEditPageState();
}

class _ScheduleEditPageState extends ConsumerState<ScheduleEditPage> {

  Future<Schedule?> showScheduleEditDialog([Schedule? schedule]) async {
    return await showDialog<Schedule>(
      context: context,
      builder: (context) {
        return ScheduleEditDialog(
          schedule: schedule,
        );
      }
    );
  }

  void onItemTap(Schedule schedule) async {
    final result = await showScheduleEditDialog(schedule);
    if (result == null) {
      // Remove
      ref.watch(provider.schedules.notifier).delete(
          ref.watch(provider.section),
          ref.watch(provider.namespace),
          schedule.uid
      );
      return;
    }
    // Edit
    ref.watch(provider.schedules.notifier).update(
        ref.watch(provider.section),
        ref.watch(provider.namespace),
        schedule
    );
  }

  void onFabPressed() async {
    final result = await showScheduleEditDialog();
    if (result == null) {
      return;
    }
    // Create
    ref.watch(provider.schedules.notifier).set(
        ref.watch(provider.section),
        ref.watch(provider.namespace),
        result
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.schedule_title.tr()),
      ),
      body: ScheduleList(
        onItemTap: onItemTap,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onFabPressed,
        child: const Icon(Icons.add),
      ),
    );
  }
}