import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticket_management/provider.dart' as provider;

class TicketSetPage extends ConsumerStatefulWidget {
  const TicketSetPage({
    super.key,
    required this.code,
  });

  final String code;

  @override
  ConsumerState createState() => _TicketSetPageState();
}

class _TicketSetPageState extends ConsumerState<TicketSetPage> {

  @override
  Widget build(BuildContext context) {
    final ticket = ref.watch(provider.tickets).firstWhere((item) => item.code == widget.code);
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Code
                TextField(
                  readOnly: true,
                ),
                // Name
                TextField(),
                // Date and number
              ],
            ),
          ),
        ),
      ),
    );
  }
}