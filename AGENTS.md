# gogcli — Google Workspace CLI Agent Guide

[gogcli](https://github.com/steipete/gogcli) is a CLI for Google Drive, Docs, Sheets, Gmail, Calendar, and more. This guide helps AI agents use it.

## Quick Reference

```bash
# Keyring password is required (file keyring backend)
export GOG_KEYRING_PASSWORD='your-password'

# List files
gog drive ls --account <email> --max 10

# Search
gog drive search "query" --account <email>

# Download
gog drive download <fileId> --account <email> --out ./file.pdf

# Read Google Doc as markdown
gog docs export <docId> --format md --out ./doc.md

# Read Google Sheet
gog sheets get <spreadsheetId> 'Sheet1!A1:D20'
```

## Account Reference

- Multiple Google accounts can be authorized against the **same OAuth client**
- Switch with `--account <email>`
- Set a default: `export GOG_ACCOUNT=<email>`

## Setup on a Fresh Machine

```bash
# 1. Install
brew install gogcli

# 2. File keyring (Linux)
gog auth keyring file
echo 'export GOG_KEYRING_PASSWORD="your-password"' >> ~/.zshrc

# 3. Store credentials
gog auth credentials /path/to/client_secret.json

# 4. Add accounts (one per email)
gog auth add user@gmail.com --remote --step 1
# → authorize in browser → paste redirect URL
gog auth add user@gmail.com --remote --step 2 --auth-url '<redirect-url>'
```

## Learn More

- [gogcli GitHub](https://github.com/steipete/gogcli)
- [Quickstart](https://gogcli.sh/quickstart.html)
