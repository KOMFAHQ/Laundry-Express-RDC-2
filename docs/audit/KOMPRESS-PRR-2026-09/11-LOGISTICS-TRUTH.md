# Logistics truth

Mission : **KOMPRESS-PRR-2026-09** · Collecte : **2026-09-27 UTC** · Recontrôle canonique : **2026-09-28 UTC**

Repository : `KOMFAHQ/Laundry-Express-RDC-2` · Branche : `main` · HEAD audité : `f55e775831e812e77892072c9fcfed16e4ee26fe`.
Les chemins de code cités désignent exclusivement ce HEAD, consultable [sur GitHub](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/).
Les preuves locales, leur portée et leurs limites sont indexées dans [EVIDENCE-INDEX.md](EVIDENCE-INDEX.md).

## Corridor implémenté

Order→pickup task→stratégie hybrid/marketplace→claim/assign→driver accept/start/location→preuve completion→transitions métier. Services dispatch, hybrid_dispatch, logistics_marketplace, fleet/live, modèles Driver/DeliveryTask/Vehicle/CompanyDriver et UI manager/driver/tracking existent. Les scripts driver operational corridor couvrent une mission sans admin, self-service multi-tenant et invariants DB, **mais n’ont pas été exécutés dans cette mission**.

| Capacité | Source réelle | Statut et limites |
|---|---|---|
| Pickup/delivery | routes logistics et DispatchService | IMPLEMENTED ; création par rôle sans membership systématique |
| Dispatch interne/hybrid | services et dispatch_settings | PARTIAL ;2 tests échouent sur default marketplace_only vs internal_first |
| Marketplace | sociétés, zones/communes, claim et assign | IMPLEMENTED / UNPROVEN DB/concurrence/terrain |
| Company drivers / self-service | liens société-user-driver/vehicle, routes fleet/marketplace | contrôles d’isolation présents dans plusieurs services ; ne couvrent pas les routes génériques |
| Manager | company_id et scopes operator selon route | PARTIAL ; company absente peut rejoindre branche liste globale |
| Driver | disponibilité et tâches, transitions/preuves | PARTIAL ; profil absent ne doit jamais élargir lecture |
| Tracking | GPS et événements WS, pages mobile | BROKEN isolation WS ; précision, consentement, rétention et GPS terrain UNKNOWN |
| Completion/failure | état/preuve requise et tests/scripts correspondants | IMPLEMENTED / UNPROVEN corridor réel |
| Multi-tenant REST | list/get tasks accessibles à utilisateurs authentifiés, sans propriétaire systématique | BROKEN B07 |
| Mobile | composants touch/mobile et Vitest dans393 tests | VALIDATED_LOCAL composants ; téléphone réel, réseau intermittent et GPS non validés |

Il serait inexact de déduire des anciens audits que toutes les affectations sont toujours sans verrou : le code contient désormais des mécanismes d’affectation et une unicité order/task_type, que le truth script vise explicitement. Leur efficacité concurrente sur PostgreSQL au HEAD reste non prouvée. En revanche, les absences de contrôles en routes REST/WS sont visibles indépendamment de ces mécanismes.

Le hub live utilise un set global de connexions et une liste mémoire de pending events. Aucun tenant n’est attaché aux abonnements ; tous reçoivent les événements autorisés par nom de channel. Aucun bus Redis partagé ni persistance/replay des positions n’est démontré. Multiplier les workers uvicorn peut segmenter ou perdre la diffusion ; ne pas confondre présence Redis dans compose et bus WS distribué.

## Ce qui appartient au pressing et ce qui est partageable

KomfaPress garde la disponibilité du linge, horaires/fenêtres pressing, décision ready-for-pickup/ready-for-delivery, contexte commande et expérience client. Un futur Komfa Express pourrait gérer mission générique, société/driver/vehicle, dispatch, statut de trajet, GPS et preuve livraison. Aujourd’hui tâches et order enums/FK/permissions sont couplés à la DB monolithe : la séparation ne résout pas spontanément l’isolation.

Avant tout pilote : une zone, une société, agents nommés, deux tenants de test pour négatifs, un cycle complet collecte→atelier→retour avec incident et reprise réseau. Définir qui appelle le client, qui replanifie, qui traite échec/perte et qui confirme cash. La présence d’un admin capable de forcer l’état ne remplace pas ces opérations. Pas d’extraction Komfa Express avant preuve de réutilisation et contrat stable.
