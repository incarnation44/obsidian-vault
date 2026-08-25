---
name: holehe-osint
description: Fast OSINT Email Registration Scanner across 120+ platforms (Twitter, GitHub, Instagram, Adobe, Spotify, etc.) via password-recovery and profile probing.
---

# 🕵️ Holehe: OSINT Email Presence Scanner

This skill runs **Holehe** to check if an email address is registered across **120+ web services, social networks, and SaaS platforms** in seconds without alerting the target.

---

## 🚀 When to Use
- Security & privacy audits: Check where your personal or company emails are registered.
- OSINT target validation: Verify B2B lead presence or account authenticity.
- Fraud and phishing defense: Investigate suspicious sender email addresses.

---

## 🛠️ CLI Execution

```bash
# Scan a single email address
holehe target_email@example.com

# Scan and show only registered (used) services
holehe --only-used target_email@example.com

# Scan without terminal color codes (clean text output)
holehe --only-used --no-color target_email@example.com
```

### Probing Mechanism
- Password reset endpoints (checking "account exists" responses)
- Registration validation APIs
- Profile status probing
