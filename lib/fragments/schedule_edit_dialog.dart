import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ticket_management/generated/locale_keys.g.dart';
import 'package:ticket_management/models/schedule.dart';

class ScheduleEditDialog extends StatefulWidget {
  const ScheduleEditDialog({
    super.key,
    this.schedule,
  });

  final Schedule? schedule;

  @override
  State createState() => _ScheduleEditDialogState();
}

class _ScheduleEditDialogState extends State<ScheduleEditDialog> {

  final TextEditingController controller = TextEditingController();

  late final Schedule editing;

  bool get removable => widget.schedule != null;

  void changeSeats(int value) {
    setState(() {
      controller.text = value.toString();
      editing.seats = value;
    });
  }

  void onDatePressed() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      currentDate: editing.datetime,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now.add(const Duration(days: 365)),
    );
    if (date == null) return;
    editing.changeDate(date);
  }

  void onTimePressed() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: editing.datetime.hour,
        minute: editing.datetime.minute,
      ),
    );
    if (time == null) return;
    editing.changeTime(time);
  }

  void onSeatAddPressed() => changeSeats(math.min(editing.seats+1, Schedule.seatsMax));

  void onSeatRemovePressed() => changeSeats(math.max(editing.seats-1, Schedule.seatsMin));

  void onSeatsChanged(String string) {
    try {
      final value = int.parse(string);
      editing.seats = value;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
    }
  }

  void onConfirm() {
    final item = Schedule(editing.datetime, editing.seats);
    Navigator.pop(context, item);
  }

  void onNegative() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    editing = Schedule.fromMap(widget.schedule?.map ?? {});
    controller.text = editing.seats.toString();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.schedule?.code ?? LocaleKeys.dashboard_actAddSchedule.tr()),
      content: SingleChildScrollView(
        child: Column(
          children: [
            // Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: onDatePressed,
                  child: Wrap(
                    children: [
                      const Icon(Icons.calendar_today_sharp),
                      Text(DateFormat.MMMMd().format(editing.datetime)),
                    ],
                  ),
                ),
                InkWell(
                  onTap: onTimePressed,
                  child: Wrap(
                    children: [
                      const Icon(Icons.timer_sharp),
                      Text(TimeOfDay(
                        hour: editing.datetime.hour,
                        minute: editing.datetime.minute,
                      ).format(context)),
                    ],
                  ),
                ),
              ],
            ),
            // Seats
            TextField(
              controller: controller,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                prefix: IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: onSeatRemovePressed,
                ),
                suffix: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: onSeatAddPressed,
                ),
                labelText: LocaleKeys.schedule_seats.tr(),
              ),
              keyboardType: const TextInputType.numberWithOptions(
                signed: false,
                decimal: false,
              ),
              inputFormatters: [
                FilteringTextInputFormatter(r"[0-9]{0,3}", allow: true),
              ],
              onChanged: onSeatsChanged,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: onConfirm,
          child: Text(LocaleKeys.action_confirm.tr()),
        ),
        TextButton(
          onPressed: onNegative,
          child: Text(removable
              ? LocaleKeys.action_remove.tr()
              : LocaleKeys.action_cancel.tr()
          ),
        ),
      ],
    );
  }
}