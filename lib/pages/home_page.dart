import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticket_management/fragments/auth_fragment.dart';
import 'package:ticket_management/generated/locale_keys.g.dart';
import 'package:ticket_management/pages/scanner_page.dart';
import 'package:ticket_management/lists/schedule_list.dart';
import 'package:ticket_management/lists/ticket_list.dart';
import 'package:ticket_management/provider.dart' as provider;

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {

  final size = 128.0;

  final titles = [
    LocaleKeys.app_name.tr(),
    LocaleKeys.home_title_editor.tr(),
    LocaleKeys.home_title_default.tr(),
  ];

  void onEntered() {
    setState(() {
    });
  }

  void onScanPressed() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const ScannerPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(provider.user);
    final fragmentIndex = user.isValid ? (user.isEditor ? 1 : 2) : 0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(titles[fragmentIndex]),
        actions: [
          IconButton(
            icon: const Icon(Icons.schedule_outlined),
            tooltip: LocaleKeys.home_schedule.tr(),
            onPressed: () {},
          ),
        ],
      ),
      body: IndexedStack(
        index: fragmentIndex,
        children: [
          // 0: Auth
          AuthFragment(
            onEntered: onEntered,
          ),
          // 1: History
          TicketList(),
          // 2: Schedule
          ScheduleList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onScanPressed,
        child: const Icon(Icons.qr_code_2),
      ),
    );
  }
}
