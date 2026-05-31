# gogcli — Google Drive CLI Agent Guide

`gogcli` is installed and configured to access Google Drive/Docs/Sheets from the terminal with multi-account support.

## Quick Start

```bash
# Always set this before any gog command
export GOG_KEYRING_PASSWORD='gogcli-local-dev-key'

# List files
gog drive ls --account jamesjfoong2000@gmail.com --max 10
gog drive ls --account james.j.foong@gdplabs.id --max 10

# Search
gog drive search "resume" --account jamesjfoong2000@gmail.com

# Download
gog drive download <fileId> --account jamesjfoong2000@gmail.com --out ./file.pdf

# Read Google Doc as markdown
gog docs export <docId> --format md --out ./doc.md

# Read Google Sheet
gog sheets get <spreadsheetId> 'Sheet1!A1:D20'

# Set default account
export GOG_ACCOUNT=jamesjfoong2000@gmail.com
gog drive ls   # no --account needed
```

## Connected Accounts

| Email | Type | Services |
|---|---|---|
| jamesjfoong2000@gmail.com | Personal | Drive, Docs, Sheets |
| james.j.foong@gdplabs.id | Work | Drive, Docs, Sheets |

## Installing on a Fresh Machine

```bash
# 1. Install gogcli
brew install gogcli

# 2. Switch to file keyring (avoids D-Bus issues on Linux)
gog auth keyring file

# 3. Store OAuth credentials
gog auth credentials /path/to/client_secret.json

# 4. Add accounts
gog auth add jamesjfoong2000@gmail.com --remote --step 1   # get URL
gog auth add jamesjfoong2000@gmail.com --remote --step 2 --auth-url '<redirect-url>'

# 5. Export keyring password in shell config
echo 'export GOG_KEYRING_PASSWORD="gogcli-local-dev-key"' >> ~/.zshrc
```

## Notes

- Keyring backend is **file** (not keychain — D-Bus SecretService unavailable on this system)
- `GOG_KEYRING_PASSWORD` must be exported before each session or set in shell profile
- OAuth app is in **Testing** mode — refresh tokens expire after 7 days. Re-auth with `gog auth add <email> --force-consent` if needed
- Test users must be added in [GCP OAuth Consent Screen](https://console.cloud.google.com/auth/branding)
