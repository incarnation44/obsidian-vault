import os
import sys
import ast
import json
import argparse
from pathlib import Path

sys.stdout.reconfigure(encoding='utf-8')

class CodeDependencyGraph:
    def __init__(self, root_dir):
        self.root_dir = Path(root_dir).resolve()
        self.graph = {} # file -> {'imports': [], 'functions': [], 'classes': [], 'calls': []}
        self.reverse_graph = {} # file -> list of files that import it

    def parse_python_file(self, file_path):
        rel_path = str(file_path.relative_to(self.root_dir)).replace("\\", "/")
        data = {
            "imports": [],
            "functions": [],
            "classes": [],
            "calls": []
        }
        try:
            with open(file_path, "r", encoding="utf-8", errors="ignore") as f:
                content = f.read()
            tree = ast.parse(content, filename=str(file_path))
            
            for node in ast.walk(tree):
                if isinstance(node, ast.Import):
                    for alias in node.names:
                        data["imports"].append(alias.name)
                elif isinstance(node, ast.ImportFrom):
                    if node.module:
                        data["imports"].append(node.module)
                elif isinstance(node, ast.FunctionDef) or isinstance(node, ast.AsyncFunctionDef):
                    data["functions"].append(node.name)
                elif isinstance(node, ast.ClassDef):
                    data["classes"].append(node.name)
                elif isinstance(node, ast.Call):
                    if isinstance(node.func, ast.Name):
                        data["calls"].append(node.func.id)
                    elif isinstance(node.func, ast.Attribute):
                        data["calls"].append(node.func.attr)
        except Exception as e:
            pass
            
        data["calls"] = list(set(data["calls"]))
        data["imports"] = list(set(data["imports"]))
        self.graph[rel_path] = data

    def build(self):
        for ext in ["*.py", "*.js", "*.ts", "*.jsx", "*.tsx"]:
            for file_path in self.root_dir.rglob(ext):
                if any(ignored in file_path.parts for ignored in [".git", "node_modules", "venv", "__pycache__", "dist", "build", ".system_generated", "logs"]):
                    continue
                if file_path.suffix == ".py":
                    self.parse_python_file(file_path)
                else:
                    # Basic JS/TS import matching
                    rel_path = str(file_path.relative_to(self.root_dir)).replace("\\", "/")
                    imports = []
                    try:
                        with open(file_path, "r", encoding="utf-8", errors="ignore") as f:
                            for line in f:
                                if "import " in line or "require(" in line:
                                    imports.append(line.strip())
                    except:
                        pass
                    self.graph[rel_path] = {"imports": imports, "functions": [], "classes": [], "calls": []}

        # Build reverse dependency
        for file, data in self.graph.items():
            self.reverse_graph[file] = []
            
        for file, data in self.graph.items():
            for imp in data["imports"]:
                for other_file in self.graph.keys():
                    stem = Path(other_file).stem
                    if stem == imp or imp.endswith("." + stem) or imp in other_file:
                        if file not in self.reverse_graph[other_file]:
                            self.reverse_graph[other_file].append(file)

    def get_focused_context(self, target_file):
        norm_target = str(Path(target_file)).replace("\\", "/")
        # Match target
        matched = None
        for f in self.graph.keys():
            if norm_target.endswith(f) or f.endswith(norm_target) or f == norm_target:
                matched = f
                break
                
        if not matched:
            return {"target": target_file, "related_files": [], "dependency_tree": {}}
            
        data = self.graph.get(matched, {})
        dependents = self.reverse_graph.get(matched, [])
        dependencies = data.get("imports", [])
        
        # Find files imported by target
        imported_files = []
        for imp in dependencies:
            for other_file in self.graph.keys():
                stem = Path(other_file).stem
                if stem == imp or imp.endswith("." + stem):
                    imported_files.append(other_file)
                    
        return {
            "target": matched,
            "functions": data.get("functions", []),
            "classes": data.get("classes", []),
            "direct_dependencies (imports)": imported_files,
            "direct_dependents (affected_by_changes)": dependents,
            "token_savings_estimate": f"{max(80, 100 - len(dependents + imported_files)*5)}%"
        }

def main():
    parser = argparse.ArgumentParser(description="Code Dependency Graph Context Optimizer")
    parser.add_argument("--root", default=".", help="Root project directory")
    parser.add_argument("--target", default=None, help="Target file to analyze focused context")
    parser.add_argument("--export-json", default=None, help="Export graph to JSON")
    
    args = parser.parse_args()
    
    cdg = CodeDependencyGraph(args.root)
    cdg.build()
    
    if args.target:
        ctx = cdg.get_focused_context(args.target)
        print(json.dumps(ctx, indent=2, ensure_ascii=False))
    else:
        summary = {
            "total_files_analyzed": len(cdg.graph),
            "files": list(cdg.graph.keys())
        }
        print(json.dumps(summary, indent=2, ensure_ascii=False))
        
    if args.export_json:
        with open(args.export_json, "w", encoding="utf-8") as f:
            json.dump({"graph": cdg.graph, "reverse_graph": cdg.reverse_graph}, f, indent=2, ensure_ascii=False)
        print(f"Graph exported to {args.export_json}")

if __name__ == "__main__":
    main()
