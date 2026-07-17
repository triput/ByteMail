import 'package:flutter/material.dart';
import 'package:bytemail/domain/models.dart';
import 'package:bytemail/domain/sample_mailbox.dart';
import 'package:bytemail/settings/app_settings.dart';
import 'package:bytemail/theme/app_theme.dart';
import 'package:bytemail/theme/density.dart';
import 'package:bytemail/ui/settings/appearance_sheet.dart';
import 'package:bytemail/ui/shell/folder_sidebar.dart';
import 'package:bytemail/ui/shell/message_list_pane.dart';
import 'package:bytemail/ui/shell/reading_pane.dart';

/// Desktop-style multi-pane mailbox workspace (Calm Dark shell).
class MailWorkspace extends StatefulWidget {
  const MailWorkspace({super.key, required this.settings});

  final AppSettings settings;

  @override
  State<MailWorkspace> createState() => _MailWorkspaceState();
}

class _MailWorkspaceState extends State<MailWorkspace> {
  bool _unified = true;
  String? _accountId;
  FocusBucket _focusFilter = FocusBucket.focused;
  String? _selectedId;
  bool _sidebarVisible = true;

  AppSettings get settings => widget.settings;

  bool get _focusEnabled => settings.focusEnabledForContext(
        isUnified: _unified,
        accountId: _accountId,
      );

  List<MailMessage> get _visibleMessages {
    Iterable<MailMessage> items = SampleMailbox.messages;
    if (!_unified && _accountId != null) {
      items = items.where((m) => m.accountId == _accountId);
    }
    if (_focusEnabled) {
      items = items.where((m) => m.bucket == _focusFilter);
    }
    return items.toList();
  }

  MailMessage? get _selected {
    final list = _visibleMessages;
    if (list.isEmpty) return null;
    final match = list.where((m) => m.id == _selectedId);
    return match.isEmpty ? list.first : match.first;
  }

  void _selectMailbox({required bool unified, String? accountId}) {
    setState(() {
      _unified = unified;
      _accountId = accountId;
      _selectedId = null;
      _focusFilter = FocusBucket.focused;
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = tokensOf(context);
    final density = settings.density;
    final selected = _selected;

    return Scaffold(
      backgroundColor: t.ink,
      body: Column(
        children: [
          _TitleBar(
            contextLabel: _unified
                ? 'Unified Inbox'
                : SampleMailbox.accountById(_accountId!).address,
            onOpenAppearance: () => showAppearanceSheet(context, settings),
          ),
          Expanded(
            child: Row(
              children: [
                _AccountRail(
                  unified: _unified,
                  accountId: _accountId,
                  onSelectUnified: () =>
                      _selectMailbox(unified: true, accountId: null),
                  onSelectAccount: (id) =>
                      _selectMailbox(unified: false, accountId: id),
                ),
                if (_sidebarVisible)
                  SizedBox(
                    width: density.sidebarWidth,
                    child: FolderSidebar(
                      unified: _unified,
                      accountId: _accountId,
                      settings: settings,
                      onToggleVisualFocus: () =>
                          setState(() => _sidebarVisible = false),
                      onSelectUnified: () =>
                          _selectMailbox(unified: true, accountId: null),
                      onSelectAccount: (id) =>
                          _selectMailbox(unified: false, accountId: id),
                    ),
                  ),
                SizedBox(
                  width: density.listWidth,
                  child: MessageListPane(
                    messages: _visibleMessages,
                    selectedId: selected?.id,
                    focusEnabled: _focusEnabled,
                    focusFilter: _focusFilter,
                    density: density,
                    onSelect: (id) => setState(() => _selectedId = id),
                    onFocusFilter: (bucket) =>
                        setState(() => _focusFilter = bucket),
                    onShowSidebar: _sidebarVisible
                        ? null
                        : () => setState(() => _sidebarVisible = true),
                  ),
                ),
                Expanded(
                  child: ReadingPane(
                    message: selected,
                    density: density,
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

class _TitleBar extends StatelessWidget {
  const _TitleBar({
    required this.contextLabel,
    required this.onOpenAppearance,
  });

  final String contextLabel;
  final VoidCallback onOpenAppearance;

  @override
  Widget build(BuildContext context) {
    final t = tokensOf(context);
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            t.indigo.withValues(alpha: 0.18),
            t.teal.withValues(alpha: 0.08),
          ],
        ),
        border: Border(bottom: BorderSide(color: t.line)),
      ),
      child: Row(
        children: [
          Text(
            'ByteMail',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text('/', style: TextStyle(color: t.muted)),
          ),
          Text(contextLabel, style: TextStyle(color: t.muted, fontSize: 13)),
          const Spacer(),
          _Pill(label: 'Synced · sample', color: t.panel2, textColor: t.muted),
          const SizedBox(width: 8),
          _Pill(label: '3 queued', color: t.amber, textColor: t.onAccent),
          const SizedBox(width: 8),
          IconButton(
            tooltip: 'Appearance',
            onPressed: onOpenAppearance,
            icon: Icon(Icons.palette_outlined, color: t.muted, size: 20),
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({
    required this.label,
    required this.color,
    required this.textColor,
  });

  final String label;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _AccountRail extends StatelessWidget {
  const _AccountRail({
    required this.unified,
    required this.accountId,
    required this.onSelectUnified,
    required this.onSelectAccount,
  });

  final bool unified;
  final String? accountId;
  final VoidCallback onSelectUnified;
  final ValueChanged<String> onSelectAccount;

  @override
  Widget build(BuildContext context) {
    final t = tokensOf(context);
    return Container(
      width: 56,
      decoration: BoxDecoration(
        color: const Color(0xFF090E1D),
        border: Border(right: BorderSide(color: t.line)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Column(
        children: [
          _RailButton(
            selected: unified,
            onTap: onSelectUnified,
            child: Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(9)),
                gradient: SweepGradient(
                  colors: [
                    Color(0xFF2DD4BF),
                    Color(0xFFA78BFA),
                    Color(0xFF60A5FA),
                    Color(0xFF2DD4BF),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          for (final account in SampleMailbox.accounts) ...[
            _RailButton(
              selected: !unified && accountId == account.id,
              onTap: () => onSelectAccount(account.id),
              child: Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color.alphaBlend(
                    account.accent.withValues(alpha: 0.35),
                    t.ink,
                  ),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Text(
                  account.label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
          const Spacer(),
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(colors: [t.teal, t.indigo]),
            ),
            child: const Text('+', style: TextStyle(fontSize: 22, height: 1)),
          ),
        ],
      ),
    );
  }
}

class _RailButton extends StatelessWidget {
  const _RailButton({
    required this.selected,
    required this.onTap,
    required this.child,
  });

  final bool selected;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final t = tokensOf(context);
    return Material(
      color: selected ? t.indigo.withValues(alpha: 0.28) : Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: 40,
          height: 40,
          child: Center(child: child),
        ),
      ),
    );
  }
}
