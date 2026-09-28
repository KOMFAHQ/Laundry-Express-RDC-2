# Database truth

Mission : **KOMPRESS-PRR-2026-09** · Collecte : **2026-09-27 UTC** · Recontrôle canonique : **2026-09-28 UTC**

Repository : `KOMFAHQ/Laundry-Express-RDC-2` · Branche : `main` · HEAD audité : `f55e775831e812e77892072c9fcfed16e4ee26fe`.
Les chemins de code cités désignent exclusivement ce HEAD, consultable [sur GitHub](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/).
Les preuves locales, leur portée et leurs limites sont indexées dans [EVIDENCE-INDEX.md](EVIDENCE-INDEX.md).

## Graphe et bootstrap

| Vérification | Résultat | Statut |
|---|---|---|
| Révisions Alembic |61 fichiers ; parents résolus ; plusieurs merges historiques | IMPLEMENTED |
| Heads | un head d2e3f4a5b6c7 ; alembic heads exécuté | VALIDATED_LOCAL pour graphe |
| Metadata ORM |183 tables, configure_mappers() réussi | VALIDATED_LOCAL import seulement |
| Base vide→head | baseline initial crée users/profiles/refresh/reset/addresses ; révision suivante05dc81e265f7 altère tables métier non créées | BROKEN par inspection et SQL généré ; pas d’exécution PG online |
| init.sql | uuid-ossp uniquement ; aucun schéma métier bootstrap | IMPLEMENTED |
| API startup | alembic upgrade head avant uvicorn ; aucune création générale metadata trouvée dans ce chemin | IMPLEMENTED / bootstrap bloqué |
| DB existante | aucun dump, connexion ou version Alembic de cible | UNKNOWN |
| Sauvegarde/restore | aucune preuve d’exécution | UNKNOWN |

Preuve structurante : `alembic upgrade 05dc81e265f7 --sql` a produit le SQL joint. Après les cinq tables d’identité, `ALTER TABLE order_attachments` apparaît sans `CREATE TABLE order_attachments`. Le même problème concerne plusieurs tables métier, dont orders. Un DB hérité peut avoir été construit hors migrations ; c’est une hypothèse, pas une preuve. Un unique head ne garantit donc ni complétude, ni reproductibilité.

## Contraintes et intégrité

| Domaine | Protection présente | Limite actuelle |
|---|---|---|
| Identité | unicité email/phone, FK user, hashes refresh/reset | tokens reset exposés au handler ; rotation concurrente non éprouvée |
| Commandes | idempotency_key unique/indexé, order_number unique ; version/row lock pour transition ; gestion IntegrityError | clé unique globale vs recherche par client : contrat à préciser ; preuve online concurrence absente |
| Lignes/prix | Numeric(10,2), total calculé pricing | unit_price des items copié depuis requête ; cohérence lignes/total à prouver |
| Intent/transaction | FK order/customer, Numeric, provider_reference/transaction_id uniques | pas d’unicité d’intent actif ni verrou financier global ; commits paiement/commande séparés |
| Webhook | modèle provider_event_id unique | handler n’enregistre pas ce journal pour dédupliquer |
| Refund | FK intent/order, bornes unitaires vs montant payé | budget remboursable cumulé et concurrence non verrouillés |
| Commission | FK order/partner, état métier | montants Float ; order_id non unique ; check-then-insert peut doubler |
| DeliveryTask | contrainte unique order/task_type et mécanismes d’affectation présents | tests de race DB non exécutés ; périmètre utilisateur insuffisant en route |
| Loyalty/referral | ledger/config et garde métier dans services | certains débits read/modify/write sans verrou ; solde et retries à prouver |
| Index/FK/enums | nombreuses contraintes ORM/migrations | présence ORM ≠ contraintes DB réelle ; aucune mesure plans/verrous/volumétrie |

L’inventaire `migration-inventory.json` distingue opérations dans upgrade, révisions et parents. Les changements de types, contraintes et colonnes ainsi que les downgrades qui suppriment des objets nécessitent examen sur copie de données. Aucun label production-safe n’est accordé. Les enums PostgreSQL et valeurs Python exposent un risque de drift qui exige comparaison catalogue SQL réel, pas seulement import Python.

### Opérations destructrices et conversions identifiées

| Migration upgrade à risque | Opération inspectée | Risque données existantes |
|---|---|---|
| 79dde77c97d6_create_driver_dispatch_tables | drops delivered_at/picked_up_at, GPS speed/accuracy, drivers is_active/vehicle_plate ; nouveaux NOT NULL ; conversion enum | perte d’historique et échec si lignes non compatibles ; ELSE PENDING écrase sémantique inconnue |
| 9bdf5a02252b_create_pricing_engine_tables | drops partner_services unit/currency/name/description ; nouveaux champs NOT NULL ; Float→Numeric | pertes de contexte prix et conversion ; vérifier backfill/arrondi/références |
| d8c7c8e810cf_create_orders_module_tables | drops total_price/description, notes/status et anciens timestamps order ; nouveaux montants/statuts NOT NULL | données existantes non préservées automatiquement ; rollback ne reconstitue pas valeurs |
| add_payment_truth_corridor ; b2e4f6a9c1d3 | conversion montants et alignement tables/contraintes | invalides préexistants, arrondis, locks et durée à mesurer sur copie |
| 05dc81e265f7 | drops certaines contraintes UNIQUE après création indexes uniques initiaux | ne pas conclure perte d’unicité sans vérifier indexes ; baseline reste défaut premier |

Ces faits sont des opérations de code observées. Aucune durée de verrou ni perte réelle de données n’a été mesurée sur une base existante.

## Bootstrap et héritage

Les scripts seed créent profils/cataloque/données de démo et utilisent des mots de passe de développement ou variables SEED_*. Les secrets admin sont désormais exigés explicitement à l’import de Settings, point positif. Les fallback de mots de passe driver et jeux synthétiques imposent une séparation stricte avec une base pilote. Aucune exécution seed contre une cible distante n’a eu lieu.

G1 doit réparer le chemin vierge ; G2/G3 doivent établir le chemin hérité avec sauvegarde, migration répétée, counts et invariants avant/après. Ne jamais corriger ce problème par `stamp head` ou `create_all` sur une cible inconnue. Le rollback de code ne restaure pas les données ni une migration destructrice : B16 exige restore prouvé avant intervention.
