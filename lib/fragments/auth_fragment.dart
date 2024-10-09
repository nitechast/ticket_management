import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticket_management/generated/locale_keys.g.dart';
import 'package:ticket_management/provider.dart' as provider;

class AuthFragment extends ConsumerStatefulWidget {
  const AuthFragment({
    super.key,
    required this.onEntered,
  });

  final Function() onEntered;

  @override
  ConsumerState createState() => _AuthFragmentState();
}

class _AuthFragmentState extends ConsumerState<AuthFragment> {

  final TextEditingController sectionController = TextEditingController();

  final TextEditingController namespaceController = TextEditingController();

  bool useManager = false;

  bool? status;

  void onUserTypeChanged(bool value) {
    setState(() {
      useManager = value;
    });
  }

  void onButtonPressed() async {
    bool result = true;
    // User
    if (useManager) {
      result = await provider.signIn(ref);
    } else {
      provider.signAnonymous(ref);
    }
    // Section and namespace
    ref.watch(provider.section.notifier).set(sectionController.text);
    ref.watch(provider.namespace.notifier).set(namespaceController.text);
    // Refresh
    setState(() {
      status = result;
    });
    if (!result) {
      return;
    }
    widget.onEntered();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            // Section
            TextField(
              controller: sectionController,
              decoration: InputDecoration(
                icon: const Icon(Icons.celebration_outlined),
                labelText: LocaleKeys.auth_section.tr(),
              ),
            ),
            // Namespace
            TextField(
              controller: namespaceController,
              decoration: InputDecoration(
                icon: const Icon(Icons.domain_outlined),
                labelText: LocaleKeys.auth_namespace.tr(),
              ),
            ),
            // User type
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(LocaleKeys.auth_msgUseManager.tr()),
                Switch(
                  value: useManager,
                  onChanged: onUserTypeChanged,
                ),
              ],
            ),
            // Begin
            TextButton(
              onPressed: onButtonPressed,
              child: Text(LocaleKeys.auth_enter.tr()),
            ),
            Visibility(
              visible: status != null,
              child: Text((status ?? false)
                  ? LocaleKeys.auth_msgSuccess.tr()
                  : LocaleKeys.auth_msgFailed.tr()
              ),
            )
          ],
        ),
      ),
    );
  }
}