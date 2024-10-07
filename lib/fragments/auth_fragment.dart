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

  int userType = 0;

  bool? status;

  void onUserTypeChanged(int index) {
    setState(() {
      userType = index;
    });
  }

  void onButtonPressed() async {
    if (userType > 0) {
      final result = await provider.signIn(ref);
      setState(() {
        status = result;
      });
      if (!result) {
        return;
      }
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
              decoration: InputDecoration(
                icon: const Icon(Icons.celebration_outlined),
                labelText: LocaleKeys.auth_section.tr(),
              ),
            ),
            // Namespace
            TextField(
              decoration: InputDecoration(
                icon: const Icon(Icons.domain_outlined),
                labelText: LocaleKeys.auth_namespace.tr(),
              ),
            ),
            // User type
            ToggleButtons(
              isSelected: List<bool>.generate(3, (index) => index == userType),
              onPressed: onUserTypeChanged,
              children: [
                Text(LocaleKeys.auth_normal.tr()),
                Text(LocaleKeys.auth_receipt.tr()),
                Text(LocaleKeys.auth_admin.tr()),
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