#!/usr/bin/env bash
set -euo pipefail

# gogcli-agent-skillset installer
# Wires gogcli instructions into all supported agents

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
GUIDE="$REPO_DIR/AGENTS-GUIDE.md"

if [ ! -f "$GUIDE" ]; then
  echo "❌ AGENTS-GUIDE.md not found at $GUIDE"
  exit 1
fi

echo "🔌 Installing gogcli agent instructions..."

# --- Pi ---
PI_SKILL_DIR_GOG="$HOME/.pi/agent/skills/gog"
mkdir -p "$PI_SKILL_DIR_GOG"
cp "$REPO_DIR/skills/gog/SKILL.md" "$PI_SKILL_DIR_GOG/SKILL.md"
echo "  ✅ Pi skill → $PI_SKILL_DIR_GOG"

# --- Claude Desktop ---
mkdir -p "$HOME/.claude"
if [ -f "$HOME/.claude/instructions.md" ] && [ ! -L "$HOME/.claude/instructions.md" ]; then
  echo "  ⚠️  ~/.claude/instructions.md exists (not a symlink) — skipping"
else
  ln -sf "$GUIDE" "$HOME/.claude/instructions.md"
  echo "  ✅ Claude Desktop → ~/.claude/instructions.md"
fi

# --- Cursor ---
if [ -f "$HOME/.cursorrules" ] && [ ! -L "$HOME/.cursorrules" ]; then
  echo "  ⚠️  ~/.cursorrules exists (not a symlink) — skipping"
else
  ln -sf "$GUIDE" "$HOME/.cursorrules"
  echo "  ✅ Cursor → ~/.cursorrules"
fi

# --- GitHub Copilot ---
mkdir -p "$HOME/.github"
if [ -f "$HOME/.github/copilot-instructions.md" ] && [ ! -L "$HOME/.github/copilot-instructions.md" ]; then
  echo "  ⚠️  ~/.github/copilot-instructions.md exists (not a symlink) — skipping"
else
  ln -sf "$GUIDE" "$HOME/.github/copilot-instructions.md"
  echo "  ✅ GitHub Copilot → ~/.github/copilot-instructions.md"
fi

# --- OpenCode ---
if [ -f "$HOME/.opencode.md" ] && [ ! -L "$HOME/.opencode.md" ]; then
  echo "  ⚠️  ~/.opencode.md exists (not a symlink) — skipping"
else
  ln -sf "$GUIDE" "$HOME/.opencode.md"
  echo "  ✅ OpenCode → ~/.opencode.md"
fi

# --- Windsurf ---
if [ -f "$HOME/.windsurfrules" ] && [ ! -L "$HOME/.windsurfrules" ]; then
  echo "  ⚠️  ~/.windsurfrules exists (not a symlink) — skipping"
else
  ln -sf "$GUIDE" "$HOME/.windsurfrules"
  echo "  ✅ Windsurf → ~/.windsurfrules"
fi

# --- Cline ---
if [ -f "$HOME/.clinerules" ] && [ ! -L "$HOME/.clinerules" ]; then
  echo "  ⚠️  ~/.clinerules exists (not a symlink) — skipping"
else
  ln -sf "$GUIDE" "$HOME/.clinerules"
  echo "  ✅ Cline → ~/.clinerules"
fi

echo ""
echo "🎉 Done! All agents can now access gogcli instructions."
echo "   Run this installer again on any new machine to set things up."
