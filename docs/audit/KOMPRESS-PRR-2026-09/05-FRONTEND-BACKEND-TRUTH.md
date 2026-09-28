# FRONTEND_BACKEND_TRUTH_MATRIX

Mission : **KOMPRESS-PRR-2026-09** · Collecte : **2026-09-27 UTC** · Recontrôle canonique : **2026-09-28 UTC**

Repository : `KOMFAHQ/Laundry-Express-RDC-2` · Branche : `main` · HEAD audité : `f55e775831e812e77892072c9fcfed16e4ee26fe`.
Les chemins de code cités désignent exclusivement ce HEAD, consultable [sur GitHub](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/).
Les preuves locales, leur portée et leurs limites sont indexées dans [EVIDENCE-INDEX.md](EVIDENCE-INDEX.md).

## Matrice de contrats et de sources de données

| Surface | Source frontend / API | Écart / preuve | Status |
|---|---|---|---|
| Auth normale | AuthContext + real-api ; /auth/login/refresh/me | bearer+refresh présents ; repli auth contrôlé par useMockApi ; pas de login DB réel exécuté | PARTIAL |
| Mock token | real-api.ts isMockToken() | reconnaît TOKEN- sans vérifier features.useMockApi ; nombreuses méthodes choisissent local DB | PARTIAL |
| Catalogue partenaires | DataContext.tsx:253+ ; /catalog/partners | catch→[] puis localPartnersFromStorage, même mock=false ; fusion d’attributs locaux | BROKEN pour garantie de vérité métier |
| Catalogue articles/prix | DataContext map service_types | catalogue service_types API mais articles, images et prix puisés dans tables front, défaut2 | PARTIAL |
| Candidature / approbation partenaire | DataContext.tsx:511–526 → constants.tsx apiSubmit/Approve/Reject | aucune sélection realApi dans ces callbacks ; succès/notification locale possibles | PARTIAL |
| Orders | OrderContext, real-api, order-mappers ; /orders | mapping réel présent ; preuves DB/refresh/navigateur manquantes ; exceptions à ne pas masquer | IMPLEMENTED / UNPROVEN corridor |
| Payment flow | payment-flow.ts → intents/initiate/summary | devise défaut USD vs defaults backend CDF ; summary catch peut masquer échec ; live label seulement front | BROKEN pour promesse paiement réel |
| Driver ancien client | real-api updateDriverAvailability → /driver/availability | forme absente inventaire API ; définition/tests trouvés ; usage productif non démontré | OBSOLETE probable / UNKNOWN usage |
| Rejet candidature client | real-api.rejectPartnerApplication → /partner-applications/{id}/reject | forme absente inventaire API ; DataContext passe encore par constants | PARTIAL ; pas de404 observée en runtime |
| Logistics dashboards | services/logistics-api.ts, LogisticsDrivers | résultat degraded+fallback, MOCK_DRIVERS ; banner et certaines mutations désactivées | PARTIAL, repli explicite mais données synthétiques |
| Fleet/self-service | clients logistics + routes/services company/fleet | contrats et contrôles société sur plusieurs routes ; listes génériques et WS divergent | PARTIAL / BROKEN isolation |
| Tracking | services/hook WS + /logistics/live | disponibilité reconnexion UI ≠ authorization événement ; hub global | BROKEN |
| Admin payment gateways | client→admin_payment_gateways | réponse DB/GET alimentée par seed synthétique ; test/replay de façade | PARTIAL / CLAIMED UNPROVEN effets |
| Partner integrations/team/2FA/invoice legacy | exports DataContext constants.tsx | callbacks locaux persistent avec autres pages utilisant realApi ; parcours à expliciter | PARTIAL |
| Pilot flags | config/pilot.ts | défaut development si env absent ; masque navigation, pas routes API ; paymentMode live sans effet serveur | PARTIAL / dangereux hors contrôle build |
| PWA | index/service-worker.js/manifest | SW cache GET API ; build n’émet pas dist/service-worker.js à son URL d’enregistrement | PARTIAL / activation réelle UNKNOWN |
| Content/config | plusieurs get* catch→null | pannes converties en valeurs vides/défauts, visibilité erreur incomplète | PARTIAL |

## Inventaire des endpoints

`evidence/routes.json` contient521 routes importées (incluant health et autres surfaces framework selon configuration). L’extraction automatique de219 expressions d’appel dans real-api est une **heuristique de chemins**, pas un contrat OpenAPI exhaustif. Sept formes n’ont pas correspondu : cinq correspondent à des paramètres de query interpolés, deux aux anciens chemins cités ci-dessus. Ni méthode HTTP, ni permissions, ni schéma métier n’est prouvé par un simple appariement de chemin.

Dans l’autre sens, des API d’exploitation ne sont pas censées avoir un consommateur browser : webhooks provider, certains contrôles ops, scripts d’administration et maintenance. Aucun appel front direct à `/payments/webhooks/{provider}` n’est attendu. Les routes sans consommateur identifié restent **UNKNOWN quant à leur usage**, pas automatiquement inutiles. L’inventaire joint permet une future revue route par route.

## Contrats à verrouiller avant pilote

Prix et devise doivent provenir du même contrat commande→intent→transaction→refund ; les lignes de commande ne doivent pas diverger du total calculé par serveur. Les statuts order/task/payment et identifiants partner/user/company ne sont pas interchangeables. Pour chaque mutation pilote, prouver success HTTP→commit DB→relecture nouveau navigateur ; simuler panne API et vérifier qu’aucune notification de réussite ni valeur métier locale ne remplace la panne.

Le stockage de langue/thème/devise d’affichage est distinct du stockage de partenaires, commandes, permissions ou jetons. `localStorage` d’auth est implémenté ; sa résistance à XSS n’est pas démontrée. Effacer les seules clés d’auth n’efface pas nécessairement caches métier/SW.
