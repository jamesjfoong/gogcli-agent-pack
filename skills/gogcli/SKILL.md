---
name: gogcli
description: Access Google Drive, Docs, and Sheets from the terminal using gogcli. Multi-account support (personal + work). List, search, download files, read Docs as markdown, read Sheets.
---

# gogcli — Google Drive CLI

## Prerequisites

Before using this skill, the user must have:
1. `gogcli` installed (`brew install gogcli`)
2. A GCP OAuth Desktop client stored via `gog auth credentials`
3. Account(s) authorized via `gog auth add <email>`

Always export `GOG_KEYRING_PASSWORD` before running any `gog` command (this system uses file keyring backend).

## Multi-Account Setup

The same OAuth client can authorize multiple Google accounts. Each account gets its own refresh token.

### Add an account

```bash
export GOG_KEYRING_PASSWORD='<password>'
gog auth add <email> --services drive,sheets,docs
```

For headless/server environments, use `--manual` or `--remote --step 1` / `--remote --step 2` split flow.

### Keyring

This system uses **file** keyring backend (D-Bus SecretService is unavailable). The password is stored in `~/.zshrc` as `GOG_KEYRING_PASSWORD`.

## Common Commands

### List files

```bash
gog drive ls --account <email> --max 20
gog drive ls --account <email> --parent <folderId>
gog drive ls --all --account <email>
```

### Search files

```bash
gog drive search "<query>" --account <email>
gog drive search "mimeType = 'application/pdf'" --raw-query --account <email>
```

### Download files

```bash
gog drive download <fileId> --account <email> --out ./file.pdf
```

### Read Google Doc as Markdown

```bash
gog docs export <docId> --format md --out ./doc.md
```

### Read Google Sheet

```bash
gog sheets get <spreadsheetId> 'Sheet1!A1:D20'
```

### Set default account

```bash
export GOG_ACCOUNT=<email>
# Now omit --account flag
gog drive ls
```

## Account Switching

Switch between accounts with `--account`:

```bash
gog drive ls --account personal@gmail.com
gog drive ls --account work@company.com
gog docs export <docId> --format md --account personal@gmail.com
```

## Reference

Full documentation: `{baseDir}/../AGENTS-GUIDE.md`
