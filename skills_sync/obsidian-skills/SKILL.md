---
name: obsidian-skills
description: Standard Agent Skills interface for Obsidian Vault. Automates note creation, schema/frontmatter validation, bidirectional wiki-linking ([[Note]]), tag indexing, broken link audits, and structured Second Brain navigation.
---

# 📚 Obsidian Skills (Agent-Native Vault Interface)

This skill connects AI agents directly to the user's Obsidian Second Brain vault (`C:\전일도`). It enforces metadata integrity, manages bidirectional wikilinks, audits graph health, and discovers relevant context.

## 🚀 When to Use
- Whenever searching, creating, or auditing notes in the Obsidian Vault (`C:\전일도`).
- To check for broken wikilinks or orphan notes.
- To discover related notes for cross-linking using `--query`.

## 🛠️ Execution Commands

실존 경로:
```powershell
# 1. 볼트 전체 무결성 감사 (링크, 메타데이터, 고립 문서 점검)
python "C:\Users\ildoc\.gemini\config\skills\obsidian-skills\scripts\vault_ops.py" audit

# 2. 특정 키워드/주제 관련 노트 추천 (위키링크 매핑)
python "C:\Users\ildoc\.gemini\config\skills\obsidian-skills\scripts\vault_ops.py" suggest -q "<검색어>"

# 3. 볼트 내 전체 마크다운 문서 목록 출력
python "C:\Users\ildoc\.gemini\config\skills\obsidian-skills\scripts\vault_ops.py" list
```

## 📋 3대 필수 메타데이터 표준
옵시디언 볼트에 노트를 추가할 때는 프론트매터(Frontmatter)에 아래 항목을 반드시 포함해야 합니다:
1. `source`: 원본 정보 출처 (URL, 서적, 강의 등)
2. `published_date`: 원본 정보 발행일자 (YYYY-MM-DD)
3. `created_date`: 내 보관소 등록일자 (YYYY-MM-DD)
