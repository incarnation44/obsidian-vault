---
name: pdf-inspector
description: "Ultra-fast (<50ms) PDF triage and inspection preprocessor. Determines whether PDF pages are digital text or scanned images, routing only scanned pages to OCR to slash Vision/LLM token costs by up to 90%."
---

# ⚡ PDF Inspector (초고속 50ms PDF 전처리 & OCR 비용 90% 절감 엔진)

GitHub 트렌딩 Top 10 (10위) 도구로 선정된 초고속 PDF 인스펙터 스킬입니다.

## 🎯 핵심 목적
1. **무차별 유료 OCR 호출 차단**: PDF 전체를 무작정 Vision LLM/OCR API에 보내지 않고, 50ms 만에 스캔본과 디지털 텍스트 본을 분리합니다.
2. **토큰 및 비용 90% 절감**: 텍스트 레이어가 있는 페이지는 0.01초 만에 무료 텍스트 추출(`Direct Extract`), 텍스트가 없는 스캔 이미지만 골라 OCR로 보냅니다.
3. **`chunkless-rag` 파이프라인 연계**: 인출된 텍스트는 즉시 헤딩 트리 기반 RAG로 주입됩니다.

## 🛠️ 실존 스크립트 실행법 (50ms 완결)

```powershell
python "C:\Users\ildoc\.gemini\config\skills\pdf-inspector\scripts\inspect_pdf.py" "C:\경로\문서.pdf"
```

### 반환 JSON 명세
```json
{
  "file": "manual.pdf",
  "total_pages": 50,
  "overall_type": "HYBRID_MIXED",
  "digital_pages": 45,
  "scanned_pages": 5,
  "ocr_cost_saving_pct": "90.0%",
  "elapsed_ms": 38.5,
  "pages": [...]
}
```
