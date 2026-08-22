---
name: blackbird-osint
description: Fast OSINT account and email presence scanner across 600+ platforms. Use when the user wants to check account registrations, scan a username/email for privacy/security audits, or do B2B lead target research.
---

# 🦅 Blackbird OSINT Account Scanner Skill

This skill scans usernames and emails across 600+ social networks and web services.

## 🛠️ Execution Command

실존 경로:

```powershell
& "C:\Users\ildoc\.gemini\antigravity\scratch\my_ai_workspace\tools\blackbird\.venv\Scripts\python.exe" "C:\Users\ildoc\.gemini\antigravity\scratch\my_ai_workspace\tools\blackbird\blackbird.py" -u <USERNAME> --json --no-nsfw
```

이메일 스캔 시:

```powershell
& "C:\Users\ildoc\.gemini\antigravity\scratch\my_ai_workspace\tools\blackbird\.venv\Scripts\python.exe" "C:\Users\ildoc\.gemini\antigravity\scratch\my_ai_workspace\tools\blackbird\blackbird.py" -e <EMAIL> --json --no-nsfw
```

## 📋 Features
- Scans 600+ sites (GitHub, Twitter, Instagram, Adobe, Spotify, PayPal, etc.)
- Saves results to `tools\blackbird\results\` in JSON format
