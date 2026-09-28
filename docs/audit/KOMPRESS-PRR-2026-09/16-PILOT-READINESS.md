# Pilot readiness

Mission : **KOMPRESS-PRR-2026-09** · Collecte : **2026-09-27 UTC** · Recontrôle canonique : **2026-09-28 UTC**

Repository : `KOMFAHQ/Laundry-Express-RDC-2` · Branche : `main` · HEAD audité : `f55e775831e812e77892072c9fcfed16e4ee26fe`.
Les chemins de code cités désignent exclusivement ce HEAD, consultable [sur GitHub](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/).
Les preuves locales, leur portée et leurs limites sont indexées dans [EVIDENCE-INDEX.md](EVIDENCE-INDEX.md).

**Pilot readiness : NOT READY.** Un prototype riche et des tests locaux ne suffisent pas :8 P0 restent ouverts, le runtime fourni n’est pas reproductible depuis zéro et aucun staging n’est vérifié.

| Condition d’entrée | État actuel | Preuve de fermeture |
|---|---|---|
| Runtime reproductible | BROKEN B01/B02/B10 | clone→build→DB→API→web sur hôte vierge au SHA figé |
| Accès et données | BROKEN B03/B04/B06–B09 | tests négatifs multi-comptes + invariants DB/replay/concurrence |
| Paiement autorisé | simulation actuelle, cash non rapproché | désactivation moyens fictifs ; reçu/collecte/clôture/refund réels |
| Frontend vérité | PARTIAL B13/B14 | parcours sans source métier locale ni KPI synthétique |
| Staging | NO_STAGING_FOUND | domaine/TLS/versions/SHA/DB et navigateur vérifiés |
| Tests critiques | CI static seulement ; backend suite non verte | corridors au SHA avec artefacts et aucun skip critique |
| Terrain | UNKNOWN | pressing/dispatcher/driver/customer accomplissent collecte→atelier→livraison avec preuve |
| Exploitation | UNKNOWN / stubs | opérateurs responsables, support, alertes, backup/restore et arrêt d’urgence éprouvés |

## Plus petit périmètre envisageable après gates

Un pressing partenaire, une zone limitée, une société logistique, des clients invités et agents nommés ; catalogue/prix figés et validés. Cash supervisé uniquement si choix métier confirmé, sans carte/wallet/Mobile Money annoncé réel. Promotions/growth/subscriptions et tableaux de communication ne sont pas nécessaires au premier cycle. Masquage UI seul insuffisant : droits/routes et données démo doivent être traités.

Ce périmètre est une **proposition**, pas une décision commerciale déjà prise. Le volume maximal, les horaires, les tarifs, les responsabilités, le budget d’incident et les critères de réussite doivent être nommés par l’exploitant avant admission de vrais clients. Aucun délai arbitraire de lancement n’est donné.

## Rehearsal et arrêt

Prouver : création/auth, commande/catalogue/pricing, intent cash, collecte/reçu, dispatch et livraison, preuve de fin, rapprochement, litige/remboursement contrôlé. Tester simultanément client tiers, rôle incorrect, tenant tiers, double clic/retry, perte réseau, indisponibilité DB et cash partiel. Définir procédure manuelle si notifications externes exclues ; ne pas annoncer de livraison automatique inexistante.

STOP immédiat pilote : fuite données/permissions, divergence caisse, perte commande/preuve, impossibilité restaurer ou identifier version. Suspendre nouvelles commandes et mutations financières, conserver journaux/preuves, vérifier opérations externes avant replay ; rollback image seul ne rembourse pas ni n’annule une livraison. Un go pilote futur exige dossier de preuves G1–G6 et décision humaine opérationnelle.
