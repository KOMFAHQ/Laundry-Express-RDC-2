# Index de preuves source épinglées

Mission : **KOMPRESS-PRR-2026-09** · Collecte : **2026-09-27 UTC** · Recontrôle canonique : **2026-09-28 UTC**

Repository : `KOMFAHQ/Laundry-Express-RDC-2` · Branche : `main` · HEAD audité : `f55e775831e812e77892072c9fcfed16e4ee26fe`.
Les chemins de code cités désignent exclusivement ce HEAD, consultable [sur GitHub](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/).
Les preuves locales, leur portée et leurs limites sont indexées dans [EVIDENCE-INDEX.md](EVIDENCE-INDEX.md).

Les liens visent le SHA applicatif audité, pas la branche documentaire ni le futur main. Un lien de code justifie un constat statique ; il ne prouve aucune exécution DB ou distante. Les preuves d’exécution restent dans EVIDENCE-INDEX.md.

| Constat | Source immuable | Repère |
|---|---|---|
| B01 / config | [.env.example:16](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/.env.example#L16) | DATABASE_URL |
| B01 / dépendances | [apps/api/requirements.runtime.txt:9](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/apps/api/requirements.runtime.txt#L9) | asyncpg |
| B01 / engine | [apps/api/app/core/database.py:1](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/apps/api/app/core/database.py#L1) | async_engine |
| B02 / baseline | [apps/api/alembic/versions/0001_initial_migration.py:19](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/apps/api/alembic/versions/0001_initial_migration.py#L19) | def upgrade |
| B02 / FK sur tables absentes | [apps/api/alembic/versions/05dc81e265f7_add_missing_foreign_keys_to_order_models.py:19](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/apps/api/alembic/versions/05dc81e265f7_add_missing_foreign_keys_to_order_models.py#L19) | def upgrade |
| B03 / réponse reset | [apps/api/app/api/routes/auth.py:91](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/apps/api/app/api/routes/auth.py#L91) | async def request_password_reset |
| B03 / émission token | [apps/api/app/services/auth_service.py:288](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/apps/api/app/services/auth_service.py#L288) | async def request_password_reset |
| B04 / webhook | [apps/api/app/api/routes/payments.py:169](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/apps/api/app/api/routes/payments.py#L169) | def handle_payment_webhook |
| B04 / traitement callback | [apps/api/app/services/payment_service.py:424](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/apps/api/app/services/payment_service.py#L424) | def record_provider_callback |
| B05 / simulation Mobile Money | [apps/api/app/services/payment_service.py:952](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/apps/api/app/services/payment_service.py#L952) | def _simulate_mobile_money_payment |
| B05 / simulation refund | [apps/api/app/services/payment_service.py:635](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/apps/api/app/services/payment_service.py#L635) | def process_refund |
| B06 / initiate sans acteur métier | [apps/api/app/api/routes/payments.py:49](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/apps/api/app/api/routes/payments.py#L49) | def initiate_payment |
| B06 / cash rôle seul | [apps/api/app/api/routes/payments.py:67](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/apps/api/app/api/routes/payments.py#L67) | def confirm_cash_payment |
| B07 / liste tâches | [apps/api/app/api/routes/logistics.py:508](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/apps/api/app/api/routes/logistics.py#L508) | def list_tasks |
| B07 / détail tâches | [apps/api/app/api/routes/logistics.py:561](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/apps/api/app/api/routes/logistics.py#L561) | def get_task |
| B07 / délégation sans acteur | [apps/api/app/services/dispatch_service.py:589](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/apps/api/app/services/dispatch_service.py#L589) | def list_tasks |
| B08 / auth WS | [apps/api/app/api/routes/logistics.py:71](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/apps/api/app/api/routes/logistics.py#L71) | def _authenticate_logistics_ws |
| B08 / broadcast | [apps/api/app/services/logistics_live_hub.py:50](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/apps/api/app/services/logistics_live_hub.py#L50) | async def broadcast_logistics_event |
| B09 / intent prix et devise | [apps/api/app/services/payment_service.py:286](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/apps/api/app/services/payment_service.py#L286) | def create_payment_intent |
| B09 / commission | [apps/api/app/models/commission.py:21](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/apps/api/app/models/commission.py#L21) | class CommissionRecord |
| B10 / runtime | [docker-compose.yml:1](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/docker-compose.yml#L1) | services: |
| B10 / web obsolète | [web.Dockerfile:17](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/web.Dockerfile#L17) | COPY --from=builder /app/.next |
| B11 / workflow | [.github/workflows/production-readiness.yml:41](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/.github/workflows/production-readiness.yml#L41) | truth-e2e: |
| B11 / static gate | [scripts/check_production_readiness_static.py:1](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/scripts/check_production_readiness_static.py#L1) | fichier complet |
| B12 / attentes dispatch | [apps/api/tests/unit/test_hybrid_dispatch_service.py:113](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/apps/api/tests/unit/test_hybrid_dispatch_service.py#L113) | internal_first |
| B13 / partenaires locaux | [context/DataContext.tsx:268](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/context/DataContext.tsx#L268) | const localPartnersFromStorage |
| B13 / onboarding local | [constants.tsx:700](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/constants.tsx#L700) | export const apiSubmitPartnerApplication |
| B13 / token mock | [services/real-api.ts:2044](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/services/real-api.ts#L2044) | private isMockToken |
| B14 / seed dashboard | [apps/api/app/services/payment_gateways_dashboard_service.py:21](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/apps/api/app/services/payment_gateways_dashboard_service.py#L21) | def __init__ |
| B14 / succès factice | [apps/api/app/api/routes/admin_payment_gateways.py:66](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/apps/api/app/api/routes/admin_payment_gateways.py#L66) | def test_webhook |
| B15 / staging prereqs | [scripts/check_staging_prereqs.py:12](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/scripts/check_staging_prereqs.py#L12) | REQUIRED = |
| B16 / migrations destructrices | [apps/api/alembic/versions/d8c7c8e810cf_create_orders_module_tables.py:19](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/apps/api/alembic/versions/d8c7c8e810cf_create_orders_module_tables.py#L19) | def upgrade |
| B18 / corridor à exécuter | [scripts/verify_driver_operational_corridor.py:1](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/scripts/verify_driver_operational_corridor.py#L1) | fichier complet |
| B19 / faux logout global | [apps/api/app/services/auth_service.py:282](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/apps/api/app/services/auth_service.py#L282) | async def logout_all |
| B19 / 2FA | [apps/api/app/api/routes/auth.py:222](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/apps/api/app/api/routes/auth.py#L222) | @router.post("/me/2fa/enable" |
| B20 / secret log | [apps/api/app/main.py:73](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/apps/api/app/main.py#L73) | Database URL: |
| B20 / clé injectée | [vite.config.ts:38](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/vite.config.ts#L38) | 'process.env.API_KEY' |
| B20 / clé consommée | [constants.tsx:273](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/constants.tsx#L273) | const apiKey = process.env.API_KEY |
| B21 / health | [apps/api/app/main.py:46](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/apps/api/app/main.py#L46) | async def health_check |
| B21 / worker stubs | [apps/api/app/workers/tasks.py:9](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/apps/api/app/workers/tasks.py#L9) | def send_email |
| B22 / cache API | [service-worker.js:61](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/service-worker.js#L61) | url.pathname.startsWith('/api/') |
| B22 / enregistrement SW | [index.tsx:28](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/index.tsx#L28) | navigator.serviceWorker.register |
| B24 / README | [README.md:5](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/README.md#L5) | Run and deploy |
| Protection positive order | [apps/api/app/services/order_service.py:504](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/apps/api/app/services/order_service.py#L504) | .with_for_update |
| Protection positive signup | [apps/api/app/schemas/user.py:37](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/apps/api/app/schemas/user.py#L37) | def validate_role |
| Protection positive fleet | [apps/api/app/services/logistics_fleet_service.py:1](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/apps/api/app/services/logistics_fleet_service.py#L1) | fichier complet |
| Seeds credentials | [apps/api/scripts/seed_default_credentials.py:466](https://github.com/KOMFAHQ/Laundry-Express-RDC-2/blob/f55e775831e812e77892072c9fcfed16e4ee26fe/apps/api/scripts/seed_default_credentials.py#L466) | SEED_DRIVER_1_PASSWORD |
