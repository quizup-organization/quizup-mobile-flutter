# quizup-mobile-flutter — Native UI Lab

PoC Flutter pour comparer **les composants natifs iOS (Cupertino)** et **Android (Material 3)**
au rendu React Native de `quizup-mobile`.

> **Pas de design system QuizUp dans ce repo.** Aucun token de marque, aucune police custom,
> aucun composant maison. Les écrans sont construits uniquement avec les composants fournis par
> `cupertino_ui` et `material_ui`, avec les patterns de navigation standards.

## Ce que montre le PoC

| Écran | iOS (Cupertino) | Android (Material 3) |
|---|---|---|
| Accueil | `CupertinoSliverNavigationBar` grand titre, `CupertinoListSection.insetGrouped` | `SliverAppBar.large`, `Card` + `ListTile` |
| Sujets | `CupertinoSearchTextField`, `CupertinoSlidingSegmentedControl`, liste inset | `SearchBar`, `SegmentedButton`, `Card` + `ListTile` |
| Fiche sujet | grand titre, `CupertinoListTile`, `CupertinoButton.filled` | `SliverAppBar.large`, `Card`, `FilledButton` |
| Duel | `CupertinoListTile`, `CupertinoAlertDialog` | `RadioGroup`/`RadioListTile`, `AlertDialog`, `SnackBar` |
| Réglages d’aperçu | `CupertinoActionSheet` | `ModalBottomSheet`, `SwitchListTile` |

Le bouton d’aperçu dans la barre de navigation permet de basculer **iOS ↔ Android** et
**clair ↔ sombre** sur le même appareil.

## Versions

- Flutter **3.47.7** (Dart 3.13.5)
- `material_ui` **1.7.0**
- `cupertino_ui` **1.1.3**
- Android `minSdk` 24, compile/target 36, Java 17
- iOS 15+

## Données

Aucun backend, aucune authentification. Les écrans lisent
`assets/fixtures/fixtures.json` et des images embarquées.
Les crédits images sont dans [`assets/images/CREDITS.md`](assets/images/CREDITS.md).

## CI uniquement

Le repo est volontairement validé sans SDK local :

- **Quality** : `flutter analyze`, test widget du parcours iOS et Android.
- **Android** : APK debug en artifact `quizup-flutter-debug-apk`.
- **iOS** : build simulateur + capture `quizup-flutter-ios-screenshot`.
- **Goldens** : captures des 4 écrans × iOS/Android × clair/sombre.
- **Web** : build déployé sur GitHub Pages.

Preview web : <https://quizup-organization.github.io/quizup-mobile-flutter/>

Pour récupérer les artifacts :

```bash
gh run list --repo quizup-organization/quizup-mobile-flutter --limit 5
gh run download <run-id> --repo quizup-organization/quizup-mobile-flutter -n quizup-flutter-debug-apk
```

### Installation Android

Le package est `fr.cnadjim.quizup`, comme l’app React Native : il faut désinstaller l’app RN
avant d’installer l’APK Flutter, puis réinstaller l’APK RN pour revenir en arrière.

```bash
adb uninstall fr.cnadjim.quizup
adb install app-debug.apk
```

## Développement local (optionnel)

Le repo ne dépend pas d’un SDK local pour la CI, mais si Flutter 3.47.7 est disponible :

```bash
flutter pub get
flutter analyze
flutter test test/widget_test.dart
flutter test test/golden --update-goldens
flutter run -d <device>
```

## Hors périmètre

- Authentification, BFF, WebSocket, notifications.
- Design system QuizUp, thèmes de marque, composants custom.
- Publication store / TestFlight.
- Parité fonctionnelle complète avec `quizup-mobile`.
