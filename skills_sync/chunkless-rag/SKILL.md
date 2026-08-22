---
name: chunkless-rag
description: "Hierarchical Chunkless Tree RAG & Docling Document Navigation. Use this skill when analyzing long PDFs, technical manuals, contracts, books, or complex structured markdown notes to preserve headings, tables, and context without blind chunking."
---

# 🌲 Chunkless Tree RAG & Structure-Based Navigation

기존의 무차별 500자 텍스트 분할(Flat Chunking)을 배제하고, 문서의 목차(H1~H3)와 표(Table), 읽기 순서 계층 트리를 보존하여 사람처럼 탐색하는 에이전트 전용 RAG 스킬입니다.

Grok Bot 없이 Antigravity가 직접 실행한다. 경로를 추측하지 마라.

---

## 🎯 핵심 원칙 (Core Principles)
1. **문서 훼손 금지 (No Blind Chunking)**: 긴 문서를 임의의 글자 수로 잘라 헤딩과 표를 분리하지 않는다.
2. **목차 우선 탐색 (Outline First)**: 전체 본문을 다 읽지 않고, 계층 트리 아웃라인(목차 요약)을 먼저 스캔하여 대상 챕터를 특정한다.
3. **상위 맥락 유지 (Context Path Preservation)**: 본문 단락을 읽을 때 어느 대단원과 소단원에 속해 있는지 경로 정보를 항상 유지한다.

---

## 🛠️ 실전 CLI 실행 가이드

실존 스크립트 (이 PC에서 확인됨):

- **1순위 (볼트 원본)**: `C:\전일도\scripts\chunkless_tree_rag.py`
- **폴백 (워크스페이스 복사본)**: `C:\Users\ildoc\.gemini\antigravity\scratch\my_ai_workspace\core\chunkless_tree_rag.py`

스킬 폴더 `config\skills\chunkless-rag\` 안에는 SKILL.md만 있다. 파이썬 파일은 위 두 곳이다.

```powershell
# 1. 문서의 계층 트리 목차(Outline) 요약 조회
python "C:\전일도\scripts\chunkless_tree_rag.py" "<문서경로.pdf/md/docx>" --outline

# 볼트 경로가 막히면 폴백
python "C:\Users\ildoc\.gemini\antigravity\scratch\my_ai_workspace\core\chunkless_tree_rag.py" "<문서경로.pdf/md/docx>" --outline

# 2. 특정 섹션만 핀포인트로 본문 정독
python "C:\전일도\scripts\chunkless_tree_rag.py" "<문서경로.pdf/md/docx>" --get "<섹션키워드>"
```

PDF/DOCX/PPTX/HTML 은 Docling이 설치되어 있을 때 변환된다. 없으면 마크다운/텍스트는 그대로 파싱하고, 그 외는 에러를 보고한 뒤 md로 변환을 시도하라. 패키지를 임의 npm 설치하지 마라.

---

## ⚖️ 작업 흐름 (Workflow)
1. **입력 문서 접수**: 사용자가 PDF, 대형 마크다운, 매뉴얼 전달 시
2. **트리 파싱**: `Docling` 또는 AST 파서를 통해 `Document Tree` 객체 생성
3. **아웃라인 스캔**: 에이전트가 질문과 관련된 챕터(Node)를 목차에서 식별
4. **핀포인트 로딩**: 해당 챕터의 본문과 표를 통째로 읽어 상하위 인과관계를 파악하고 정확한 답변 도출
