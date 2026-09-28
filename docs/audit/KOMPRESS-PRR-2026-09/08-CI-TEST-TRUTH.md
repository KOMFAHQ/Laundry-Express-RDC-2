# CI et test truth — preuves au HEAD

Mission : **KOMPRESS-PRR-2026-09** · Collecte : **2026-09-27 UTC** · Recontrôle canonique : **2026-09-28 UTC**

Repository : `KOMFAHQ/Laundry-Express-RDC-2` · Branche : `main` · HEAD audité : `f55e775831e812e77892072c9fcfed16e4ee26fe`.
Les chemins de code cités désignent exclusivement ce HEAD, consultable [sur GitHub](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/).
Les preuves locales, leur portée et leurs limites sont indexées dans [EVIDENCE-INDEX.md](EVIDENCE-INDEX.md).

## Ce qui tourne effectivement

`.github/workflows/production-readiness.yml` contient bien **static-gate** et **truth-e2e**.

| Événement | static-gate | truth-e2e |
|---|---|---|
| push main/master/develop | exécuté | SKIPPED |
| pull_request | exécuté | SKIPPED |
| workflow_dispatch input omis/false | exécuté | SKIPPED |
| workflow_dispatch run_truth_e2e=true | exécuté puis condition needs | éligible, si static réussit |

Le static installe Python requirements, puis lance le script Node. Il n’installe pas npm, ne compile pas le frontend, ne lance pas Vitest/pytest, Docker ou un browser. Les21 contrôles statiques inspectent textes/fichiers et nombre de heads Alembic. Exemple : le check DataContext passe alors que la lecture locale des partenaires subsiste ; il cherche un motif, pas la propriété sémantique « aucune donnée métier mock ».

Le truth déclaré démarre uniquement **db, redis, api**, après copie `.env.example` et ajout de mots de passe CI. Il attend `/health`, lance six corridors du gate puis `verify_driver_operational_corridor.py`. Ce dernier importe self-service et invariants logistiques. Les six étapes sont customer, loyalty/referral, promotion, growth engine, API smoke et consommation promo/pricing. **Ni web, worker, Mailpit, Adminer, ni browser ne sont démarrés par ce job.** Aucun upload d’artefacts de preuve explicite n’est configuré. Les logs API ne sont demandés qu’en cas d’échec.

## Run exact audité

Workflow : Production Readiness Gate, ID296179163. [Run30738614745](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/actions/runs/30738614745), push du 2026-08-02, SHA f55e775831e812e77892072c9fcfed16e4ee26fe, conclusion success.

| Job | Job ID | Résultat | Preuve |
|---|---|---|---|
| static-gate |91471856706 | success | logs téléchargés ; checkout du SHA confirmé ;21/21 ; six E2E SKIPPED |
| truth-e2e |91471898370 | skipped | jobs API : aucune étape exécutée |

Le statut vert est **VALIDATED_CI pour la gate statique seulement**. Il n’est ni VALIDATED_STAGING, ni validation production. L’historique accessible comporte10 runs (5 push,5 PR), aucun workflow_dispatch. « A déjà exécuté truth-e2e » : **aucune preuve dans l’historique disponible** ; d’anciens runs supprimés ou externes restent UNKNOWN.

| Run | Événement | SHA | Conclusion workflow |
|---|---|---|---|
| [30738614745](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/actions/runs/30738614745) | push | `f55e775831e812e77892072c9fcfed16e4ee26fe` | success |
| [30738544236](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/actions/runs/30738544236) | pull_request | `e4b26ed730ed4392d4adc57fe1240f11fed45f4d` | success |
| [27811122079](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/actions/runs/27811122079) | push | `f6d44b44a690dbb277537822dd26d3bc334c5397` | success |
| [27811117786](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/actions/runs/27811117786) | pull_request | `2552d946a7136dc20bc77519c5e83479fc2a9b2b` | success |
| [27784801804](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/actions/runs/27784801804) | push | `c1e49501bf3b4596e7e9e91c881a615d856efc33` | success |
| [27784785180](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/actions/runs/27784785180) | pull_request | `b3509981b32f8649f0cbb3b70548bc34f9f41495` | success |
| [27554038105](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/actions/runs/27554038105) | push | `7ba3919d9b2a91be18576d8914bfd23b2b75cfdc` | success |
| [27554025244](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/actions/runs/27554025244) | pull_request | `a3ca09638a33c8d0efca057cd083ce350a1e24c0` | success |
| [27536130419](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/actions/runs/27536130419) | push | `644a66e18b5f27532ae67c939dcd5260c2ed06d5` | success |
| [27536124301](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/actions/runs/27536124301) | pull_request | `563c74ed8d3f713c9b09eb54694008ff66f810aa` | success |

## Tentative de lancement truth pendant mission

**NOT EXECUTED.** Le connecteur permet lecture Actions mais n’offre pas de workflow_dispatch. Le navigateur GitHub consulté n’était pas authentifié. L’exécuteur ne dispose pas de Docker et l’installation de dépendances système est bloquée. Aucune fausse valeur run ID n’est produite. Après B01/B02 et obtention de l’accès nécessaire, lancer sur une ref figée au SHA à tester avec run_truth_e2e=true, puis vérifier le head_sha retourné. Un dispatch sur `main` qui a bougé ne sera pas une preuve de ce HEAD.

## Matrice des exécutions pendant cet audit

| Test/check | Existe | Exécuté HEAD courant | Résultat | Portée exacte |
|---|---|---|---|---|
| npm ci --ignore-scripts --legacy-peer-deps | lock présent | oui | PASS568 packages | scripts d’installation désactivés ; Node24.19 vs CI22 |
| npm run build | oui | oui | PASS | tsc -b + Vite8.0.1 ; pas de browser/API ; bundle principal3.225MB |
| npx vitest run |146 fichiers | oui |393 PASS | jsdom/components/services/mocks ; warnings act ; aucune DB réelle |
| pytest -q | backend | oui |202 PASS,16 FAIL,6 ERROR,56 SKIP |280 cas ; aucune prétention de suite verte |
| gate statique Node | oui | oui |21/21 + repo-safety PASS | six corridors explicitement SKIPPED |
| Alembic heads / graphe |61 révisions | oui |1 head ;0 parent manquant | ne valide pas SQL contre DB |
| Alembic deux premières migrations --sql | oui | oui | SQL émis | met en évidence baseline manquante ; pas de succès migration online |
| API import / configure_mappers | oui | oui | PASS avec URI défaut asyncpg |183 tables metadata,521 routes, pas de DB |
| Probes production TestClient | handlers existants | oui | health200 sans DB ; register super_admin422 ; reset renvoie jeton stub | scope étroit, service reset substitué explicitement |
| Import avec DATABASE_URL .env.example | oui | oui | FAIL ModuleNotFoundError psycopg | reproduit un blocage bootstrap sans corriger env produit |
| check_staging_prereqs.py | oui | oui | NO-GO variables requises absentes | cible non configurée ici |
| Smoke/roles/payment/refund/dispute/commission/logistics scripts | oui | non | UNPROVEN | nécessite API/DB cible isolée ; existence inventoriée |
| Truth pytest opt-in | oui | non/skip | SKIPPED | pas de promotion de statut |
| browser_ui_flow_check.mjs | oui, CDP | non | UNPROVEN | aucun browser avec stack réelle |
| staging harness / ws probe | oui | non contre distant | UNPROVEN | aucun domaine cible vérifié |
| Docker/images/online migration/worker | oui config | non | UNKNOWN exécution | outils système indisponibles |
| npm audit --json | oui outil | oui |21 vulnérabilités de paquets |2 critical,12 high,4 moderate,3 low ; prod+dev ; exploitabilité séparée |

## pytest : détail qui empêche le vert

- 12 FAIL variantes AnyIO trio : ModuleNotFoundError trio ; variantes asyncio passent. Défaut environnement de test dépendances.
- 2 FAIL hybrid dispatch : tests attendent internal_first, résultat marketplace_only. Divergence contrat réelle ; décider politique métier avant changement.
- 2 FAIL public blog : hostname db non résolu dans cet environnement.
- 4 ERROR orders_stability_real : PostgreSQL localhost5433 indisponible (compose documente5434) ; pas de preuve sur idempotence/concurrence réelle.
- 2 ERROR SMS/WhatsApp : fixture db_session manquante.
- 56 SKIP : familles legacy auth/orders/payments/marketplace marquées skip et truth opt-in. Ce ne sont pas56 réussites.

Les scripts `test:production-readiness-e2e` et `test:production-readiness-gate` pointent au même script ; le nom E2E seul n’active rien : TRUTH_RUN_E2E=1 reste nécessaire. Aucun test ni expectation n’a été modifié pour faire passer cette mission.
