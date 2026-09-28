# Production reality — synthèse

Mission : **KOMPRESS-PRR-2026-09** · Collecte : **2026-09-27 UTC** · Recontrôle canonique : **2026-09-28 UTC**

Repository : `KOMFAHQ/Laundry-Express-RDC-2` · Branche : `main` · HEAD audité : `f55e775831e812e77892072c9fcfed16e4ee26fe`.
Les chemins de code cités désignent exclusivement ce HEAD, consultable [sur GitHub](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/).
Les preuves locales, leur portée et leurs limites sont indexées dans [EVIDENCE-INDEX.md](EVIDENCE-INDEX.md).

## Verdict global : BROKEN

Ce verdict porte sur le projet canonique et son chemin de démarrage sécurisé reproductible, pas sur toutes ses fonctions prises séparément. Le frontend compile et ses 393 tests passent. L’API importe avec sa configuration asynchrone par défaut, mais la configuration fournie dans `.env.example` casse cet import ; la chaîne de migrations dépend de tables absentes de sa baseline ; des défauts d’autorisation et de reset empêchent toute ouverture réelle.

**8 P0, 13 P1, 2 P2, 1 P3** : voir [registre complet](15-BLOCKERS.md). Aucun correctif applicatif n’a été réalisé. Aucun déploiement, renommage, extraction de service ou merge n’a été effectué.

| Question | Preuve actuelle | Conclusion limitée |
|---|---|---|
| Quel code ? | main distant vérifié, SHA identique à la passation | f55e775831e812e77892072c9fcfed16e4ee26fe |
| Quel produit ? | UI/package/API/containers : Laundry Express RDC ; aucun nom Komfa trouvé dans le contenu suivi | Branding KomfaPress non appliqué au dépôt ; motif du nom historique UNKNOWN |
| Frontend fonctionne ? | build PASS ; Vitest146 fichiers/393 tests PASS | VALIDATED_LOCAL pour compilation/tests ; pas de navigateur avec API/DB réelle |
| Backend fonctionne ? | import et probes étroits PASS ; pytest202 PASS,16 FAIL,6 ERROR,56 SKIP | PARTIAL ; suite globale BROKEN dans environnement audité |
| Docker et migrations ? | configuration dev, pilote DB manquant, baseline incomplète | BROKEN pour bootstrap fourni ; Docker online non exécuté |
| CI verte ? | run30738614745 au SHA, static PASS, truth SKIPPED | VALIDATED_CI uniquement pour contrôles statiques |
| Paiements réels ? | simulation Mobile Money/refund, cash déclaratif, webhook non signé | Aucune validation fournisseur |
| Logistique réelle ? | services/tasks/fleet/UI et tests présents ; failles de périmètre REST/WS | PARTIAL / BROKEN sur isolation ; terrain UNKNOWN |
| Staging/production ? | aucune cible reliée et vérifiée ; environnements/deployments vides | NO_STAGING_FOUND dans périmètre ; production UNKNOWN, SHA UNKNOWN |

Le plus court chemin sûr conserve le monolithe : rendre le démarrage reproductible, réparer sécurité et intégrité, créer un staging traçable, puis prouver un corridor pressing/cash/logistique restreint. Aucun découpage Komfa n’est une condition du pilote.

## Ce que cette mission ne prouve pas

Absence de Docker/PostgreSQL dans l’exécuteur ; installation système bloquée par ses permissions ; pas d’accès distant DB/serveur, pas de dispatch Actions authentifié. La génération SQL offline ne remplace pas une migration online. Le probe de reset emploie un service explicitement substitué ; il prouve la fuite de réponse, pas une prise de compte sur DB réelle. Les failles de code n’impliquent pas qu’un serveur public les expose actuellement.

Les dix runs visibles et l’absence de dispatch constituent l’historique accessible, pas une garantie qu’aucun run supprimé n’a jamais existé. L’inventaire documentaire historique sert de comparaison, jamais de preuve runtime.

## Lecture recommandée

[Preuves](EVIDENCE-INDEX.md) → [blockers](15-BLOCKERS.md) → [roadmap G0–G7](17-EXECUTION-ROADMAP.md) → [verdict final](FINAL-VERDICT.md). Les matrices par domaine détaillent les limites de chaque statut.
