#!/usr/bin/env bash
set -euo pipefail

OVERWRITE=0
if [[ "${1:-}" == "--overwrite" ]]; then
  OVERWRITE=1
elif [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  cat <<'HELP'
Premium Agenten-Pack Bootstrap für Hermes (Deutsch)

Eine-Kommando-Installation:
  1) prüft/installiert Hermes Agent
  2) prüft VIP-Zugangstoken
  3) installiert das deutsche Agenten-Pack

Usage:
  VIP_TOKEN=dein_token ./bootstrap-de.sh
  ./bootstrap-de.sh --overwrite

Empfohlene Kunden-Command später:
  curl -fsSL https://DEINE-DOMAIN.de/install.sh | bash -s -- --token VIP_TOKEN
HELP
  exit 0
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT_DIR"

TOKEN=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --token)
      TOKEN="${2:-}"
      shift 2
      ;;
    --overwrite)
      OVERWRITE=1
      shift
      ;;
    *)
      echo "Unbekannte Option: $1" >&2
      exit 1
      ;;
  esac
done
TOKEN="${TOKEN:-${VIP_TOKEN:-}}"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo " Premium Hermes Agenten-Pack — Deutsch"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if [[ -z "$TOKEN" ]]; then
  echo "Fehler: VIP_TOKEN fehlt."
  echo "Nutze: VIP_TOKEN=dein_token ./bootstrap-de.sh"
  echo "oder: ./bootstrap-de.sh --token dein_token"
  exit 1
fi

VERIFY_URL="${VERIFY_URL:-}"
if [[ -n "$VERIFY_URL" ]]; then
  if ! command -v curl >/dev/null 2>&1; then
    echo "Fehler: curl ist nicht installiert." >&2
    exit 1
  fi
  echo "Prüfe VIP-Zugang ..."
  HTTP_CODE="$(curl -sS -o /tmp/hermes_vip_verify.json -w '%{http_code}' -H "Authorization: Bearer $TOKEN" "$VERIFY_URL")"
  if [[ "$HTTP_CODE" != "200" ]]; then
    echo "Fehler: VIP-Zugang abgelehnt oder abgelaufen. Code: $HTTP_CODE" >&2
    exit 1
  fi
  echo "✓ VIP-Zugang bestätigt"
else
  echo "Hinweis: VERIFY_URL ist nicht gesetzt — lokale Demo ohne Serverprüfung."
fi

if ! command -v hermes >/dev/null 2>&1; then
  echo "Hermes wurde nicht gefunden. Installiere Hermes über den offiziellen Installer."
  curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash
else
  echo "✓ Hermes ist bereits installiert: $(command -v hermes)"
fi

echo ""
echo "Installiere deutsches Agenten-Pack ..."
if [[ "$OVERWRITE" -eq 1 ]]; then
  ./install-de.sh --overwrite
else
  ./install-de.sh
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo " Installation abgeschlossen"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Nächste Schritte:"
echo "1) Starte Hermes: hermes"
echo "2) Prüfe Skills/Profile unter ~/.hermes/profiles/premium-de/"
echo "3) Fülle Kundendaten in USER.md aus."
echo "4) Lade Agenten/Skills in Hermes je nach Setup."
