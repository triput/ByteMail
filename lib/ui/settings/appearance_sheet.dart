import 'package:flutter/material.dart';
import 'package:bytemail/domain/sample_mailbox.dart';
import 'package:bytemail/settings/app_settings.dart';
import 'package:bytemail/theme/app_theme.dart';
import 'package:bytemail/theme/density.dart';
import 'package:bytemail/theme/theme_id.dart';

Future<void> showAppearanceSheet(BuildContext context, AppSettings settings) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: tokensOf(context).panel,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (context) {
      return AnimatedBuilder(
        animation: settings,
        builder: (context, _) {
          final t = tokensOf(context);
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Appearance & view',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                Text('Theme', style: TextStyle(color: t.muted, fontSize: 12)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final id in ThemeId.values)
                      ChoiceChip(
                        label: Text(id.label),
                        selected: settings.themeId == id,
                        onSelected: (_) => settings.setTheme(id),
                      ),
                  ],
                ),
                const SizedBox(height: 18),
                Text('Density', style: TextStyle(color: t.muted, fontSize: 12)),
                const SizedBox(height: 8),
                SegmentedButton<ViewDensity>(
                  segments: const [
                    ButtonSegment(
                      value: ViewDensity.calm,
                      label: Text('Calm'),
                    ),
                    ButtonSegment(
                      value: ViewDensity.compact,
                      label: Text('Compact'),
                    ),
                  ],
                  selected: {settings.density},
                  onSelectionChanged: (value) =>
                      settings.setDensity(value.first),
                ),
                const SizedBox(height: 18),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Unified Inbox · Focused/Other'),
                  subtitle: Text(
                    'Independent of per-account Focus settings',
                    style: TextStyle(color: t.muted, fontSize: 12),
                  ),
                  value: settings.unifiedFocusEnabled,
                  onChanged: settings.setUnifiedFocusEnabled,
                ),
                const SizedBox(height: 8),
                Text(
                  'Per-account Focus',
                  style: TextStyle(color: t.muted, fontSize: 12),
                ),
                for (final account in SampleMailbox.accounts)
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(account.address),
                    value: settings.isAccountFocusEnabled(account.id),
                    onChanged: (v) =>
                        settings.setAccountFocusEnabled(account.id, v),
                  ),
                const SizedBox(height: 8),
                Text(
                  'Note: Light / Solarized packs are selectable but still use Dark tokens in this shell.',
                  style: TextStyle(color: t.muted, fontSize: 11),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
