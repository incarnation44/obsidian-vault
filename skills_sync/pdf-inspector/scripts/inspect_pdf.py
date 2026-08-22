import sys
import os
import json
import time
from pypdf import PdfReader

def inspect_pdf(pdf_path: str, char_threshold: int = 30) -> dict:
    start_time = time.time()
    
    if not os.path.exists(pdf_path):
        return {"error": f"File not found: {pdf_path}", "elapsed_ms": 0}
    
    try:
        reader = PdfReader(pdf_path)
        total_pages = len(reader.pages)
        
        page_results = []
        scanned_count = 0
        text_count = 0
        
        for idx, page in enumerate(reader.pages):
            text = page.extract_text() or ""
            clean_text = text.strip()
            char_count = len(clean_text)
            
            # Check for images / fonts
            images = list(page.images)
            image_count = len(images)
            
            is_scanned = (char_count < char_threshold and image_count > 0)
            is_pure_text = (char_count >= char_threshold and image_count == 0)
            is_mixed = (char_count >= char_threshold and image_count > 0)
            
            if is_scanned:
                status = "SCANNED_IMAGE"
                rec_action = "OCR_REQUIRED"
                scanned_count += 1
            elif is_pure_text:
                status = "DIGITAL_TEXT"
                rec_action = "DIRECT_EXTRACT"
                text_count += 1
            else:
                status = "MIXED"
                rec_action = "DIRECT_EXTRACT_FIRST"
                text_count += 1
                
            page_results.append({
                "page": idx + 1,
                "status": status,
                "char_count": char_count,
                "image_count": image_count,
                "recommended_action": rec_action,
                "preview_snippet": clean_text[:100] if clean_text else None
            })
            
        elapsed_ms = round((time.time() - start_time) * 1000, 2)
        
        overall_type = "DIGITAL_TEXT"
        if scanned_count == total_pages:
            overall_type = "PURE_SCANNED"
        elif scanned_count > 0:
            overall_type = "HYBRID_MIXED"
            
        cost_saving_pct = round((text_count / max(total_pages, 1)) * 100, 1)
        
        return {
            "file": os.path.basename(pdf_path),
            "total_pages": total_pages,
            "overall_type": overall_type,
            "digital_pages": text_count,
            "scanned_pages": scanned_count,
            "ocr_cost_saving_pct": f"{cost_saving_pct}%",
            "elapsed_ms": elapsed_ms,
            "pages": page_results
        }
    except Exception as e:
        return {
            "file": os.path.basename(pdf_path),
            "error": str(e),
            "elapsed_ms": round((time.time() - start_time) * 1000, 2)
        }

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python inspect_pdf.py <path_to_pdf>")
        sys.exit(1)
        
    pdf_file = sys.argv[1]
    res = inspect_pdf(pdf_file)
    print(json.dumps(res, ensure_ascii=False, indent=2))
