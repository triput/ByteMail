import 'package:flutter/material.dart';
import 'package:bytemail/domain/models.dart';
import 'package:bytemail/domain/sample_mailbox.dart';
import 'package:bytemail/theme/app_theme.dart';
import 'package:bytemail/theme/density.dart';

class ReadingPane extends StatelessWidget {
  const ReadingPane({
    super.key,
    required this.message,
    required this.density,
  });

  final MailMessage? message;
  final ViewDensity density;

  @override
  Widget build(BuildContext context) {
    final t = tokensOf(context);
    if (message == null) {
      return Container(
        color: const Color(0xFF0C1228),
        alignment: Alignment.center,
        child: Text('Select a message', style: TextStyle(color: t.muted)),
      );
    }

    final account = SampleMailbox.accountById(message!.accountId);
    final pad = density == ViewDensity.calm
        ? const EdgeInsets.symmetric(horizontal: 32, vertical: 28)
        : const EdgeInsets.symmetric(horizontal: 20, vertical: 18);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            t.indigo.withValues(alpha: 0.08),
            const Color(0xFF0C1228),
          ],
          stops: const [0, 0.25],
        ),
        color: const Color(0xFF0C1228),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: pad,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: account.accent.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: account.accent.withValues(alpha: 0.35),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(
                          color: account.accent,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        account.address,
                        style: TextStyle(
                          color: Color.lerp(
                            account.accent,
                            Colors.white,
                            0.2,
                          ),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  message!.subject,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 6),
                Text(
                  '${message!.fromName} <${message!.fromAddress}> · to me',
                  style: TextStyle(color: t.muted, fontSize: 13),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _Action(label: 'Reply', onPressed: () {}),
                    _Action(label: 'Archive', onPressed: () {}),
                    _Action(label: 'Delete', onPressed: () {}, danger: true),
                  ],
                ),
              ],
            ),
          ),
          Divider(height: 1, color: t.line),
          Expanded(
            child: SingleChildScrollView(
              padding: pad,
              child: Text(
                message!.body,
                style: TextStyle(
                  color: const Color(0xFFD7DDF5),
                  fontSize: density.bodySize,
                  height: 1.65,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            decoration: BoxDecoration(
              color: t.ink.withValues(alpha: 0.55),
              border: Border(top: BorderSide(color: t.line)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Quick reply…',
                      hintStyle: TextStyle(color: t.muted),
                      filled: true,
                      fillColor: t.panel.withValues(alpha: 0.8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: t.line),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: t.line),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: t.teal,
                    foregroundColor: t.onAccent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Send'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Action extends StatelessWidget {
  const _Action({
    required this.label,
    required this.onPressed,
    this.danger = false,
  });

  final String label;
  final VoidCallback onPressed;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final t = tokensOf(context);
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: danger ? t.coral : t.text,
        side: BorderSide(
          color: danger ? t.coral.withValues(alpha: 0.35) : t.line,
        ),
      ),
      child: Text(label),
    );
  }
}
