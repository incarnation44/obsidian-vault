"""
Chunkless Tree RAG & Document Structure Navigator
--------------------------------------------------
Parses PDFs, DOCX, Markdown, HTML using Docling / Hierarchical AST
and provides an outline-based Tree Navigation API for AI Agents.
"""

import sys
import os
import json
import re
from pathlib import Path

# Force UTF-8 on Windows
if sys.platform == 'win32':
    try:
        sys.stdout.reconfigure(encoding='utf-8')
        sys.stderr.reconfigure(encoding='utf-8')
    except Exception:
        pass

def parse_markdown_tree(content: str) -> dict:
    """Parses markdown text into a hierarchical heading tree."""
    lines = content.splitlines()
    root = {"title": "Root", "level": 0, "summary": "", "content": "", "children": []}
    stack = [root]
    
    current_content = []
    
    for line in lines:
        match = re.match(r'^(#{1,6})\s+(.*)$', line)
        if match:
            if current_content and stack:
                stack[-1]["content"] += "\n".join(current_content) + "\n"
                if not stack[-1]["summary"]:
                    stack[-1]["summary"] = " ".join(current_content)[:150].strip()
                current_content = []
                
            level = len(match.group(1))
            title = match.group(2).strip()
            node = {"title": title, "level": level, "summary": "", "content": "", "children": []}
            
            while stack and stack[-1]["level"] >= level:
                stack.pop()
                
            if stack:
                stack[-1]["children"].append(node)
                stack.append(node)
        else:
            current_content.append(line)
            
    if current_content and stack:
        stack[-1]["content"] += "\n".join(current_content) + "\n"
        if not stack[-1]["summary"]:
            stack[-1]["summary"] = " ".join(current_content)[:150].strip()
            
    return root

def parse_document(file_path: str) -> dict:
    """Parses a document (PDF, DOCX, MD) into a structured tree."""
    path = Path(file_path)
    if not path.exists():
        return {"error": f"File not found: {file_path}"}
        
    ext = path.suffix.lower()
    
    if ext in ['.md', '.markdown', '.txt']:
        with open(path, 'r', encoding='utf-8', errors='ignore') as f:
            content = f.read()
        tree = parse_markdown_tree(content)
        return {"file": str(path), "type": "markdown", "tree": tree}
        
    elif ext in ['.pdf', '.docx', '.pptx', '.html']:
        try:
            from docling.document_converter import DocumentConverter
            converter = DocumentConverter()
            result = converter.convert(str(path))
            md_content = result.document.export_to_markdown()
            tree = parse_markdown_tree(md_content)
            return {"file": str(path), "type": ext, "tree": tree}
        except Exception as e:
            # Fallback simple reader if docling is not fully loaded
            return {"file": str(path), "type": ext, "error": str(e)}
            
    return {"error": f"Unsupported extension: {ext}"}

def get_outline(tree_node: dict, depth: int = 0) -> list:
    """Extracts a clean outline list with path indicators."""
    outline = []
    prefix = "  " * depth
    if tree_node["level"] > 0:
        summary_snip = f" - {tree_node['summary'][:60]}..." if tree_node.get('summary') else ""
        outline.append(f"{prefix}[L{tree_node['level']}] {tree_node['title']}{summary_snip}")
    for child in tree_node.get("children", []):
        outline.extend(get_outline(child, depth + 1))
    return outline

def find_section(tree_node: dict, query_title: str) -> dict:
    """Finds a specific section by title keyword."""
    if query_title.lower() in tree_node.get("title", "").lower() and tree_node["level"] > 0:
        return tree_node
    for child in tree_node.get("children", []):
        res = find_section(child, query_title)
        if res:
            return res
    return None

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python chunkless_tree_rag.py <file_path> [--outline | --get <section_title>]")
        sys.exit(1)
        
    doc_path = sys.argv[1]
    parsed = parse_document(doc_path)
    
    if "error" in parsed and not parsed.get("tree"):
        print(json.dumps(parsed, ensure_ascii=False, indent=2))
        sys.exit(1)
        
    tree = parsed.get("tree", {})
    
    if len(sys.argv) >= 3:
        mode = sys.argv[2]
        if mode == "--outline":
            print("\n=== DOCUMENT OUTLINE (TREE) ===")
            for item in get_outline(tree):
                print(item)
        elif mode == "--get" and len(sys.argv) >= 4:
            query = sys.argv[3]
            sec = find_section(tree, query)
            if sec:
                print(f"\n=== SECTION: {sec['title']} ===")
                print(sec.get("content", "").strip())
            else:
                print(f"Section '{query}' not found in document tree.")
        else:
            print(json.dumps(tree, ensure_ascii=False, indent=2))
    else:
        print("\n=== DOCUMENT OUTLINE (TREE) ===")
        for item in get_outline(tree):
            print(item)
