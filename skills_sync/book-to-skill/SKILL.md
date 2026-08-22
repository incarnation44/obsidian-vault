---
name: book-to-skill
description: "Convert markdown documents, Obsidian notes, guides, and manuals into executable Antigravity agent skills (SKILL.md). Activates when the user wants to convert a document or book into an agent skill."
---

# Book-to-Skill Conversion Workflow

이 스킬은 옵시디언(`C:\전일도`)의 지식 노트나 기술 문서, 매뉴얼을 Antigravity 표준 `SKILL.md`로 자동 변환하여 에이전트의 온디맨드 실행 지식으로 패키징하는 지침입니다.

Grok Bot 없이 Antigravity가 직접 실행한다. 스킬 폴더에는 SKILL.md만 있고, 실행 스크립트는 워크스페이스 `core\` 에 있다.

## 🎯 변환 원칙
1. **4대 필수 섹션 구조화**:
   - `핵심 원칙 (Core Principles)`
   - `단계별 실행 절차 (Step-by-Step Workflow)`
   - `주의사항 및 안티패턴 (Anti-Patterns)`
   - `완료 검증 체크리스트 (Verification Checklist)`
2. **YAML Frontmatter 필수**: `name`과 1~2줄의 명확한 `description`을 반드시 포함한다.
3. **적절한 저장 경로 배치**:
   - 프로젝트 종속적 스킬 → `<workspace>/.agents/skills/<skill_name>/SKILL.md`
   - 전역 공통 스킬 → `C:\Users\ildoc\.gemini\config\skills/<skill_name>/SKILL.md`

## 🛠️ CLI 실행 명령

실존 경로 (확인됨): `C:\Users\ildoc\.gemini\antigravity\scratch\my_ai_workspace\core\book_to_skill.py`

```powershell
# 워크스페이스 전용 스킬로 변환
python "C:\Users\ildoc\.gemini\antigravity\scratch\my_ai_workspace\core\book_to_skill.py" "<문서경로>" [스킬이름]

# 전역(Global) 스킬로 변환
python "C:\Users\ildoc\.gemini\antigravity\scratch\my_ai_workspace\core\book_to_skill.py" "<문서경로>" [스킬이름] --global
```
