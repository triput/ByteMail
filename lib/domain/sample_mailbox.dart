import 'package:flutter/material.dart';
import 'package:synesis/domain/models.dart';

/// Static sample mailbox for the UI shell (no sync/DB yet).
abstract final class SampleMailbox {
  static const accounts = <MailAccount>[
    MailAccount(
      id: 'work',
      label: 'W',
      address: 'work@byte.io',
      accent: Color(0xFF2DD4BF),
    ),
    MailAccount(
      id: 'personal',
      label: 'P',
      address: 'me@home.dev',
      accent: Color(0xFFA78BFA),
    ),
    MailAccount(
      id: 'side',
      label: 'S',
      address: 'side@lab',
      accent: Color(0xFF60A5FA),
    ),
  ];

  static MailAccount accountById(String id) =>
      accounts.firstWhere((a) => a.id == id);

  static const messages = <MailMessage>[
    MailMessage(
      id: '1',
      accountId: 'work',
      fromName: 'Maya Chen',
      fromAddress: 'maya@byte.io',
      subject: 'Q3 architecture review — Graph sync notes',
      snippet:
          'Can we keep the outbox durable across process kills? Also want the travel profile…',
      body:
          'Hey — for the shell, imagine this pane as the calm anchor even when the list is dense.\n\n'
          'I would keep account color as a thin stripe in the list and a soft chip here.\n\n'
          'Jewel tones on a deep indigo ground should feel nocturnal studio, not neon dashboard.\n\n'
          '— Maya',
      whenLabel: '10:14',
      bucket: FocusBucket.focused,
    ),
    MailMessage(
      id: '2',
      accountId: 'personal',
      fromName: 'Jon Park',
      fromAddress: 'jon@home.dev',
      subject: 'Weekend plans + keys',
      snippet: 'Leaving the spare with Jordan. Text when you land.',
      body: 'Leaving the spare with Jordan. Text when you land.\n\n— Jon',
      whenLabel: 'Yesterday',
      bucket: FocusBucket.focused,
    ),
    MailMessage(
      id: '3',
      accountId: 'side',
      fromName: 'Priya Nair',
      fromAddress: 'priya@lab',
      subject: 'Design partners for jewel-tone shell',
      snippet: 'Teal anchors read clearly on indigo. Let’s avoid neon.',
      body: 'Teal anchors read clearly on indigo. Let’s avoid neon.\n\n— Priya',
      whenLabel: 'Sun',
      bucket: FocusBucket.focused,
    ),
    MailMessage(
      id: '4',
      accountId: 'work',
      fromName: 'Alex Rivera',
      fromAddress: 'alex@byte.io',
      subject: 'Re: isolate bus sketch',
      snippet: 'Typed commands feel right. UI should never see raw ports.',
      body: 'Typed commands feel right. UI should never see raw ports.\n\n— Alex',
      whenLabel: 'Sun',
      bucket: FocusBucket.focused,
      unread: true,
    ),
    MailMessage(
      id: '5',
      accountId: 'work',
      fromName: 'GitHub',
      fromAddress: 'noreply@github.com',
      subject: '[synesis] CI passed on main',
      snippet: 'All checks were successful for commit 8f3a…',
      body: 'All checks were successful for commit 8f3a…',
      whenLabel: '09:02',
      bucket: FocusBucket.other,
    ),
    MailMessage(
      id: '6',
      accountId: 'personal',
      fromName: 'Stripe',
      fromAddress: 'noreply@stripe.com',
      subject: 'Your receipt from Byte Labs',
      snippet: 'Invoice #2048 · \$24.00',
      body: 'Invoice #2048 · \$24.00',
      whenLabel: 'Sat',
      bucket: FocusBucket.other,
      unread: true,
    ),
    MailMessage(
      id: '7',
      accountId: 'side',
      fromName: 'Notion Team',
      fromAddress: 'team@notion.so',
      subject: 'Weekly digest for Engineering',
      snippet: '12 updates across 4 pages you follow.',
      body: '12 updates across 4 pages you follow.',
      whenLabel: 'Fri',
      bucket: FocusBucket.other,
    ),
  ];
}
