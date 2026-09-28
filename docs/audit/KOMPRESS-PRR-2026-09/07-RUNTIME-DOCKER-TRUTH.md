# Docker et runtime truth

Mission : **KOMPRESS-PRR-2026-09** · Collecte : **2026-09-27 UTC** · Recontrôle canonique : **2026-09-28 UTC**

Repository : `KOMFAHQ/Laundry-Express-RDC-2` · Branche : `main` · HEAD audité : `f55e775831e812e77892072c9fcfed16e4ee26fe`.
Les chemins de code cités désignent exclusivement ce HEAD, consultable [sur GitHub](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/).
Les preuves locales, leur portée et leurs limites sont indexées dans [EVIDENCE-INDEX.md](EVIDENCE-INDEX.md).

## Fichiers réellement inspectés

`docker-compose.yml`, `infra/docker/{api,worker,web}.Dockerfile`, `web.Dockerfile`, `apps/web/Dockerfile.txt`, `.env.example`, templates staging, `infra/db/init.sql`, `infra/scripts/wait-for-db.sh`, `infra/nginx/staging-ws.conf.example`, configuration FastAPI et Celery.

| Service | Image / commande | Ports hôte / stockage | Évaluation |
|---|---|---|---|
| db | postgres:16 |5434→5432 ; postgres_data ; init extension | health pg_isready ; identifiants dev fixés dans compose ; privé réseau non imposé |
| redis | redis:7-alpine |6379→6379 ; pas de volume/auth définis | health ping ; état queue non durable démontré |
| api | python3.12-slim + runtime requirements ; migrate puis uvicorn --reload |18000→8000 ; bind source/scripts/env | non-root ; db/redis healthy ; mauvaise URI psycopg fournie ; liveness faible |
| worker | python3.12-slim ; celery worker | bind source ; broker Redis | non-root ; dépend de db/redis mais pas fin migration ; pas de health dédié |
| web | node22-alpine ; npm install puis Vite dev |3003 ; bind dépôt + node_modules anonyme | root ; install à chaque start ; env pilot/sandbox ; API dépendance sans readiness |
| mailpit | axllent/mailpit:latest |8025 UI /1025 SMTP | outil local exposé par compose ; aucune preuve d’exposition Internet réelle |
| adminer | adminer:latest |8080 | console DB locale ; aucune garde production compose |

Tous ces ports sont publiés sans bind explicite127.0.0.1. Le réseau laundry_network est un bridge unique ; seules les données PostgreSQL ont un volume nommé. Pas de pin par digest, limites ressources, politique restart, journaux rotatifs, sauvegarde automatisée ou TLS complet démontrés. Les secrets de `.env` montés et les defaults ne constituent pas un gestionnaire de secrets.

Les Dockerfiles API/worker **séparent correctement** requirements.runtime.txt des outils pytest/black/mypy de requirements.txt. Ne pas réutiliser l’ancienne critique « toutes les dépendances dev dans image API ». L’image web reste une image de développement. Le Dockerfile racine et celui en `.txt` attendent `.next` et `npm start`, incompatibles avec le projet Vite qui émet `dist` et n’a pas de script start.

## Production configuration exists ?

**NOT IMPLEMENTED comme configuration production complète et utilisable dans le dépôt audité.** Un nginx est commenté dans compose et un exemple WebSocket existe ; ni l’un ni l’autre n’établit un reverse proxy TLS déployé. APP_ENV=production change certaines options de l’application, mais ne transforme pas compose en runtime production.

## Exécution réelle

Docker, PostgreSQL et Redis ne sont pas disponibles dans l’exécuteur. L’installation système a échoué sur permissions setuid/setgroups ; pas de contournement. Aucun `docker compose up` ni build image n’est donc déclaré réussi. Le build frontend Node et l’import/probes Python sont documentés séparément.

La copie de `.env.example` est utilisée aussi par truth-e2e ; DATABASE_URL emploie postgresql+psycopg alors que seuls asyncpg/psycopg2 sont installés. Ce défaut a été reproduit à l’import sans toucher au produit. Un redémarrage sur une DB héritée ne corrige pas cette erreur de dépendance.

`/health` a répondu200/healthy en mode production sans DB, et avec un Host non autorisé par la configuration. C’est une liveness de processus, pas une readiness. La version1.0.0 ne permet pas de prouver le SHA d’une instance. Aucune affirmation « Docker local works » n’est utilisée ici.
