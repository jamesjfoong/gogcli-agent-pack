#!/usr/bin/env bash
set -euo pipefail

# gogcli-agent-pack — Universal installer for all AI agents
# Usage: curl -fsSL https://git.io/gogcli-agent-pack | bash
# Or:    bash <(curl -s https://raw.githubusercontent.com/jamesjfoong/gogcli-agent-pack/main/install.sh)

REPO="https://github.com/jamesjfoong/gogcli-agent-pack"
TMP_DIR=$(mktemp -d)
trap "rm -rf $TMP_DIR" EXIT

echo "🔌 Installing gogcli agent instructions..."

# Clone
if ! git clone --depth 1 "$REPO.git" "$TMP_DIR" 2>/dev/null; then
  echo "❌ Failed to clone repo. Do you have git installed?"
  exit 1
fi

cd "$TMP_DIR"

GUIDE="$TMP_DIR/AGENTS.md"
SKILL_SRC="$TMP_DIR/skills/gogcli/SKILL.md"

if [ ! -f "$GUIDE" ]; then
  echo "❌ AGENTS.md not found. Corrupt clone?"
  exit 1
fi

# --- Pi ---
PI_SKILL_DIR="$HOME/.pi/agent/skills/gogcli"
mkdir -p "$PI_SKILL_DIR"
cp "$SKILL_SRC" "$PI_SKILL_DIR/SKILL.md"
echo "  ✅ Pi → $PI_SKILL_DIR"

# --- Symlink targets ---
symlink_agent() {
  local name="$1"
  local dest="$2"
  local dir
  dir=$(dirname "$dest")

  if [ -f "$dest" ] && [ ! -L "$dest" ]; then
    echo "  ⚠️  $name: $dest exists (not a symlink) — skipping"
    return
  fi

  mkdir -p "$dir"
  ln -sf "$GUIDE" "$dest"
  echo "  ✅ $name → $dest"
}

symlink_agent "Claude Desktop" "$HOME/.claude/instructions.md"
symlink_agent "Cursor" "$HOME/.cursorrules"
symlink_agent "GitHub Copilot" "$HOME/.github/copilot-instructions.md"
symlink_agent "OpenCode" "$HOME/.opencode.md"
symlink_agent "Windsurf" "$HOME/.windsurfrules"
symlink_agent "Cline" "$HOME/.clinerules"

echo ""
echo "🎉 Done! All agents can now access gogcli instructions."
echo "   Run this installer on any new machine."
echo ""
echo "   To also install via Pi:"
echo "     pi install git:$REPO"
echo ""
echo "   Or via npx (if published to npm):"
echo "     npx @jamesjfoong/gogcli-agent-pack"
