# gogcli agent skillset

Google Workspace `gog`/`gogcli` skill + agent instructions reusable across Pi, Claude Desktop, Cursor, GitHub Copilot, OpenCode, Windsurf, and Cline.

## What's Inside

```
gogcli-agent-skillset/
├── package.json          ← Pi package format (pi install compatible)
├── install.sh            ← One-command installer for all agents
├── AGENTS-GUIDE.md       ← Universal reference (symlinked to all agent configs)
└── skills/
    └── gog/
        └── SKILL.md      ← single canonical skill
```

## Installation

### Via Pi (recommended)

```bash
pi install git:github.com/jamesjfoong/gogcli-agent-skillset
```

### Via any agent (one-liner)

```bash
curl -fsSL https://raw.githubusercontent.com/jamesjfoong/gogcli-agent-skillset/main/install.sh | bash
```

Or clone and run manually:

```bash
git clone https://github.com/jamesjfoong/gogcli-agent-skillset.git ~/gogcli-agent-skillset
cd ~/gogcli-agent-skillset
bash install.sh
```

## What Gets Wired Up

| Agent | File | How |
|---|---|---|
| **Pi** | `~/.pi/agent/skills/gog/SKILL.md` | Copied skill — auto-triggered |
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

## Smart Chip Links in Sheets

For linked chips in Google Sheets, `gog sheets get` often shows label text only.

Use:

```bash
gog sheets raw <spreadsheetId> --include-grid-data --json --account <email>
```

Extract URL from:

- `chipRuns[].chip.richLinkProperties.uri` (smart chips)
- `hyperlink` (cell-level link)
- `textFormatRuns[].format.link.uri` (rich text link)

## Author

**jamesjfoong** — [GitHub](https://github.com/jamesjfoong)

## License

MIT
