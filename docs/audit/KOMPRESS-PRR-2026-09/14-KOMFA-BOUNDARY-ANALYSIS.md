# Analyse des frontières Komfa après constat

Mission : **KOMPRESS-PRR-2026-09** · Collecte : **2026-09-27 UTC** · Recontrôle canonique : **2026-09-28 UTC**

Repository : `KOMFAHQ/Laundry-Express-RDC-2` · Branche : `main` · HEAD audité : `f55e775831e812e77892072c9fcfed16e4ee26fe`.
Les chemins de code cités désignent exclusivement ce HEAD, consultable [sur GitHub](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/).
Les preuves locales, leur portée et leurs limites sont indexées dans [EVIDENCE-INDEX.md](EVIDENCE-INDEX.md).

**Recommandation : conserver le monolithe pour le premier pilote après hardening.** Aucun bénéfice d’extraction n’est nécessaire pour réparer bootstrap, droits, transactions et preuves. L’existence éventuelle d’autres projets Komfa ne prouve pas qu’ils soient prêts à recevoir ces responsabilités.

| Frontière | Couplage actuel | Bénéfice éventuel | Coût / risque | Ordre proposé | Nécessaire avant pilote ? |
|---|---|---|---|---|---|
| KomfaPress | catalogue, pricing, orders, opérations pressing, partenaires, UI et DB partagée | responsabilité métier claire | stabiliser états et ownership ; aucun nouveau service requis |1 : expliciter modules/contracts dans monolithe | Oui pour responsabilité ; aucune extraction |
| KomfaPay | PaymentService écrit intent/order/refund/commission et déclenche loyalty/referral/promo | providers, ledger, webhook et réconciliation réutilisés | élevé : atomicité interservices, doubles événements, migration soldes et opérations ; service cible non audité |2 : isoler adaptateur après invariants ;3 : une méthode/provider test ; bascule contrôlée plus tard | Non ; cash supervisé peut suffire après sécurisation |
| Komfa Express | tasks FK orders, enums, driver/company, preuve/notifications et WS partagés | dispatch/driver/tracking communs à plusieurs métiers | élevé : tenants, latence, resynchronisation, ownership de preuve, GPS/rétention | après corridor terrain stable ; interface mission générique et événements versionnés | Non ; une société et zone dans monolithe suffisent si isolation réparée |
| Komfa Engage | notification_service, email/SMS/WhatsApp dashboards, workers en partie stubs | délivrabilité, préférences, templates, retries centralisés | moyen puis élevé si workflows critiques ; éviter faux delivery status et fuite destinataires | après preuve du canal réellement utile ; commencer par notification transactionnelle restreinte | Non ; canal manuel explicite possible si opérateurs peuvent tenir le volume |

Les coûts sont qualitatifs, fondés sur dépendances code observées ; aucune estimation financière/calendaire inventée. Le coût d’un service comprend son exploitation, son auth interservices, ses SLA et ses procédures d’incident, pas seulement déplacer des fichiers.

## Contrats minimaux avant une extraction ultérieure

KomfaPress reste autorité sur order et prix. KomfaPay émettrait événements de mouvement financier authentifiés, idempotents et rapprochables ; un timeout ne doit pas être traduit en succès/échec définitif. Komfa Express accepterait une mission avec référence externe, périmètre tenant, fenêtres, adresses et preuve ; il ne décide pas de la disponibilité du linge dans l’atelier. Komfa Engage rapporterait accepted/sent/delivered/failed séparément.

Préalables : identifiants stables, ownership de données, contrat versionné, inbox/outbox ou équivalent fiable lorsque nécessaire, reprise idempotente et rapprochement. N’ajouter ces mécanismes distribués qu’au moment où une dépendance distante réelle les justifie.

## Critère de décision après pilote

Extraire seulement si plusieurs produits consomment réellement la même capacité, si équipe/exploitation cible prouvent leur disponibilité et si coût de couplage dépasse coût de séparation. Évaluer d’abord KomfaPay lorsqu’un fournisseur réel est requis ; la sécurité des callbacks doit être corrigée immédiatement dans le système effectivement exposé, sans attendre l’extraction.

Aucun renommage, migration de données, appel KomfaPay, extraction Express ou branche applicative n’a été créé pendant cet audit.
