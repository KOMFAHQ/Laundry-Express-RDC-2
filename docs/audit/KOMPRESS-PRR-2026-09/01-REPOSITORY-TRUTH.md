# Repository truth et preflight

Mission : **KOMPRESS-PRR-2026-09** · Collecte : **2026-09-27 UTC** · Recontrôle canonique : **2026-09-28 UTC**

Repository : `KOMFAHQ/Laundry-Express-RDC-2` · Branche : `main` · HEAD audité : `f55e775831e812e77892072c9fcfed16e4ee26fe`.
Les chemins de code cités désignent exclusivement ce HEAD, consultable [sur GitHub](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/).
Les preuves locales, leur portée et leurs limites sont indexées dans [EVIDENCE-INDEX.md](EVIDENCE-INDEX.md).

## État canonique initial, rapporté avant toute écriture

| Champ | Observation |
|---|---|
| Repository | PUBLIC, existe, non archivé ; default branch main |
| EXPECTED_HEAD | f55e775831e812e77892072c9fcfed16e4ee26fe |
| ACTUAL_HEAD | f55e775831e812e77892072c9fcfed16e4ee26fe |
| DIFF / REASON | Aucun écart ; merge PR#12 le 2026-08-02, derniers changements applicatifs 2026-06-22 |
| Tree | fb2311de238323aacfd81f88de0afbca477aea61 |
| Branches | main ; codex/prepare-release-changes à e4b26ed730ed4392d4adc57fe1240f11fed45f4d |
| PR ouvertes | 0 au preflight |
| Main protégée | branche API protected=false ; rulesets=[] ; endpoint détaillé protection403 (pas accès administration) |
| Tags / releases | [] / [] |
| Environments / deployments | total_count0 / [] |
| Actions | 1 workflow actif, Production Readiness Gate ;10 runs retenus, tous success ; détails §08 |
| Description / topics / homepage | COPY VERVION / [] / null |
| Fichiers suivis | 1811, dont67 Markdown historiques ; aucun AGENTS.md |

Une erreur404 sur une première lecture publique de la racine API n’a pas servi de preuve d’absence : l’existence et les métadonnées ont été confirmées par le connecteur GitHub et par clone git. Les lectures environnements/tags/deployments/workflows ont été faites via API publique lorsque le connecteur ne proposait pas ces endpoints. Les secrets GitHub ne sont pas accessibles et n’ont pas été lus.

## PR récemment fusionnées

| PR | Titre | Fusion UTC | Merge SHA |
|---|---|---|---|
| #12 | Codex/prepare release changes | 2026-08-02T07:51:28Z | `f55e775831e812e77892072c9fcfed16e4ee26fe` |
| #11 | Codex/prepare release changes | 2026-06-19T07:09:03Z | `f6d44b44a690dbb277537822dd26d3bc334c5397` |
| #10 | Codex/prepare release changes | 2026-06-18T19:41:13Z | `c1e49501bf3b4596e7e9e91c881a615d856efc33` |
| #9 | Codex/prepare release changes | 2026-06-15T14:38:36Z | `7ba3919d9b2a91be18576d8914bfd23b2b75cfdc` |
| #8 | feat: prepare pilot release platform flows | 2026-06-15T09:14:03Z | `644a66e18b5f27532ae67c939dcd5260c2ed06d5` |
| #7 | Codex/prepare release changes | 2026-06-07T14:59:14Z | `3516fecfd87ac6768fdb4030bd7a2bf7c8ca148a` |
| #6 | fix: wire admin control center to real pages | 2026-06-07T13:45:42Z | `a3782732f4bc259b2eb9d8ac960fef797ff443f3` |
| #5 | Codex/prepare release changes | 2026-06-07T11:10:47Z | `6d7e318b93f4cadc500ed0325e001ad667f288e3` |
| #4 | Codex/prepare release changes | 2026-06-07T08:58:28Z | `e964f13c2358a603e08cefb90fc8dfb5c8379d69` |
| #3 | Codex/prepare release changes | 2026-06-06T22:47:19Z | `ed08ad5ebcc187d09401181f9c782db0424cb3bb` |
| #2 | Codex/prepare release changes | 2026-06-06T13:51:29Z | `4634a8dcf7426ec83362e1fedcd94b7b08b645d7` |
| #1 | Codex/prepare release changes | 2026-06-06T12:13:23Z | `6b57c2c97bc9dc72bd2498da2bcb8a435bd78667` |

La majorité des titres « Codex/prepare release changes » ne décrit pas le changement. PR#12 n’a pas de description. Les merges existent, mais une revue humaine, approbation obligatoire et checks requis ne sont pas démontrés.

## Derniers commits examinés

| SHA court | Date UTC | Sujet |
|---|---|---|
| `f55e775831e8` | 2026-08-02T07:51:27Z | Merge pull request #12 from KOMFAHQ/codex/prepare-release-changes |
| `e4b26ed730ed` | 2026-06-22T13:22:16Z | fix: silence aborted translation loads |
| `9ec9cfb37486` | 2026-06-22T12:55:20Z | fix: stabilize fuel usage endpoint |
| `aa60d4c30e28` | 2026-06-22T11:26:14Z | fix: reduce app startup flicker |
| `ace7c26e6cad` | 2026-06-22T11:12:37Z | fix: prevent app shell from hanging on load |
| `a1e1310678c0` | 2026-06-22T10:41:44Z | feat: connect TMS cockpit to advanced summaries |
| `aa4dc7639849` | 2026-06-22T10:16:21Z | feat: expose advanced TMS backend summaries |
| `a0be63058f93` | 2026-06-22T10:02:32Z | feat: add advanced TMS API contracts |
| `8448a416572f` | 2026-06-22T09:53:36Z | feat: add connectivity cockpit panel |
| `0ef035a25d6d` | 2026-06-22T09:41:28Z | feat: add stock supplies cockpit panel |
| `64f02b1ea3f1` | 2026-06-19T14:43:21Z | feat: add fuel control cockpit panel |
| `a5e5549d6892` | 2026-06-19T14:06:57Z | feat: add vehicle health cockpit panel |
| `e0bd921ab757` | 2026-06-19T13:59:07Z | feat: add operational TMS control tower |
| `b06233f24002` | 2026-06-19T13:58:16Z | feat: normalize logistics mission backlog |
| `024a273ed1e8` | 2026-06-19T07:23:04Z | feat(web): convert logistics dashboard to control tower |

## Governance

`README.md` contient toujours « Run and deploy your AI Studio app » et un démarrage Gemini. Il ne documente pas la réalité FastAPI/PostgreSQL/Redis ni les gates du pilote. CODEOWNERS, stratégie de release opposable, tags, changelog de release et rollback éprouvé non trouvés. Versions npm0.0.0/API1.0.0 ne permettent pas d’identifier un déploiement. Aucun de ces éléments n’a été corrigé pendant l’audit.

La livraison de l’audit ajoute seulement son dossier documentaire sur une branche séparée. Son commit ne devient pas le SHA applicatif audité. Une CI éventuellement déclenchée par sa PR ne remplacera pas les preuves du HEAD ci-dessus.
