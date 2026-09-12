# Wiki Schema

## Domain
Hermes Agent 작업 맥락, 연구 지식, 프로젝트 결정 사항 및 수집 자료 저장소

## Conventions
- 파일명: 소문자, 하이픈 사용 (`hyphen-separated.md`)
- 모든 문서 상단에는 YAML Frontmatter 작성
- 문서 간 연결은 `[[wikilinks]]` 사용 (최소 2개 이상 권장)
- 새로운 지식 추가 시 `updated` 날짜 갱신
- 모든 문서는 `index.md`에 등록
- 작업 내역은 `log.md`에 기록

## Frontmatter Standard
```yaml
---
title: Page Title
created: YYYY-MM-DD
updated: YYYY-MM-DD
type: entity | concept | comparison | summary
tags: [hermes, research, dev, note]
sources: [raw/articles/source-file.md]
confidence: high | medium | low
---
```

## Folder Structure
- `raw/`: 수정 불가 원본 수집 자료 (스크랩, 자막, 문서)
- `entities/`: 주요 도구, 인물, 서비스, 시스템 페이지
- `concepts/`: 개념, 아키텍처, 방법론 페이지
- `comparisons/`: 비교 및 분석 페이지
- `working/`: 임시 작업 문서
