import subprocess
import sys
from pathlib import Path

# =====================================================
# Configuration
# =====================================================
REPO_URL = "https://github.com/dondonedmond82/Foot-Traffic-Mobility-Data-for-Central-African.git"

# Current directory is assumed to be the project folder
PROJECT_DIR = Path(__file__).parent.resolve()

COMMIT_MESSAGE = "Project update"

# =====================================================
# Helper function
# =====================================================
def run(command):
    print(f"\n>>> {command}")
    result = subprocess.run(
        command,
        shell=True,
        cwd=PROJECT_DIR
    )

    if result.returncode != 0:
        print(f"\nCommand failed:\n{command}")
        sys.exit(result.returncode)

# =====================================================
# Verify Git is installed
# =====================================================
try:
    subprocess.run(
        "git --version",
        shell=True,
        check=True,
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )
except Exception:
    print("Git is not installed or is not in your PATH.")
    sys.exit(1)

print("=" * 60)
print("GitHub Push Utility")
print("=" * 60)
print(f"Project : {PROJECT_DIR}")
print(f"Repository : {REPO_URL}")

# =====================================================
# Initialize Git if needed
# =====================================================
if not (PROJECT_DIR / ".git").exists():
    run("git init")

# =====================================================
# Configure remote
# =====================================================
result = subprocess.run(
    "git remote",
    shell=True,
    cwd=PROJECT_DIR,
    capture_output=True,
    text=True,
)

if "origin" not in result.stdout:
    run(f"git remote add origin {REPO_URL}")
else:
    run(f"git remote set-url origin {REPO_URL}")

# =====================================================
# Commit
# =====================================================
run("git add .")

status = subprocess.run(
    "git status --porcelain",
    shell=True,
    cwd=PROJECT_DIR,
    capture_output=True,
    text=True,
)

if status.stdout.strip():
    run(f'git commit -m "{COMMIT_MESSAGE}"')
else:
    print("\nNothing to commit.")

# =====================================================
# Push
# =====================================================
try:
    run("git branch -M main")
    run("git push -u origin main")
except SystemExit:
    print("\nPush failed. Attempting to synchronize with remote...")
    run("git pull origin main --allow-unrelated-histories")
    run("git push origin main")

print("\nProject successfully pushed to GitHub.")