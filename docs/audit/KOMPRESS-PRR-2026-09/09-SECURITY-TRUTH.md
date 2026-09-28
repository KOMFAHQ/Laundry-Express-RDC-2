# Security truth

Mission : **KOMPRESS-PRR-2026-09** · Collecte : **2026-09-27 UTC** · Recontrôle canonique : **2026-09-28 UTC**

Repository : `KOMFAHQ/Laundry-Express-RDC-2` · Branche : `main` · HEAD audité : `f55e775831e812e77892072c9fcfed16e4ee26fe`.
Les chemins de code cités désignent exclusivement ce HEAD, consultable [sur GitHub](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/).
Les preuves locales, leur portée et leurs limites sont indexées dans [EVIDENCE-INDEX.md](EVIDENCE-INDEX.md).

**Verdict sécurité : BROKEN.** Le verdict historique « SECURED AND OPERATIONAL » n’est pas soutenu au HEAD. Revue de source et probes limités, pas de pentest distant ni de recherche d’exploitation sur une production.

| Contrôle | Réalité actuelle | Status / preuve |
|---|---|---|
| Registration privilege escalation | UserCreate limite le rôle public ; requête super_admin rejetée422 avant DB | VALIDATED_LOCAL sur rejet ; création/activation DB non prouvée |
| Hash mots de passe | bcrypt et vérification explicites ; troncature72 octets à noter dans politique | IMPLEMENTED ; unités asyncio PASS |
| JWT accès | HS256 autorisé explicitement, secret exigé, expiration ; REST get_current_user vérifie utilisateur actif | IMPLEMENTED ; aucune validation distante |
| Refresh | jeton aléatoire hashé en DB, rotation/révocation unitaire ; logout_all retourne True sans effet | PARTIAL / UNPROVEN concurrence et révocation globale ; B19 |
| Password reset | handler renvoie raw token et expiration sans garde environnement ; service enregistre hash utilisable | BROKEN B03 ; probe en production avec service stub ; pas d’attaque DB exécutée |
| RBAC objet | checks de rôle et dépendances existent mais paiements/logistique manquent propriété/tenant | BROKEN B06/B07 |
| WebSocket | JWT décodé seulement, pas user actif/type/role, événements globaux | BROKEN B08 |
| Admin | routes admin ont des checks ; distinction ADMIN/SUPER_ADMIN incohérente sur plusieurs payments | PARTIAL ; masquer nav n’est pas contrôle d’accès |
| MFA | code6 chiffres active is_2fa_enabled ; login n’exige aucun challenge | CLAIMED / UNPROVEN comme MFA ; B19 |
| Rate limit / brute force | settings déclarés mais aucun middleware/limiteur appliqué identifié | NOT IMPLEMENTED dans chemin observé ; B19 |
| CORS | liste explicite localhost, credentials=true, méthodes/headers larges | IMPLEMENTED ; config cible UNKNOWN ; pas de wildcard origine constaté par défaut |
| Trusted hosts | middleware commenté même APP_ENV=production ; probe Host externe accepté | BROKEN promesse de restriction |
| Secrets backend | SECRET_KEY/ADMIN_PASSWORD requis ; exemples/seed dev subsistent | PARTIAL ; aucune valeur réelle distante consultée |
| Secrets logs | main.py startup_event logge settings.DATABASE_URL entière, potentiellement user/password | BROKEN confidentialité du log ; aucun log de prod inspecté |
| Secrets navigateur | vite.config.ts remplace process.env.API_KEY par GEMINI_API_KEY ; constants.tsx l’utilise pour GoogleGenAI | risque d’exposition si clé injectée ; exposition d’une vraie clé UNKNOWN |
| Paiement webhook | aucune signature, binding ou journal de dedupe effectif dans handler | BROKEN B04 |
| Seed/default credentials | fallbacks développement et comptes démo ; CI propres mots de passe fixes dédiés | ne pas réutiliser en pilote ; comptes distants UNKNOWN |
| Exposition services | compose publie DB/Redis/Adminer/Mailpit sans bind loopback | BROKEN pour déploiement tel quel ; exposition Internet réelle UNKNOWN |
| Debug/docs | reload configuré ; docs/redoc retirés en production mais pas tout endpoint framework ; SQL echo en développement | PARTIAL ; env distant UNKNOWN |
| Données navigateur | localStorage tokens et données métier ; SW potentiellement cache API multi-utilisateur | PARTIAL ; risque conditionnel au SW réellement servi |
| Journal d’audit | producteurs ponctuels et tableaux d’activité distincts, partiellement seedés | PARTIAL ; intégrité/complétude/rétention non prouvées |

## Dépendances : constat et limites

Le scan npm du lock installé remonte21 paquets avec avis :2 critical,12 high,4 moderate,3 low. Ces nombres agrègent dev et runtime ; ils ne sont pas21 exploitations démontrées. Le JSON conserve chemins, conditions, range et fixAvailable. Les cas Vitest/UI et dépendances transitives doivent être triés selon exposition réelle ; aucun `audit fix` appliqué.

Les pins Python sont anciens, notamment python-multipart0.0.6 et python-jose3.3.0. L’avis mainteneur [GHSA-2jv5-9r88-3w3p](https://github.com/Kludex/python-multipart/security/advisories/GHSA-2jv5-9r88-3w3p) concerne multipart≤0.0.6 et le traitement de formulaires (correctif0.0.7). L’avis [GHSA-6c5p-j8vq-pqhj](https://github.com/advisories/GHSA-6c5p-j8vq-pqhj) concerne une confusion d’algorithme python-jose sous conditions de clés particulières ; le HS256 configuré ici ne prouve pas cette exploitabilité. Sources consultées pendant mission, pas simple reprise de rapport. **Audit complet Python/images et reachability : UNKNOWN / à effectuer.**

## Priorité

Fermer B03/B04/B06/B07/B08 avant exposition réseau ; fermer B05 avant toute assertion de paiement réel. Traiter logs/clé front, dépendances, anti-abus et credentials avant staging avec données sensibles. Tests négatifs doivent attester absence de modification/lecture inter-tenant, pas seulement codes HTTP heureux. Aucune remédiation n’a été appliquée dans cette mission.
