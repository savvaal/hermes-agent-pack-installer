#!/usr/bin/env bash
set -euo pipefail

OVERWRITE=0
if [[ "${1:-}" == "--overwrite" ]]; then
  OVERWRITE=1
elif [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  cat <<'HELP'
Deutscher Agenten-Pack Installer für Hermes

Usage:
  ./install-de.sh              Installiert fehlende Agenten-Dateien
  ./install-de.sh --overwrite  Erstellt Backups und ersetzt bestehende Dateien

Optional:
  HERMES_HOME=/custom/path/.hermes ./install-de.sh
HELP
  exit 0
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$ROOT_DIR/de/agents"
HERMES_HOME="${HERMES_HOME:-$HOME/.hermes}"
PROFILE_DIR="$HERMES_HOME/profiles/premium-de"
AGENT_DIR="$PROFILE_DIR/agents"
SKILLS_DIR="$PROFILE_DIR/skills"
BACKUP_DIR="$PROFILE_DIR/backups/agent-pack-de-$(date +%Y%m%d-%H%M%S)"

if [[ ! -d "$SOURCE_DIR" ]]; then
  echo "Fehler: $SOURCE_DIR nicht gefunden." >&2
  exit 1
fi

mkdir -p "$AGENT_DIR" "$SKILLS_DIR"
echo "Installiere deutsches Hermes Agenten-Pack nach: $PROFILE_DIR"

copy_file() {
  local src="$1"
  local dst="$2"
  if [[ -f "$dst" && "$OVERWRITE" -ne 1 ]]; then
    echo "  behalte vorhandene Datei: $(basename "$dst")"
    return 0
  fi
  if [[ -f "$dst" && "$OVERWRITE" -eq 1 ]]; then
    local rel="${dst#$PROFILE_DIR/}"
    mkdir -p "$BACKUP_DIR/$(dirname "$rel")"
    cp "$dst" "$BACKUP_DIR/$rel"
    echo "  Backup + ersetze: $(basename "$dst")"
  else
    echo "  füge hinzu: $(basename "$dst")"
  fi
  cp "$src" "$dst"
}

install_agent() {
  local agent="$1"
  local src_dir="$SOURCE_DIR/$agent"
  local target="$AGENT_DIR/$agent"
  echo "→ Installiere $agent"
  mkdir -p "$target"
  for src in "$src_dir"/*.md; do
    [[ -f "$src" ]] || continue
    copy_file "$src" "$target/$(basename "$src")"
  done
}

for dir in "$SOURCE_DIR"/*; do
  [[ -d "$dir" ]] || continue
  install_agent "$(basename "$dir")"
done

cat > "$PROFILE_DIR/README.md" <<'MD'
# Premium-DE Hermes Agenten-Pack

Installierte Agenten:

- viral-reel-generator
- storytime-agent
- community-funnel-builder

Dieses Profil ist als erster Prototyp gedacht. Nächster Schritt: Agenten als Hermes Skills/Profile sauber registrieren und optional Gateway-/Telegram-Konfiguration ergänzen.
MD

echo ""
echo "Fertig. Profilordner: $PROFILE_DIR"
if [[ "$OVERWRITE" -eq 1 && -d "$BACKUP_DIR" ]]; then
  echo "Backup gespeichert unter: $BACKUP_DIR"
fi
