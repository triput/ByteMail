import 'package:flutter/material.dart';
import 'package:bytemail/domain/sample_mailbox.dart';
import 'package:bytemail/settings/app_settings.dart';
import 'package:bytemail/theme/app_theme.dart';

class FolderSidebar extends StatelessWidget {
  const FolderSidebar({
    super.key,
    required this.unified,
    required this.accountId,
    required this.settings,
    required this.onToggleVisualFocus,
    required this.onSelectUnified,
    required this.onSelectAccount,
  });

  final bool unified;
  final String? accountId;
  final AppSettings settings;
  final VoidCallback onToggleVisualFocus;
  final VoidCallback onSelectUnified;
  final ValueChanged<String> onSelectAccount;

  @override
  Widget build(BuildContext context) {
    final t = tokensOf(context);
    return Container(
      color: t.panel,
      padding: const EdgeInsets.fromLTRB(12, 14, 12, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'MAILBOX',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: t.muted,
                    fontSize: 12,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TextButton(
                onPressed: onToggleVisualFocus,
                style: TextButton.styleFrom(
                  foregroundColor: t.teal,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text('Focus', style: TextStyle(fontSize: 11)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _FolderTile(
            label: 'Unified Inbox',
            count: '24',
            selected: unified,
            onTap: onSelectUnified,
          ),
          _FolderTile(label: 'Focused', count: '11', selected: false, onTap: () {}),
          _FolderTile(label: 'Other', count: '13', selected: false, onTap: () {}),
          const SizedBox(height: 12),
          Text(
            'ACCOUNTS',
            style: TextStyle(
              color: t.muted.withValues(alpha: 0.7),
              fontSize: 10,
              letterSpacing: 1.4,
            ),
          ),
          const SizedBox(height: 6),
          for (final account in SampleMailbox.accounts)
            _FolderTile(
              label: account.address,
              count: null,
              selected: !unified && accountId == account.id,
              accent: account.accent,
              trailing: settings.isAccountFocusEnabled(account.id) ? null : 'no focus',
              onTap: () => onSelectAccount(account.id),
            ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: t.line),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  t.indigo.withValues(alpha: 0.2),
                  t.teal.withValues(alpha: 0.08),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'RETENTION DIAL',
                  style: TextStyle(
                    color: t.muted,
                    fontSize: 10,
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: 4),
                const Text('180 days · this device', style: TextStyle(fontSize: 13)),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    value: 0.62,
                    minHeight: 6,
                    backgroundColor: Colors.black38,
                    color: t.teal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FolderTile extends StatelessWidget {
  const _FolderTile({
    required this.label,
    required this.selected,
    required this.onTap,
    this.count,
    this.accent,
    this.trailing,
  });

  final String label;
  final String? count;
  final bool selected;
  final VoidCallback onTap;
  final Color? accent;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    final t = tokensOf(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Material(
        color: selected ? t.teal.withValues(alpha: 0.12) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              children: [
                if (accent != null) ...[
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: accent,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: accent!.withValues(alpha: 0.35),
                          blurRadius: 6,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Text(
                    label,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: selected ? t.text : t.muted,
                      fontSize: 13,
                    ),
                  ),
                ),
                if (trailing != null)
                  Text(
                    trailing!,
                    style: TextStyle(color: t.amber, fontSize: 10),
                  )
                else if (count != null)
                  Text(
                    count!,
                    style: TextStyle(
                      color: t.muted,
                      fontSize: 11,
                      fontFamily: 'JetBrains Mono',
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
