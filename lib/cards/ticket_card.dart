import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ticket_management/generated/locale_keys.g.dart';
import 'package:ticket_management/models/ticket.dart';

class TicketCard extends StatelessWidget {

  const TicketCard({
    super.key,
    required this.ticket,
    this.onTap,
  });

  final Ticket ticket;

  final Function(Ticket)? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: Text(
            DateFormat(LocaleKeys.format_Hm.tr()).format(ticket.date),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          title: Text(DateFormat(LocaleKeys.format_MMMMd.tr()).format(ticket.date)),
          subtitle: Text(LocaleKeys.format_name.tr(args: [ticket.name])),
          trailing: Wrap(
            children: [
              Text(
                ticket.number.toString(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(LocaleKeys.format_seatUnit.tr(),),
            ],
          ),
          onTap: onTap == null ? null : () {
            onTap!(ticket);
          },
        ),
      ),
    );
  }
}