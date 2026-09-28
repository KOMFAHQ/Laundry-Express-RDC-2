# Staging et production truth

Mission : **KOMPRESS-PRR-2026-09** · Collecte : **2026-09-27 UTC** · Recontrôle canonique : **2026-09-28 UTC**

Repository : `KOMFAHQ/Laundry-Express-RDC-2` · Branche : `main` · HEAD audité : `f55e775831e812e77892072c9fcfed16e4ee26fe`.
Les chemins de code cités désignent exclusivement ce HEAD, consultable [sur GitHub](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/).
Les preuves locales, leur portée et leurs limites sont indexées dans [EVIDENCE-INDEX.md](EVIDENCE-INDEX.md).

**Remote staging status : NO_STAGING_FOUND** dans les sources et accès examinés. **Production status : UNKNOWN. PRODUCTION_SHA = UNKNOWN.** L’absence de preuve accessible n’établit pas qu’aucun serveur n’existe hors de ce périmètre.

| Chaînon | Recherche / preuve | Résultat |
|---|---|---|
| GitHub repository | homepage=null ; description générique | aucun domaine publié |
| Environments | API publique total_count0 | aucun environnement déclaré |
| Deployments | API publique [] | aucune liaison environnement/SHA |
| Tags/releases | [] | aucun artefact de release identifié |
| CI | workflow local Docker conditionnel seulement | pas de job deploy/staging/production |
| Config | .env.staging*.example, scripts PowerShell/harness | templates avec placeholders ; pas d’instance |
| Secrets | accès secrets GitHub non offert ; aucune valeur demandée/lue | UNKNOWN ; noms de config ne prouvent pas secrets installés |
| Staging prereqs | script exécuté : STAGING_API_BASE_URL et URLs DB absentes | NO-GO dans l’exécuteur |
| DNS candidats | domaines laundryexpress.cd issus de seeds/exemples ; essais résolution journalisés | erreur temporaire resolver ; **pas** preuve NXDOMAIN ou panne du service |
| TLS / HTTP frontend / /health | aucune cible autoritative identifiée | NOT TESTED / UNKNOWN |
| Auth non destructive / browser smoke | aucun compte/cible distant vérifié | NOT TESTED / UNKNOWN |
| Hôte/container runtime | aucun hôte relié au projet et accessible | UNKNOWN |
| PostgreSQL / backups | aucune connexion/dump/version cible | UNKNOWN |
| SHA runtime | API retourne version1.0.0 sans SHA ; aucune attestation déploiement | UNKNOWN |

Les domaines api/support/finance/dispatch.laundryexpress.cd rencontrés dans seeds/intégrations sont des chaînes de démonstration possibles, pas une preuve de services disponibles. Les ressources cloud ou serveurs d’autres projets ne sont pas attribués à celui-ci par supposition. Les documents STAGING_HANDOFF/STAGING_GATE_REPORT reconnaissent eux-mêmes l’absence de preuve distante ; « simulation locale de staging » reste LOCAL TEST.

Aucune mutation distante, auth d’utilisateur réel, seed, script destructif ou migration n’a été exécuté. Les harnesses existants peuvent créer des comptes/commandes et toucher DB ; ils ne doivent pas être lancés sur une URL découverte sans environnement isolé et périmètre autorisé.

## Preuve minimale future

Enregistrer domaine→DNS→TLS valide→frontend digest/SHA→API /version et readiness→image digest→deployment GitHub→SHA exact→configuration expurgée→migration head et DB cible. Prendre en compte CDN/cache frontend : le SHA API seul ne certifie pas le code browser. Vérifier endpoints publics et unauthorized401/403, puis smoke avec compte isolé autorisé. Refaire après chaque promotion et tester rollback/restore.

Sans cette chaîne et corridors critiques prouvés, aucun statut VALIDATED_STAGING, PILOT READY ou VALIDATED_PRODUCTION n’est autorisé par cette mission.
