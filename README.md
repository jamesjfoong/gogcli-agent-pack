# gogcli-agent-pack

**Pi skill + universal agent guide** for [gogcli](https://github.com/steipete/gogcli) — Google Drive/Docs/Sheets CLI with multi-account support. Works with Pi, Claude Code, Codex, Cursor, and 50+ agents via [skills.sh](https://skills.sh).

## Install

### With `npx skills` (easiest — works for 50+ agents)

```bash
npx skills add jamesjfoong/gogcli-agent-pack
```

Installs to all detected agents. Use `-g` for global, `-a pi` for a specific agent.

### Via Pi

```bash
pi install git:github.com/jamesjfoong/gogcli-agent-pack
```

### Via any agent (one-liner)

```bash
curl -fsSL https://raw.githubusercontent.com/jamesjfoong/gogcli-agent-pack/main/install.sh | bash
```

### Manual

```bash
git clone https://github.com/jamesjfoong/gogcli-agent-pack.git
cd gogcli-agent-pack && bash install.sh
```

## What You Get

| Agent | Mechanism | How |
|---|---|---|
| **Pi** | Skill | Copied to `~/.pi/agent/skills/gogcli/` — auto-triggered |
| **Claude Desktop** | Global instructions | Symlink → `~/.claude/instructions.md` |
| **Cursor** | Global rules | Symlink → `~/.cursorrules` |
| **GitHub Copilot** | Global instructions | Symlink → `~/.github/copilot-instructions.md` |
| **OpenCode** | Global rules | Symlink → `~/.opencode.md` |
| **Windsurf** | Global rules | Symlink → `~/.windsurfrules` |
| **Cline** | Global rules | Symlink → `~/.clinerules` |

## What the Skill Covers

- Installing gogcli (`brew install gogcli`)
- Setting up Google Cloud OAuth (one-time)
- Adding multiple Google accounts (personal + work)
- Listing, searching, and downloading Drive files
- Exporting Google Docs as Markdown
- Reading Google Sheets
- Troubleshooting (keyring issues, test users, token expiry)

## Multi-Account Support

The same OAuth client works for ANY Google account. Authorize multiple accounts:

```bash
gog auth add personal@gmail.com --services drive,sheets,docs
gog auth add work@company.com --services drive,sheets,docs
```

Switch with `--account`:

```bash
gog drive ls --account personal@gmail.com
gog drive ls --account work@company.com
```

## Prerequisites

- [gogcli](https://github.com/steipete/gogcli) (`brew install gogcli`)
- Google Cloud OAuth Desktop credentials
- At least one authorized Google account

## Author

[jamesjfoong](https://github.com/jamesjfoong)

## License

MIT
