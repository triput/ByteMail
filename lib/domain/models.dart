import 'package:flutter/material.dart';

class MailAccount {
  const MailAccount({
    required this.id,
    required this.label,
    required this.address,
    required this.accent,
  });

  final String id;
  final String label;
  final String address;
  final Color accent;
}

enum FocusBucket { focused, other }

class MailMessage {
  const MailMessage({
    required this.id,
    required this.accountId,
    required this.fromName,
    required this.fromAddress,
    required this.subject,
    required this.snippet,
    required this.body,
    required this.whenLabel,
    required this.bucket,
    this.unread = false,
  });

  final String id;
  final String accountId;
  final String fromName;
  final String fromAddress;
  final String subject;
  final String snippet;
  final String body;
  final String whenLabel;
  final FocusBucket bucket;
  final bool unread;
}
