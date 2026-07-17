/// Built-in appearance themes (SPEC §7.7). Only [dark] is fully tokenized in v0.
enum ThemeId {
  light,
  solarizedLight,
  dark,
  black,
  solarizedDark,
}

extension ThemeIdLabel on ThemeId {
  String get label => switch (this) {
        ThemeId.light => 'Light',
        ThemeId.solarizedLight => 'Solarized Light',
        ThemeId.dark => 'Dark',
        ThemeId.black => 'Black',
        ThemeId.solarizedDark => 'Solarized Dark',
      };
}
