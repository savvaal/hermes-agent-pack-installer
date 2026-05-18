# Produktbild: Premium Content-Agenten für Hermes

## Ziel

Ein Kunde soll nicht technisch denken müssen. Er bekommt eine Command-Zeile, einen VIP-Token und klare Rollen.

## Kundenflow

1. Kunde kauft Produkt.
2. Wir generieren VIP-Token.
3. Kunde bekommt eine kurze Seite:
   - Was ist enthalten?
   - Eine Installationszeile
   - BotFather-Anleitung für Telegram
4. Kunde führt Installer aus.
5. Installer fragt/prüft:
   - VIP-Token
   - optional Telegram Bot Token
   - optional Business-Kontext
6. Hermes + Agenten werden installiert.
7. Kunde startet mit dem Orchestrator.

## Agenten-Rollen

### Orchestrator

Haupt-Agent. Verteilt Aufgaben, fragt den Kunden aus, hält alles zusammen.

### Hook GPT / Viral Reel Generator

Spezial-Agent für Hooks, Reels, Captions, Content-Serien.

### Storytime Agent

Spezial-Agent für Storytelling, persönliche Posts, Story-Selling.

### Community Funnel Builder

Spezial-Agent für Telegram/WhatsApp Community Funnel, Onboarding, DM-Sequenzen.

## BotFather Flow

Im finalen Setup soll der Installer ungefähr so fragen:

```text
Möchtest du Telegram verbinden? [y/N]

1. Öffne Telegram und suche @BotFather
2. Schreibe /newbot
3. Kopiere den Token
4. Füge ihn hier ein:
> 
```

Der Token wird nur lokal in `~/.hermes/profiles/premium-de/.env` gespeichert, niemals im Repo.

## VIP Token Flow

Kurzfristig:

```bash
VIP_TOKEN=demo ./bootstrap-de.sh
```

Final:

```bash
curl -fsSL https://domain.de/install.sh | bash -s -- --token vip_xxx
```

## Offene Platzhalter

- echte Custom-GPT Instructions
- Knowledge/PDF Dateien
- finaler Produktname
- Domain
- Token-Backend
- Telegram Gateway Auto-Setup
