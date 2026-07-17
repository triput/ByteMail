import 'package:flutter/material.dart';
import 'package:bytemail/settings/app_settings.dart';
import 'package:bytemail/theme/app_theme.dart';
import 'package:bytemail/ui/shell/mail_workspace.dart';

/// Root application widget. Theme and density come from [AppSettings].
class ByteMailApp extends StatefulWidget {
  const ByteMailApp({super.key});

  @override
  State<ByteMailApp> createState() => _ByteMailAppState();
}

class _ByteMailAppState extends State<ByteMailApp> {
  late final AppSettings _settings;

  @override
  void initState() {
    super.initState();
    _settings = AppSettings();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _settings,
      builder: (context, _) {
        return MaterialApp(
          title: 'ByteMail',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.materialTheme(_settings),
          home: MailWorkspace(settings: _settings),
        );
      },
    );
  }
}
