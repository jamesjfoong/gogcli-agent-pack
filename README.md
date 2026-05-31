# gogcli-agent-pack

**Google Drive CLI (gogcli) skill + agent instructions** — reusable across Pi, Claude Desktop, Cursor, GitHub Copilot, OpenCode, Windsurf, Cline, and any agent that reads markdown instruction files.

## What's Inside

```
gogcli-agent-pack/
├── package.json          ← Pi package format (pi install compatible)
├── install.sh            ← One-command installer for all agents
├── AGENTS-GUIDE.md       ← Universal reference (symlinked to all agent configs)
└── skills/
    └── gogcli/
        └── SKILL.md      ← Pi skill (auto-triggered on Drive/Docs/Sheets requests)
```

## Installation

### Via Pi (recommended)

```bash
pi install git:github.com/jamesjfoong/gogcli-agent-pack
```

### Via any agent (one-liner)

```bash
curl -fsSL https://raw.githubusercontent.com/jamesjfoong/gogcli-agent-pack/main/install.sh | bash
```

Or clone and run manually:

```bash
git clone https://github.com/jamesjfoong/gogcli-agent-pack.git ~/gogcli-agent-pack
cd ~/gogcli-agent-pack
bash install.sh
```

## What Gets Wired Up

| Agent | File | How |
|---|---|---|
| **Pi** | `~/.pi/agent/skills/gogcli/SKILL.md` | Copied skill — auto-triggered |
| **Claude Desktop** | `~/.claude/instructions.md` | Symlink to AGENTS-GUIDE.md |
| **Cursor** | `~/.cursorrules` | Symlink to AGENTS-GUIDE.md |
| **GitHub Copilot** | `~/.github/copilot-instructions.md` | Symlink to AGENTS-GUIDE.md |
| **OpenCode** | `~/.opencode.md` | Symlink to AGENTS-GUIDE.md |
| **Windsurf** | `~/.windsurfrules` | Symlink to AGENTS-GUIDE.md |
| **Cline** | `~/.clinerules` | Symlink to AGENTS-GUIDE.md |

All agents read from the same `AGENTS-GUIDE.md` file (via symlinks), so updating one file updates all agents.

## Prerequisites

- [gogcli](https://github.com/steipete/gogcli) — `brew install gogcli`
- Google Cloud OAuth Desktop credentials
- Authorized Google account(s)

## Author

**jamesjfoong** — [GitHub](https://github.com/jamesjfoong)

## License

MIT
