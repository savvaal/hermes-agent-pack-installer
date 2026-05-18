#!/usr/bin/env bash
set -euo pipefail

REPO_OWNER="${REPO_OWNER:-savvaal}"
REPO_NAME="${REPO_NAME:-hermes-agent-pack-installer}"
REPO_BRANCH="${REPO_BRANCH:-main}"
ARCHIVE_URL="${ARCHIVE_URL:-https://github.com/${REPO_OWNER}/${REPO_NAME}/archive/refs/heads/${REPO_BRANCH}.tar.gz}"

usage() {
  cat <<'HELP'
Premium Hermes Agenten-Pack Installer (Deutsch)

Kunden-Command:
  curl -fsSL https://raw.githubusercontent.com/savvaal/hermes-agent-pack-installer/main/install.sh | bash -s -- --token DEIN_VIP_TOKEN

Optionen:
  --token TOKEN       VIP-Zugangstoken
  --overwrite         vorhandene Agenten-Dateien mit Backup ersetzen
  -h, --help          Hilfe anzeigen

Optional für Betreiber:
  VERIFY_URL=https://deine-domain.de/api/verify curl ... | bash -s -- --token TOKEN
HELP
}

TOKEN=""
OVERWRITE=0
PASSTHRU=()
while [[ $# -gt 0 ]]; do
  case "$1" in
    --token)
      TOKEN="${2:-}"
      shift 2
      ;;
    --overwrite)
      OVERWRITE=1
      PASSTHRU+=("--overwrite")
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unbekannte Option: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

TOKEN="${TOKEN:-${VIP_TOKEN:-}}"
if [[ -z "$TOKEN" ]]; then
  echo "Fehler: VIP-Token fehlt."
  echo "Beispiel: curl -fsSL https://raw.githubusercontent.com/savvaal/hermes-agent-pack-installer/main/install.sh | bash -s -- --token DEIN_VIP_TOKEN"
  exit 1
fi

for cmd in curl tar mktemp; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "Fehler: '$cmd' ist erforderlich, wurde aber nicht gefunden." >&2
    exit 1
  fi
done

TMP_DIR="$(mktemp -d "${TMPDIR:-/tmp}/hermes-agent-pack.XXXXXX")"
cleanup() { rm -rf "$TMP_DIR"; }
trap cleanup EXIT

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo " Premium Hermes Agenten-Pack — Deutsch"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Lade Installationspaket ..."

curl -fsSL "$ARCHIVE_URL" -o "$TMP_DIR/pack.tar.gz"
tar -xzf "$TMP_DIR/pack.tar.gz" -C "$TMP_DIR"
PACK_DIR="$(find "$TMP_DIR" -maxdepth 1 -type d -name "${REPO_NAME}-*" | head -n 1)"
if [[ -z "$PACK_DIR" || ! -f "$PACK_DIR/bootstrap-de.sh" ]]; then
  echo "Fehler: Installationspaket konnte nicht gelesen werden." >&2
  exit 1
fi

chmod +x "$PACK_DIR/bootstrap-de.sh" "$PACK_DIR/install-de.sh"
VIP_TOKEN="$TOKEN" "$PACK_DIR/bootstrap-de.sh" "${PASSTHRU[@]}"
