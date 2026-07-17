import 'package:flutter/material.dart';
import 'package:bytemail/domain/models.dart';
import 'package:bytemail/domain/sample_mailbox.dart';
import 'package:bytemail/theme/app_theme.dart';
import 'package:bytemail/theme/density.dart';

class MessageListPane extends StatelessWidget {
  const MessageListPane({
    super.key,
    required this.messages,
    required this.selectedId,
    required this.focusEnabled,
    required this.focusFilter,
    required this.density,
    required this.onSelect,
    required this.onFocusFilter,
    this.onShowSidebar,
  });

  final List<MailMessage> messages;
  final String? selectedId;
  final bool focusEnabled;
  final FocusBucket focusFilter;
  final ViewDensity density;
  final ValueChanged<String> onSelect;
  final ValueChanged<FocusBucket> onFocusFilter;
  final VoidCallback? onShowSidebar;

  @override
  Widget build(BuildContext context) {
    final t = tokensOf(context);
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0E1530),
        border: Border(right: BorderSide(color: t.line)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
            child: Column(
              children: [
                if (onShowSidebar != null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      onPressed: onShowSidebar,
                      icon: Icon(Icons.menu, size: 16, color: t.teal),
                      label: Text('Show folders', style: TextStyle(color: t.teal)),
                    ),
                  ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: t.ink.withValues(alpha: 0.65),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: t.line),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, size: 18, color: t.amethyst),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Search local mail (FTS5)…',
                          style: TextStyle(color: t.muted, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
                if (focusEnabled) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: _FocusChip(
                          label: 'Focused',
                          selected: focusFilter == FocusBucket.focused,
                          selectedColors: [t.emerald, t.teal],
                          onTap: () => onFocusFilter(FocusBucket.focused),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: _FocusChip(
                          label: 'Other',
                          selected: focusFilter == FocusBucket.other,
                          selectedColors: [t.coral, const Color(0xFFFB923C)],
                          onTap: () => onFocusFilter(FocusBucket.other),
                        ),
                      ),
                    ],
                  ),
                ] else
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Focus off · showing all mail',
                        style: TextStyle(color: t.muted, fontSize: 12),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: t.azure,
                side: BorderSide(color: t.azure.withValues(alpha: 0.45)),
                minimumSize: const Size.fromHeight(36),
              ),
              child: const Text(
                'Search older emails on the server',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              itemCount: messages.length,
              separatorBuilder: (_, _) => SizedBox(height: density.listGap),
              itemBuilder: (context, index) {
                final msg = messages[index];
                final account = SampleMailbox.accountById(msg.accountId);
                final selected = msg.id == selectedId;
                return _MessageRow(
                  message: msg,
                  accent: account.accent,
                  selected: selected,
                  density: density,
                  onTap: () => onSelect(msg.id),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FocusChip extends StatelessWidget {
  const _FocusChip({
    required this.label,
    required this.selected,
    required this.selectedColors,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final List<Color> selectedColors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = tokensOf(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: selected ? Colors.transparent : t.line),
            gradient: selected
                ? LinearGradient(colors: selectedColors)
                : null,
            color: selected ? null : t.panel.withValues(alpha: 0.6),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: selected ? t.onAccent : t.muted,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MessageRow extends StatelessWidget {
  const _MessageRow({
    required this.message,
    required this.accent,
    required this.selected,
    required this.density,
    required this.onTap,
  });

  final MailMessage message;
  final Color accent;
  final bool selected;
  final ViewDensity density;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = tokensOf(context);
    return Material(
      color: selected
          ? t.indigo.withValues(alpha: 0.14)
          : density == ViewDensity.calm
              ? t.panel.withValues(alpha: 0.55)
              : Colors.transparent,
      borderRadius: BorderRadius.circular(density.messageRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(density.messageRadius),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(width: 4, color: accent),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: density.listRowPaddingH,
                    vertical: density.listRowPaddingV,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              message.fromName,
                              style: TextStyle(
                                color: t.text,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Text(
                            message.whenLabel,
                            style: TextStyle(color: t.muted, fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        message.subject,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: message.unread ? Colors.white : t.text,
                          fontSize: density.subjectSize,
                          fontWeight:
                              message.unread ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        message.snippet,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: t.muted,
                          fontSize: density.snippetSize,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
