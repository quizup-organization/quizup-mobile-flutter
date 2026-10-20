# Native UI inventory

Ce document liste uniquement des composants **standard** de Flutter. Aucun style QuizUp.

## Navigation

| Pattern | iOS | Android |
|---|---|---|
| Onglets | `CupertinoTabScaffold` + `CupertinoTabBar` | `Scaffold` + `NavigationBar` |
| Grand titre | `CupertinoSliverNavigationBar(largeTitle:)` | `SliverAppBar.large` |
| Route détail | `CupertinoPageRoute` | `MaterialPageRoute` |
| Bouton barre | `CupertinoButton` + `CupertinoIcons` | `IconButton` |

## Listes et formulaires

| Usage | iOS | Android |
|---|---|---|
| Sections | `CupertinoListSection.insetGrouped` | `Card` + `Column` |
| Ligne | `CupertinoListTile` | `ListTile` |
| Chevron | `CupertinoListTileChevron` | `Icon(Icons.chevron_right)` |
| Recherche | `CupertinoSearchTextField` | `SearchBar` |
| Tri | `CupertinoSlidingSegmentedControl` | `SegmentedButton` |
| Choix | `CupertinoListTile` + coche | `RadioGroup` + `RadioListTile` |
| CTA | `CupertinoButton.filled` | `FilledButton` |

## Feedback

| Usage | iOS | Android |
|---|---|---|
| Dialogue | `CupertinoAlertDialog` | `AlertDialog` |
| Actions | `CupertinoActionSheet` | `showModalBottomSheet` |
| Toast | — | `SnackBar` |
| Progression | — | `LinearProgressIndicator` |
| Thème | actions dans l’action sheet | `SwitchListTile` |

## Écrans

### Accueil

- iOS : grand titre « Accueil », trois `CupertinoListSection.insetGrouped` (Top 10, suivis,
  nouveaux), vignettes carrées dans `CupertinoListTile.leading`.
- Android : `SliverAppBar.large`, sections `Text` + `Card`/`ListTile`.

### Sujets

- iOS : `CupertinoSearchTextField`, `CupertinoSlidingSegmentedControl` (Populaires/A-Z/Récents),
  liste inset.
- Android : `SearchBar`, `SegmentedButton`, liste de `Card`/`ListTile`.

### Fiche sujet

- Image pleine largeur, sections Statistiques / Maîtrise / Classement / À propos.
- CTA « Lancer un duel ».
- iOS : `CupertinoButton.filled` ; Android : `FilledButton`.

### Duel

- Question + 4 réponses, score, progression.
- iOS : `CupertinoListTile` avec `check_mark`/`xmark`, résultat en `CupertinoAlertDialog`.
- Android : `RadioGroup`/`RadioListTile`, `SnackBar` de feedback, résultat en `AlertDialog`.

### Réglages d’aperçu

- iOS : `CupertinoActionSheet` (iOS/Android, clair/sombre, annuler).
- Android : `showModalBottomSheet` + `ListTile` + `SwitchListTile`.
