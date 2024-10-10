import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticket_management/generated/locale_keys.g.dart';
import 'package:ticket_management/lists/schedule_list.dart';

class CustomerPage extends ConsumerWidget {
  const CustomerPage({
    super.key,
  });

  void onActionPressed() {

  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.customer_title.tr()),
        actions: kDebugMode ? [
          IconButton(
            icon: const Icon(Icons.edit_note_sharp),
            onPressed: onActionPressed,
          )
        ] : null,
      ),
      body: const ScheduleList(),
    );
  }
}