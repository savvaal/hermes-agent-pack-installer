# Dein Premium KI-Agenten-System

Willkommen. Dieses Paket richtet dir dein eigenes deutschsprachiges KI-Agenten-System auf Basis von Hermes ein.

## Was du bekommst

### 1. Orchestrator

Der Orchestrator ist dein Haupt-Agent. Er versteht dein Ziel, verteilt Aufgaben an Spezial-Agenten und hält den Überblick.

Beispiel:

> „Ich brauche für mein Coaching-Angebot 10 Reels, eine Story-Sequenz und einen Telegram-Funnel.“

Der Orchestrator entscheidet dann:

- Hook GPT / Viral Reel Generator → Reels und Hooks
- Storytime Agent → persönliche Storys und Story-Selling
- Community Funnel Builder → Telegram-/WhatsApp-Funnel

### 2. Hook GPT / Viral Reel Generator

Bot für Hooks, Reels, Kurzvideo-Skripte und Captions.

Er hilft bei:

- viralen Hook-Ideen
- 20-45 Sekunden Reel-Skripten
- Captions
- B-Roll-Ideen
- Content-Serien

### 3. Storytime Agent

Bot für Storytelling und persönliche Inhalte.

Er hilft bei:

- persönlichen Storys
- Story-Selling
- Newsletter-Storys
- „Aus meinem Leben gelernt“-Posts
- Vertrauen und Persönlichkeit im Content

### 4. Community Funnel Builder

Bot für Telegram- und WhatsApp-Funnels.

Er hilft bei:

- Community-Struktur
- Onboarding-Nachrichten
- DM-Flows
- 7-Tage Funnel-Sequenzen
- Call-to-Action und Conversion

## Installation

Du bekommst von uns einen VIP-Token.

Dann kopierst du nur diese Zeile in dein Terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/savvaal/hermes-agent-pack-installer/main/install.sh | bash -s -- --token DEIN_VIP_TOKEN
```

Der Installer erledigt automatisch:

1. prüft deinen VIP-Zugang,
2. installiert Hermes, falls nötig,
3. installiert die Agenten,
4. richtet dein Premium-DE Profil ein.

## Telegram Bot verbinden

Wenn dein Agent auch in Telegram laufen soll:

1. Öffne Telegram.
2. Suche `@BotFather`.
3. Schreibe `/newbot`.
4. Vergib einen Namen, z. B. `Mein KI Team`.
5. Vergib einen Username, z. B. `mein_ki_team_bot`.
6. BotFather gibt dir einen Token.
7. Kopiere diesen Token und füge ihn in den Installer/Setup ein, wenn du danach gefragt wirst.

Wichtig: Teile diesen Token nicht öffentlich. Er ist wie ein Passwort für deinen Bot.

## Nach der Installation

Starte Hermes:

```bash
hermes -p premium-de
```

Dann beginne mit dem Orchestrator:

```text
Ich möchte mein KI-Agenten-System einrichten. Stelle mir die wichtigsten Fragen und richte die Agenten auf mein Business aus.
```

## Placeholder-Hinweis

Diese Version enthält Platzhalter-Agenten. Die finalen Knowledge-Dateien und Spezial-Instruktionen werden durch uns ergänzt.
