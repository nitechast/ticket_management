import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ticket_management/generated/locale_keys.g.dart';

class ScheduleCard extends StatelessWidget {

  const ScheduleCard({
    super.key,
    required this.datetime,
    required this.maxSeats,
    required this.leftSeats,
    this.description = "",
    this.onTap,
  });

  final DateTime datetime;

  final int maxSeats;

  final int leftSeats;

  final String description;

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    DateFormat(LocaleKeys.format_Hm.tr()).format(datetime),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Wrap(
                    children: [
                      Text(
                        leftSeats.toString(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text("/$maxSeats",),
                    ],
                  ),
                ],
              ),
              Text(DateFormat(LocaleKeys.format_MMMMd.tr()).format(datetime)),
              Text(description),
            ],
          ),
        ),
      ),
    );
  }
}