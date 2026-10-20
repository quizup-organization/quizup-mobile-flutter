# Évaluation — Flutter natif vs React Native

## Artefacts de comparaison

| Artefact | Où |
|---|---|
| APK Android | GitHub Actions → `quizup-flutter-debug-apk` |
| Captures iOS Simulator | GitHub Actions → `quizup-flutter-ios-screenshot` |
| Captures 4 écrans × 2 plateformes × clair/sombre | GitHub Actions → `quizup-flutter-goldens` |
| Preview web | <https://quizup-organization.github.io/quizup-mobile-flutter/> |

## Grille

| Axe | À observer |
|---|---|
| Fidélité native | Les composants sont-ils ceux d’iOS/Android, sans surcharge visuelle ? |
| Navigation | Grand titre, tab bar, back gesture, transitions : sensation native ? |
| Listes | Densité, séparateurs, chevrons, inset grouping, scroll. |
| Formulaires | Recherche, segmented, radio, clavier, focus. |
| Feedback | Dialogues, action sheets, bottom sheets, snackbars, haptics. |
| Performance | Démarrage, scroll, fluidité des transitions. |
| Coût | Temps passé par écran, code nécessaire, friction des APIs. |

## Procédure

1. Installer l’APK Flutter sur Android (désinstaller l’app RN d’abord).
2. Ouvrir la preview web sur iPhone Safari ou regarder les captures iOS Simulator.
3. Tester le toggle iOS/Android et clair/sombre.
4. Comparer avec les écrans RN équivalents (Accueil, Sujets, Fiche sujet, Duel).
5. Noter les écarts P1/P2 et le temps nécessaire pour obtenir chaque écran.

## Décision

- **Flutter convaincant** : poursuivre avec une tranche fonctionnelle (auth + BFF).
- **Composants natifs insuffisants** : garder RN ou explorer un design system tiers.
- **Écart de coût trop important** : arrêter le PoC.
