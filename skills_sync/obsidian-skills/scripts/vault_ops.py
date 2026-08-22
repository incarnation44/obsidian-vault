import os
import sys
import subprocess

SCRIPT = r"C:\Users\ildoc\.gemini\antigravity\scratch\my_ai_workspace\core\obsidian_skills.py"

if __name__ == "__main__":
    cmd = [sys.executable, SCRIPT] + sys.argv[1:]
    res = subprocess.run(cmd)
    sys.exit(res.returncode)
