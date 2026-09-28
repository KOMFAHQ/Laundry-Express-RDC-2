# PRODUCT_IDENTITY_TRUTH_MATRIX

Mission : **KOMPRESS-PRR-2026-09** · Collecte : **2026-09-27 UTC** · Recontrôle canonique : **2026-09-28 UTC**

Repository : `KOMFAHQ/Laundry-Express-RDC-2` · Branche : `main` · HEAD audité : `f55e775831e812e77892072c9fcfed16e4ee26fe`.
Les chemins de code cités désignent exclusivement ce HEAD, consultable [sur GitHub](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/).
Les preuves locales, leur portée et leurs limites sont indexées dans [EVIDENCE-INDEX.md](EVIDENCE-INDEX.md).

Recherche insensible à la casse dans tous les fichiers suivis, avec variantes Laundry Express, Laundry-Express, laundry_express, KomfaPress, Komfa Press, Komfa Express et Komfa. Les noms Komfa n’apparaissent pas dans le contenu source/documentaire au HEAD ; le propriétaire GitHub KOMFAHQ n’est pas un changement de marque du produit.

| Surface | Identité observée | Statut | Evidence |
|---|---|---|---|
| Repository | Laundry-Express-RDC-2 | IMPLEMENTED | métadonnées GitHub |
| Titre navigateur / header | Laundry Express RDC / Laundry Express | IMPLEMENTED | index.html ; components/Header.tsx (inventaire exact dans evidence) |
| Métadonnées projet | Copy of Laundry Express RDC | IMPLEMENTED | metadata.json |
| Package/version | laundry-express-rdc /0.0.0 | IMPLEMENTED | package.json |
| API title/version | Laundry Express RDC /1.0.0 | IMPLEMENTED | apps/api/app/core/config.py, main.py |
| Containers/réseau | laundry_db, laundry_api, laundry_web, laundry_worker, laundry_redis, laundry_network | IMPLEMENTED | docker-compose.yml |
| PostgreSQL | laundry_express / laundry_user | IMPLEMENTED | compose, .env.example, core/config.py ; runtime distant UNKNOWN |
| Cache/SW | laundry-express-cache-v4 ; laundry_ | IMPLEMENTED | service-worker.js, core/config.py |
| Manifest/assets | Laundry Express RDC et visuels actuels | IMPLEMENTED | manifest.json ; index.html ; actifs suivis |
| Emails / templates | @laundryexpress.cd, expéditeur Laundry Express RDC | IMPLEMENTED | core/config.py ; templates/seed ; acheminement réel UNKNOWN |
| URLs | localhost ports3003/18000 ; domaines laundryexpress.cd dans exemples/seeds | IMPLEMENTED / UNPROVEN | inventaire domaines ; pas de rattachement serveur vérifié |
| Documentation | Laundry Express RDC, SRC2 et anciens audits | IMPLEMENTED |67 fichiers historiques ; README AI Studio OBSOLETE |
| KomfaPress / Komfa Express | appellations dans la passation utilisateur ; absentes du dépôt audité | CLAIMED / UNPROVEN | recherche suivie exhaustive ; aucun commit de migration identité identifié |

**Pourquoi ce nom de dépôt persiste : UNKNOWN.** Le mot « Copy » et le suffixe2 sont compatibles avec un héritage de copie, mais ne prouvent ni la décision commerciale ni une raison de report du renommage. Aucun ADR ou décision de branding retrouvée ne permet de trancher. Il faut une décision du propriétaire, distincte du constat technique.

Identité de travail pour cette mission : **KomfaPress (nom demandé) / Laundry Express RDC (identité réellement implémentée)**. Aucun renommage, remplacement d’email, de domaine, de DB ou d’asset effectué. B24 propose un inventaire de dépendances avant toute future opération.
