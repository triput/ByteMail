import 'package:flutter/foundation.dart';
import 'package:bytemail/theme/density.dart';
import 'package:bytemail/theme/theme_id.dart';

/// In-memory settings for v0 shell. Persistence (SQLite / prefs) comes later.
class AppSettings extends ChangeNotifier {
  ThemeId _themeId = ThemeId.dark;
  ViewDensity _density = ViewDensity.calm;

  /// Unified Inbox Focused/Other enablement (independent of accounts).
  bool _unifiedFocusEnabled = true;

  /// Per-account Focus enablement. Missing ids default to true.
  final Map<String, bool> _accountFocusEnabled = {
    'work': true,
    'personal': true,
    'side': false,
  };

  ThemeId get themeId => _themeId;
  ViewDensity get density => _density;
  bool get unifiedFocusEnabled => _unifiedFocusEnabled;

  void setTheme(ThemeId id) {
    if (_themeId == id) return;
    _themeId = id;
    notifyListeners();
  }

  void setDensity(ViewDensity density) {
    if (_density == density) return;
    _density = density;
    notifyListeners();
  }

  void setUnifiedFocusEnabled(bool enabled) {
    if (_unifiedFocusEnabled == enabled) return;
    _unifiedFocusEnabled = enabled;
    notifyListeners();
  }

  bool isAccountFocusEnabled(String accountId) =>
      _accountFocusEnabled[accountId] ?? true;

  void setAccountFocusEnabled(String accountId, bool enabled) {
    if (_accountFocusEnabled[accountId] == enabled) return;
    _accountFocusEnabled[accountId] = enabled;
    notifyListeners();
  }

  /// Whether Focused/Other UI applies for the current mailbox context.
  bool focusEnabledForContext({required bool isUnified, String? accountId}) {
    if (isUnified) return _unifiedFocusEnabled;
    if (accountId == null) return false;
    return isAccountFocusEnabled(accountId);
  }
}
