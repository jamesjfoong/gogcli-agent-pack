---
name: gogcli
description: "Use gogcli to read, search, list, and download files from Google Drive; export Google Docs as markdown; and read Google Sheets. Supports multiple Google accounts via OAuth. Trigger when the user mentions Google Drive, Docs, Sheets, or Gmail from the terminal."
---

# gogcli — Google Workspace CLI

Access Google Drive, Docs, and Sheets from the terminal using [gogcli](https://github.com/steipete/gogcli).

## Install gogcli

```bash
brew install gogcli
# or: go install github.com/steipete/gogcli/cmd/gog@latest
```

## One-Time Setup (Google Cloud Console)

The user needs a Google Cloud project with APIs enabled:

1. Go to [Google Cloud Console](https://console.cloud.google.com/) → Create a new project
2. Enable APIs: **Google Drive API**, **Google Docs API**, **Google Sheets API**
3. Go to **APIs & Services** → **[OAuth consent screen](https://console.cloud.google.com/auth/branding)** → Set to **External** → Add your email(s) as test users
4. Go to **APIs & Services** → **[Credentials](https://console.cloud.google.com/apis/credentials)** → **Create OAuth client ID** → **Desktop app** → Download JSON

## Configure gogcli

```bash
# Store OAuth credentials (one time)
gog auth credentials /path/to/client_secret_*.json

# If on Linux/WSL/headless, switch to file keyring (avoids D-Bus issues)
gog auth keyring file
# Then set a keyring password:
export GOG_KEYRING_PASSWORD='your-password-here'
```

## Add Accounts

The same OAuth client works for ANY Google account. Authorize as many as needed:

```bash
# Interactive (opens browser)
gog auth add personal@gmail.com --services drive,sheets,docs

# Headless — manual URL flow
gog auth add personal@gmail.com --services drive,sheets,docs --manual

# Remote split flow (best for AI agents)
gog auth add personal@gmail.com --services drive,sheets,docs --remote --step 1
# → Open the URL, authorize, paste the redirect URL back:
gog auth add personal@gmail.com --services drive,sheets,docs --remote --step 2 --auth-url 'http://127.0.0.1:...'
```

Repeat for each account (work, personal, etc.) — all share the same OAuth client.

## Common Operations

### List and Search

```bash
gog drive ls --account <email> --max 20
gog drive ls --all --account <email>
gog drive search "query" --account <email>
gog drive search "mimeType = 'application/pdf'" --raw-query --account <email>
```

### Download

```bash
gog drive download <fileId> --account <email> --out ./path
```

### Read Google Doc as Markdown

```bash
gog docs export <docId> --format md --out ./doc.md
```

### Read Google Sheet

```bash
gog sheets get <spreadsheetId> 'Sheet1!A1:D20'
```

### Set Default Account

```bash
export GOG_ACCOUNT=<email>
gog drive ls   # no --account needed
```

## Keyring Note

If the system has an unavailable D-Bus SecretService (common on Linux/WSL), gogcli must use the **file** keyring backend:

```bash
gog auth keyring file
export GOG_KEYRING_PASSWORD='your-password'
```

Add the export to `~/.zshrc` or `~/.bashrc` so it persists.

## Troubleshooting

- **"Test user not added"** — Add the email at [OAuth consent screen](https://console.cloud.google.com/auth/branding)
- **"Integrity check failed"** — `GOG_KEYRING_PASSWORD` changed between commands; use a consistent password
- **"Refresh token expired"** — Re-run `gog auth add <email> --force-consent` (7-day expiry in Testing mode)
- **Need more services** — Pass `--services gmail,drive,calendar,sheets,docs,contacts` etc.

## Full Reference

See `{baseDir}/../AGENTS-GUIDE.md` for complete documentation.
