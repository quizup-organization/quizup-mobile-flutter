# AGENTS.md — quizup-mobile-flutter

> **Native UI Lab** : PoC Flutter pour comparer Cupertino (iOS) et Material 3 (Android)
> au rendu React Native de `quizup-mobile`.

---

## 1. Rôle

Montrer ce que Flutter propose **nativement**, sans design system QuizUp :

- écrans Accueil, Sujets, Fiche sujet, Duel ;
- navigation standard : grand titre / sliver header, tab bars, listes inset, search, segmented,
  boutons, dialogues, action sheets, bottom sheets ;
- toggle d’aperçu iOS ↔ Android et clair ↔ sombre.

**Non-goals** : auth, BFF, WebSocket, notifications, publication store, design system custom.

---

## 2. Stack

- Flutter **3.47.7**, `material_ui` **1.7.0**, `cupertino_ui` **1.1.3**.
- Android minSdk 24, compile/target 36, Java 17 ; iOS 15+.
- Aucun package UI tiers, aucune police custom, aucun token de marque.
- Les composants sont ceux de `cupertino_ui` / `material_ui` ; les rares helpers
  (`applyTopicSort`, `compactNumber`) ne touchent pas au style.

---

## 3. Structure

```
lib/
  app/quizup_app.dart        # racine : CupertinoApp ou MaterialApp selon la plateforme
  native/
    native_settings.dart     # plateforme + brightness + callbacks
    native_settings_sheet.dart
    settings_buttons.dart
    ios/                     # écrans Cupertino
    android/                 # écrans Material 3
  data/                      # modèles, fixtures, tri
  shared/format.dart         # formatage des nombres
assets/
  fixtures/fixtures.json
  images/                    # visuels + crédits
test/
  widget_test.dart           # parcours iOS + Android
  golden/screens_test.dart   # captures natives
```

### Règles

- **Pas de style custom** : pas de `ThemeData` avec couleurs/typo custom, pas de
  `CupertinoThemeData` custom, pas de composants maison.
- **Composants natifs uniquement** : `Cupertino*` sur iOS, `Material`/M3 sur Android.
- **Navigation standard** : `CupertinoSliverNavigationBar(largeTitle: ...)` et
  `SliverAppBar.large` ; `CupertinoTabScaffold`/`CupertinoTabBar` et `NavigationBar`.
- **Pas d’import legacy** : `package:flutter/material.dart` et `package:flutter/cupertino.dart`
  sont interdits (garde CI).
- **Pas de réseau** : toutes les données viennent des fixtures.

---

## 4. CI

Workflow `.github/workflows/ci.yml` :

- `quality` : `flutter analyze` + test widget des deux parcours.
- `android` : APK debug.
- `goldens` : captures 4 écrans × iOS/Android × clair/sombre.
- `ios-simulator` : build + capture simulateur.
- `web` + `deploy-pages` : preview navigateur.

Le repo est validé **sans SDK local**. Les corrections passent par un push et un run CI.

---

## 5. État

- 4 écrans natifs iOS et Android, fixtures, toggle d’aperçu, CI complète.
- Pas de backend, pas d’auth, pas de temps réel.
- Le package Android/iOS est `fr.cnadjim.quizup` : désinstaller l’app RN avant d’installer
  l’APK Flutter.
