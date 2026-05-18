# Hermes Premium Agent Pack Installer — Prototype

Dies ist der Prototyp für eine Eine-Kommando-Installation von deutschsprachigen Premium-Agenten auf Basis von Hermes.

## Lokaler Test

```bash
cd /Users/openclawd/Downloads/hermes-agent-pack-installer-prototype
VIP_TOKEN=demo ./bootstrap-de.sh
```

## Ziel später

```bash
curl -fsSL https://raw.githubusercontent.com/savvaal/hermes-agent-pack-installer/main/install.sh | bash -s -- --token VIP_TOKEN
```

## Enthalten

- bootstrap-de.sh — installiert Hermes und Agent-Pack
- install-de.sh — installiert Agent-Dateien in `~/.hermes/profiles/premium-de/`
- de/agents — drei deutsche Agenten
- OPERATOR.md — Token-/Hosting-Konzept
- GPT-EXPORT-TODO.md — Liste der aus Custom GPTs zu ziehenden Daten
