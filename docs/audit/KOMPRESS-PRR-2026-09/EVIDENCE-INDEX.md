# Evidence index et méthode reproductible

Mission : **KOMPRESS-PRR-2026-09** · Collecte : **2026-09-27 UTC** · Recontrôle canonique : **2026-09-28 UTC**

Repository : `KOMFAHQ/Laundry-Express-RDC-2` · Branche : `main` · HEAD audité : `f55e775831e812e77892072c9fcfed16e4ee26fe`.
Les chemins de code cités désignent exclusivement ce HEAD, consultable [sur GitHub](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/).
Les preuves locales, leur portée et leurs limites sont indexées dans [EVIDENCE-INDEX.md](EVIDENCE-INDEX.md).

## Convention de preuve

IMPLEMENTED = code repéré ; PARTIAL = couverture incomplète ; VALIDATED_LOCAL/CI/STAGING/PRODUCTION = exécution attestée dans ce périmètre précis ; BROKEN = défaut ou échec démontré et décrit ; CLAIMED / UNPROVEN = assertion non corroborée ; NOT IMPLEMENTED = absence dans périmètre recherché ; OBSOLETE = chemin antérieur incompatible ; UNKNOWN = information inaccessible/non établie. **IMPLEMENTED / UNPROVEN** indique explicitement code présent sans corridor exécuté.

Les fichiers ci-dessous sont des captures, pas des fixtures servant à rendre le produit vert. Les chemins absolus de logs reflètent l’exécuteur jetable de la mission. Les timestamps de commandes/API sont conservés tels quels ; seul le SHA contrôlé attribue le code, pas la date d’un ancien rapport. Les valeurs de test sont synthétiques ; aucun secret de production n’a été demandé ni consulté.

## Environnement et commandes

Checkout détaché du SHA initial ; Node24.19, Python3.12.14 ; venv isolé, dépendances Python de requirements.txt. Node CI22 est une différence explicite. Aucune création `.env` dans le produit ; variables éphémères injectées aux probes. Dépendances/build/caches locaux ignorés par git, pas de modifications source.

```sh
git ls-remote https://github.com/KOMFAHQ/Laundry-Express-RDC-2.git refs/heads/main
git rev-parse HEAD
npm ci --ignore-scripts --legacy-peer-deps
npm run build
npx vitest run
npm audit --json
# Dans apps/api, avec Python du venv et SECRET_KEY/ADMIN_PASSWORD synthétiques :
pytest -q
alembic heads
alembic upgrade 05dc81e265f7 --sql
# À la racine, Python du venv dans PATH :
node scripts/run_production_readiness_gate.mjs
python scripts/check_staging_prereqs.py
```

Les deux dernières commandes n’activent pas les E2E et ne créent pas de staging. Les contrôles de noms/routes/migrations utilisent git ls-files, rg, AST et import metadata/routes. Toute analyse heuristique est qualifiée dans les matrices. Le scan npm inclut dépendances dev ; Python/images n’ont pas fait l’objet d’un scan exhaustif d’advisories.

Probe API : import avec APP_ENV=production, SECRET_KEY et ADMIN_PASSWORD temporaires, pas de service DB démarré ; configure_mappers ; TestClient health sur Host non autorisé ; requête register rôle super_admin ; appel handler reset avec objet service stub retournant AUDIT_SYNTHETIC_TOKEN. La sortie marque explicitement DB/provider NOT tested. L’import env-example emploie la DATABASE_URL fournie, reproduisant l’absence du module psycopg ; aucun driver installé ni URI produit corrigée.

SQL offline : valide génération de SQL, pas exécution ni compatibilité données. PostgreSQL/Docker absents, installation système refusée par permissions ; apt-update.txt conserve la limite. Aucun E2E distant exécuté. L’accès Actions a permis lecture runs/jobs/logs mais pas dispatch ; page GitHub non authentifiée. L’erreur404 de première racine API publique n’a pas été utilisée comme preuve d’absence de repo.

## Inventaires et logs

| Capture | Octets | SHA256 |
|---|---|---|
| [evidence/github-summary.json](evidence/github-summary.json) | 24451 | `64d3d9f0c7e30d94c56464eb8545758a633b7b6d9929c9ced50e1dcf7a2477d8` |
| [evidence/canonical-recheck.json](evidence/canonical-recheck.json) | 358 | `7fad1ed4b3451e1741ff111cc0ac1d41727767db41750f68186e9a34c26acbe8` |
| [evidence/public-api-preflight.json](evidence/public-api-preflight.json) | 1322 | `0ad8f09788497fc2326932f36e0c24cfb5fcb963e5467191a75970e540d378e3` |
| [evidence/ci-static-job.txt](evidence/ci-static-job.txt) | 64315 | `29a06dcb8eb141f7c8fc6c7277de3a84968e9c18185b48dc1252c6b97914eb1a` |
| [evidence/npm-ci.txt](evidence/npm-ci.txt) | 704 | `315368a99da8da7a0c472b1cb7e9929ee22ddaf9fa476bc74458ec52b10c920d` |
| [evidence/frontend-build.txt](evidence/frontend-build.txt) | 1814 | `aa9ff540b479027d6657e955dc22e41eb2e992c306769a746e0457f2ee41561f` |
| [evidence/vitest.txt](evidence/vitest.txt) | 19794 | `717e6715f7f60c653f77c8a877c8ad9d4f8cc0111d165f586a924ffca4eb4417` |
| [evidence/pytest.txt](evidence/pytest.txt) | 100379 | `31d7ea32bdb3a1fe397b001820ad120863ed02e7fc06eed246d9cc3262a421b7` |
| [evidence/static-local.txt](evidence/static-local.txt) | 2258 | `299b72f2a308a9f010b68ed4d24550127eba9e1286bd41bb425a166c0a198096` |
| [evidence/runtime-probes.txt](evidence/runtime-probes.txt) | 1012 | `020b59ddb04ce4fc9a34b55660c6f4f105d9750354d0f83d844764fc5b6a1365` |
| [evidence/env-example-import.txt](evidence/env-example-import.txt) | 2431 | `f281cd2c6e4e53e9487f631b47ed1b54c20c9a7590a897fd49c0da8e0c29cb70` |
| [evidence/first-two-migrations.sql](evidence/first-two-migrations.sql) | 5998 | `635b88ce4e09c7177fe15dfa9e38e78fc220ddad681260d5f56355b533cb7fc7` |
| [evidence/alembic-offline.txt](evidence/alembic-offline.txt) | 381 | `cbe7fad241e7f1fa96518174b42fa996a4a846e654bc29ad307396a5a3c495b3` |
| [evidence/migration-inventory.json](evidence/migration-inventory.json) | 95695 | `294f82dcaa691bb94110320da830371c2a817eef72ba24756544a729c025955e` |
| [evidence/routes.json](evidence/routes.json) | 67234 | `448b89d992400dae8ed8f3c3eca77429b9cb3e2bb8dafdd12f36d1c1ff7e9837` |
| [evidence/frontend-request-inventory.json](evidence/frontend-request-inventory.json) | 21996 | `ac33de162019a459f7ebc3f64209394caa9ca4f4351b28d92b6fb6ec7a6326c1` |
| [evidence/test-file-inventory.json](evidence/test-file-inventory.json) | 17806 | `8592e6efef101c7e048b09b988c6860bb9f28eb232ee2fa6c557c0c9d477e21e` |
| [evidence/identity-inventory.json](evidence/identity-inventory.json) | 5547 | `a8ffed55d2a2faae094f58acd86f34f83461239a964f2e51483e8826a51e21d6` |
| [evidence/domain-inventory.json](evidence/domain-inventory.json) | 9200 | `8058c475827b0e716d5134dc0d105697dc6975cf202780bb40042775a6848d9a` |
| [evidence/domain-dns.json](evidence/domain-dns.json) | 731 | `222d07370459d2b31735799fb1627f48b23bad14b236430e4576cf96dd84398d` |
| [evidence/staging-prereqs.txt](evidence/staging-prereqs.txt) | 860 | `80c25100171558827f581e2f7c3f143c0dd4a790ad2fe1202c31db7eb52d1a6b` |
| [evidence/npm-audit.json](evidence/npm-audit.json) | 51898 | `338a98ae41f3534f20cb00ad29016492d808c77740f7573c6d41da0c67e31c03` |
| [evidence/apt-update.txt](evidence/apt-update.txt) | 1021 | `1c5b6b1c143c1ee03b82d05413fad9ea7c3daaa2c7fe89a2faf1aaf1574ea8fb` |
| [evidence/document-excerpts.json](evidence/document-excerpts.json) | 24180 | `635300d69d80e8c26d3cd8e0a142e232a983e2be40a2c3d5df0489745315258e` |

Les JSON GitHub incluent branches, commits, PR, runs et jobs. Pour refaire une vérification, lire le HEAD distant avant toute action puis comparer aux hashes de preuve. Les67 documents historiques sont inventoriés avant création de ce dossier ; les futurs docs d’audit ne sont pas inclus dans leur compte.
