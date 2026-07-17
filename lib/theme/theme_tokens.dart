import 'package:flutter/material.dart';
import 'package:bytemail/theme/theme_id.dart';

/// Tokenized colors so themes stay data-driven (SPEC §7.7).
@immutable
class ThemeTokens extends ThemeExtension<ThemeTokens> {
  const ThemeTokens({
    required this.id,
    required this.brightness,
    required this.ink,
    required this.panel,
    required this.panel2,
    required this.line,
    required this.text,
    required this.muted,
    required this.teal,
    required this.amethyst,
    required this.indigo,
    required this.emerald,
    required this.azure,
    required this.amber,
    required this.coral,
    required this.onAccent,
  });

  final ThemeId id;
  final Brightness brightness;
  final Color ink;
  final Color panel;
  final Color panel2;
  final Color line;
  final Color text;
  final Color muted;
  final Color teal;
  final Color amethyst;
  final Color indigo;
  final Color emerald;
  final Color azure;
  final Color amber;
  final Color coral;
  final Color onAccent;

  static ThemeTokens forId(ThemeId id) => switch (id) {
        ThemeId.dark => dark,
        ThemeId.black => black,
        // Placeholders until full light/solarized packs land:
        ThemeId.light => dark.copyWith(id: ThemeId.light),
        ThemeId.solarizedLight => dark.copyWith(id: ThemeId.solarizedLight),
        ThemeId.solarizedDark => dark.copyWith(id: ThemeId.solarizedDark),
      };

  static const dark = ThemeTokens(
    id: ThemeId.dark,
    brightness: Brightness.dark,
    ink: Color(0xFF0B1020),
    panel: Color(0xFF121934),
    panel2: Color(0xFF171F3F),
    line: Color(0x29A78BFA),
    text: Color(0xFFE8ECFF),
    muted: Color(0xFF9AA3C7),
    teal: Color(0xFF2DD4BF),
    amethyst: Color(0xFFA78BFA),
    indigo: Color(0xFF6366F1),
    emerald: Color(0xFF34D399),
    azure: Color(0xFF60A5FA),
    amber: Color(0xFFFBBF24),
    coral: Color(0xFFFB7185),
    onAccent: Color(0xFF061018),
  );

  static const black = ThemeTokens(
    id: ThemeId.black,
    brightness: Brightness.dark,
    ink: Color(0xFF050508),
    panel: Color(0xFF0E0E14),
    panel2: Color(0xFF161622),
    line: Color(0x33A78BFA),
    text: Color(0xFFF2F4FF),
    muted: Color(0xFF9AA3C7),
    teal: Color(0xFF2DD4BF),
    amethyst: Color(0xFFA78BFA),
    indigo: Color(0xFF818CF8),
    emerald: Color(0xFF34D399),
    azure: Color(0xFF60A5FA),
    amber: Color(0xFFFBBF24),
    coral: Color(0xFFFB7185),
    onAccent: Color(0xFF061018),
  );

  @override
  ThemeTokens copyWith({
    ThemeId? id,
    Brightness? brightness,
    Color? ink,
    Color? panel,
    Color? panel2,
    Color? line,
    Color? text,
    Color? muted,
    Color? teal,
    Color? amethyst,
    Color? indigo,
    Color? emerald,
    Color? azure,
    Color? amber,
    Color? coral,
    Color? onAccent,
  }) {
    return ThemeTokens(
      id: id ?? this.id,
      brightness: brightness ?? this.brightness,
      ink: ink ?? this.ink,
      panel: panel ?? this.panel,
      panel2: panel2 ?? this.panel2,
      line: line ?? this.line,
      text: text ?? this.text,
      muted: muted ?? this.muted,
      teal: teal ?? this.teal,
      amethyst: amethyst ?? this.amethyst,
      indigo: indigo ?? this.indigo,
      emerald: emerald ?? this.emerald,
      azure: azure ?? this.azure,
      amber: amber ?? this.amber,
      coral: coral ?? this.coral,
      onAccent: onAccent ?? this.onAccent,
    );
  }

  @override
  ThemeTokens lerp(ThemeExtension<ThemeTokens>? other, double t) {
    if (other is! ThemeTokens) return this;
    return ThemeTokens(
      id: t < 0.5 ? id : other.id,
      brightness: t < 0.5 ? brightness : other.brightness,
      ink: Color.lerp(ink, other.ink, t)!,
      panel: Color.lerp(panel, other.panel, t)!,
      panel2: Color.lerp(panel2, other.panel2, t)!,
      line: Color.lerp(line, other.line, t)!,
      text: Color.lerp(text, other.text, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
      teal: Color.lerp(teal, other.teal, t)!,
      amethyst: Color.lerp(amethyst, other.amethyst, t)!,
      indigo: Color.lerp(indigo, other.indigo, t)!,
      emerald: Color.lerp(emerald, other.emerald, t)!,
      azure: Color.lerp(azure, other.azure, t)!,
      amber: Color.lerp(amber, other.amber, t)!,
      coral: Color.lerp(coral, other.coral, t)!,
      onAccent: Color.lerp(onAccent, other.onAccent, t)!,
    );
  }
}
