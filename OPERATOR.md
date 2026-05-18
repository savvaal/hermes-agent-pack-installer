# Betreiber-Notizen: VIP Token System

## Minimaler sicherer Ansatz

Der Installer akzeptiert keinen geheimen Master-Key. Der Kunde bekommt einen einzelnen VIP-Token.

Empfohlener Flow:

```bash
curl -fsSL https://deine-domain.de/install.sh | bash -s -- --token vip_xxx
```

Der Bootstrap ruft dann auf:

```bash
curl -H "Authorization: Bearer vip_xxx" https://deine-domain.de/api/verify
```

Server antwortet:

- `200` = gültig, Installation geht weiter
- `401/403` = ungültig/abgelaufen

## Token-Datenbank

Speichere pro Token:

- token_hash, niemals Klartext
- customer_email
- product_slug: `premium-de-content-agents`
- max_activations
- activation_count
- expires_at
- created_at
- revoked_at

## Wichtig

- Tokens nie in Git committen.
- Installer darf öffentlich sein; Premium-Inhalt sollte erst nach Tokenprüfung geladen werden.
- Für echten Schutz: Agent-Pack nicht komplett in public GitHub legen, sondern als ZIP nach erfolgreicher Prüfung ausliefern.

## Gute Architektur

1. Public bootstrap:
   - klein, lesbar, installiert Hermes, fragt Token ab.
2. Private package endpoint:
   - `/api/download?product=premium-de-content-agents`
   - liefert ZIP nur mit gültigem Token.
3. Token-Backend:
   - Supabase, Cloudflare Worker + KV/D1, Railway/FastAPI oder Vercel.
